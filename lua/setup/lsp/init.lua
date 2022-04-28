local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("setup.lsp.lsp-installer")
require("setup.lsp.handlers").setup()

-- Convert JSON filetype to JSON with comments (jsonc)
vim.cmd([[
  augroup jsonFtdetect
    autocmd!
    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup END
]])

-- Other LSP not supported by nvim-lsp-installer

require("lspconfig").vls.setup({
	on_attach = require("setup.lsp.handlers").on_attach,
	capabilities = require("setup.lsp.handlers").capabilities,
})
