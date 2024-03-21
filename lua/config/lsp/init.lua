local M = {}

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
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


-- stylua: ignore
local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local buf_keymap = function(mode, keys, cmd, options)
        options = options or {}
        options = vim.tbl_deep_extend("force", opts, options)
        vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, options)
    end

    -- buf_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    buf_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    buf_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
    buf_keymap("n", "<leader>cR", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "LSP Rename" })
    buf_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
    buf_keymap("v", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
    buf_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
    buf_keymap("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostics float" })
    buf_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
    buf_keymap( "n", "<leader>cf", ":Format<cr>", { desc = "Format" })
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
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M
