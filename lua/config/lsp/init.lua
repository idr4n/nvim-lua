local M = {}

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local document_highlight = vim.api.nvim_create_augroup("idr4n/LSPDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = document_highlight,
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = document_highlight,
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

--- LSP handler that adds extra inline highlights, keymaps, and window options.
--- source: https://github.com/MariaSolOs/dotfiles

local md_namespace = vim.api.nvim_create_namespace("idr4n/lsp_float")

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
  for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for pattern, hl_group in pairs({
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
      ["|%S-|"] = "@text.reference",
    }) do
      local from = 1 ---@type integer?
      while from do
        local to
        from, to = line:find(pattern, from)
        if from then
          vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
            end_col = to,
            hl_group = hl_group,
          })
        end
        from = to and to + 1 or nil
      end
    end
  end
end

---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
---@param focusable boolean
---@return fun(err: any, result: any, ctx: any, config: any)
function M.enhanced_float_handler(handler, focusable)
  return function(err, result, ctx, config)
    local bufnr, winnr = handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend("force", config or {}, {
        border = "rounded",
        focusable = focusable,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
      })
    )

    if not bufnr or not winnr then
      return
    end

    -- Conceal everything.
    vim.wo[winnr].concealcursor = "n"

    -- Extra highlights.
    add_inline_highlights(bufnr)

    -- Add keymaps for opening links.
    if focusable and not vim.b[bufnr].markdown_keys then
      vim.keymap.set("n", "K", function()
        -- Vim help links.
        local url = (vim.fn.expand("<cWORD>") --[[@as string]]):match("|(%S-)|")
        if url then
          return vim.cmd.help(url)
        end

        -- Markdown links.
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        local from, to
        from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
        if from and col >= from and col <= to then
          vim.system({ "xdg-open", url }, nil, function(res)
            if res.code ~= 0 then
              vim.notify("Failed to open URL" .. url, vim.log.levels.ERROR)
            end
          end)
        end
      end, { buffer = bufnr, silent = true })
      vim.b[bufnr].markdown_keys = true
    end
  end
end

---@param method string
local function has(client, method)
  method = method:find("/") and method or "textDocument/" .. method
  if client.supports_method(method) then
    return true
  end
  return false
end

local function lsp_keymaps(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local keys = {
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "<F2>", vim.lsp.buf.rename, desc = "LSP Rename" },
    { "<leader>cR", vim.lsp.buf.rename, desc = "LSP Rename" },
    { "<leader>cf", vim.lsp.buf.format, desc = "Format" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code Action", has = "codeAction" },
    { "<leader>cl", vim.lsp.codelens.run, mode = { "n", "v" }, desc = "Run Codelens", has = "codeLens" },
    { "<leader>cL", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", has = "codeLens" },
  }

  for _, key in pairs(keys) do
    opts.desc = key.desc
    local mode = key.mode or "n"
    if not key.has or has(client, key.has) then
      vim.keymap.set(mode, key[1], key[2], opts)
    end
  end
end

M.on_attach = function(client, bufnr)
  -- disable client specific features, e.g. to use null-ls formating instead
  local clientsNoFormat = { "tsserver", "gopls", "lua_ls", "sqlls" }
  for _, v in ipairs(clientsNoFormat) do
    if client.name == v then
      client.server_capabilities.documentFormattingProvider = false
    end
  end

  local clientsNoHover = { "tailwindcss", "cssmodules_ls", "ruff_lsp" }
  for _, v in ipairs(clientsNoHover) do
    if client.name == v then
      client.server_capabilities.hoverProvider = false
    end
  end

  -- client.server_capabilities.semanticTokensProvider = nil

  lsp_keymaps(client, bufnr)
  lsp_highlight_document(client)

  if vim.fn.has("nvim-0.10.0") == 1 then
    -- inlay_hints
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(ih) == "function" then
      ih(bufnr, true)
    elseif type(ih) == "table" and ih.enable then
      ih.enable(bufnr, true)
    end

    -- codelens
    if vim.lsp.codelens and client.supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("idr4n/LSPCodeLens", { clear = true }),
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end
end

return M
