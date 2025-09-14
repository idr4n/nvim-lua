local M = {}

---@param method string
local function has(client, method)
  method = method:find("/") and method or "textDocument/" .. method
  if client:supports_method(method) then
    return true
  end
  return false
end

local function lsp_keymaps(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local keys = {
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    -- { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "<F2>", vim.lsp.buf.rename, desc = "LSP Rename" },
    { "<leader>cR", vim.lsp.buf.rename, desc = "LSP Rename" },
    -- { "<leader>cf", vim.lsp.buf.format, desc = "Format" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-y>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
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
  local clientsNoFormat = { "ts_ls", "gopls", "lua_ls", "sqlls" }
  for _, v in ipairs(clientsNoFormat) do
    if client.name == v then
      client.server_capabilities.documentFormattingProvider = false
    end
  end

  local clientsNoHover = { "tailwindcss", "cssmodules_ls", "ruff" }
  for _, v in ipairs(clientsNoHover) do
    if client.name == v then
      client.server_capabilities.hoverProvider = false
    end
  end

  client.server_capabilities.semanticTokensProvider = nil

  lsp_keymaps(client, bufnr)

  if vim.fn.has("nvim-0.10.0") == 1 then
    -- inlay_hints
    if vim.lsp.inlay_hint and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { buffer = bufnr, desc = "Toggle inlay hints" })
    end

    -- Refresh inlay hints when file is changed externally or LSP reattaches
    vim.api.nvim_create_autocmd({ "FileChangedShellPost", "BufReadPost", "LspAttach" }, {
      buffer = bufnr,
      callback = function()
        -- Check if we still have LSP clients and inlay hints are enabled
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if #clients > 0 and vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
          -- Force refresh by toggling
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
      desc = "Refresh inlay hints after external changes or LSP reattach",
    })

    -- codelens
    -- if vim.lsp.codelens and client:supports_method("textDocument/codeLens") and vim.bo.filetype == "rust" then
    --   vim.lsp.codelens.refresh()
    --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    --     group = vim.api.nvim_create_augroup("idr4n/LSPCodeLens", { clear = true }),
    --     buffer = bufnr,
    --     callback = vim.lsp.codelens.refresh,
    --   })
    -- end
  end
end

return M
