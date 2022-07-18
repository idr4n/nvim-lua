-- 'nanotee/sqls.nvim'

-- the server was installed manually with go install github.com/lighttiger2505/sqls@latest
-- couldn't make it work if installed with nvim-lsp-installer

require("lspconfig").sqls.setup({
	on_attach = function(client, bufnr)
		require("setup.lsp.handlers").on_attach(client, bufnr)
		require("sqls").on_attach(client, bufnr)
	end,
	capabilities = require("setup.lsp.handlers").capabilities,
	settings = {
		sqls = {
			connections = {
				{
					driver = "postgresql",
					dataSourceName = "host=127.0.0.1 port=5432 user=iduran dbname=test",
				},
				{
					driver = "postgresql",
					dataSourceName = "host=127.0.0.1 port=5432 user=iduran",
				},
			},
		},
	},
})
