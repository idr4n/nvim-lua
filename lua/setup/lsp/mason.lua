-- "williamboman/mason.nvim"
-- "williamboman/mason-lspconfig.nvim",

local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local servers = {
	"bashls",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"gopls",
	"html",
	"jdtls",
	"jsonls",
	"pyright",
	"rust_analyzer",
	"sqls",
	"stylelint_lsp",
	"sumneko_lua",
	"svelte",
	"tailwindcss",
	"tsserver",
	"vimls",
	"yamlls",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
	opts = {
		on_attach = require("setup.lsp.handlers").on_attach,
		capabilities = require("setup.lsp.handlers").capabilities,
	}

	if server == "jsonls" then
		local jsonls_opts = require("setup.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "sumneko_lua" then
		local sumneko_opts = require("setup.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("setup.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "jdtls" then
		goto theEnd
	end

	if server == "rust_analyzer" then
		local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
		if not rust_tools_status_ok then
			return
		end

		rust_tools.setup({
			tools = {
				autoSetHints = true,
				inlay_hints = {
					show_parameter_hints = true,
					parameter_hints_prefix = "<- ",
					other_hints_prefix = "=> ",
				},
			},
		})
		goto continue
	end

	if server == "sqls" then
		opts = {
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
							dataSourceName = "host=127.0.0.1 port=5432 user=iduran dbname=plants_dev",
						},
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
		}
	end

	::continue::
	lspconfig[server].setup(opts)
	::theEnd::
end
