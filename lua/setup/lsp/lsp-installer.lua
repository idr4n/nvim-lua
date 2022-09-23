local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("setup.lsp.handlers").on_attach,
		capabilities = require("setup.lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local jsonls_opts = require("setup.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("setup.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "pyright" then
		local pyright_opts = require("setup.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server.name == "jdtls" then
		-- local jdtls_opts = require("setup.lsp.settings.jdtls")
		-- opts = vim.tbl_deep_extend("force", opts, jdtls_opts)
		-- require("lspconfig").jdtls.setup(opts)

		-- the jdtls server installed by nvim-lsp-installer is being passed to nvim-jdtls plugin
		-- instead. See 'setup/jdtls.lua'
		return
	end

	if server.name == "rust_analyzer" then
		-- Initialize the LSP via rust-tools instead
		require("rust-tools").setup({
			tools = {
				autoSetHints = true,
				inlay_hints = {
					show_parameter_hints = true,
					parameter_hints_prefix = "<- ",
					other_hints_prefix = "=> ",
				},
			},
			-- The "server" property provided in rust-tools setup function are the
			-- settings rust-tools will provide to lspconfig during init.            --
			-- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
			-- with the user's own settings (opts).
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
		})
		server:attach_buffers()
		return
	end

	if server.name == "sqls" then
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

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
