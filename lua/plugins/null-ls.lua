return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = { "mason.nvim" },
	opts = function()
		local null_ls = require("null-ls")

		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		local formatting = null_ls.builtins.formatting

		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		local diagnostics = null_ls.builtins.diagnostics

		return {
			debug = false,
			sources = {
				-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
				formatting.prettier.with({
					extra_args = { "--single-quote", "--jsx-single-quote" },
					disabled_filetypes = { "markdown", "html" },
				}),
				formatting.black.with({ extra_args = { "--fast" } }),
				formatting.stylua,
				diagnostics.flake8,
				-- diagnostics.vale,
				-- diagnostics.golangci_lint,
				-- For revive, there is a ~/revive.toml config file to exclude linting rules
				diagnostics.revive,
				formatting.goimports,
				-- sqlfluff: extra config option set in ~/.sqlfluff
				-- formatting.sql_formatter.with({ extra_args = { "--keywordCase", "upper" } }),
				formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				formatting.beautysh.with({
					extra_args = { "--indent-size", "2" },
				}),
			},
		}
	end,
}
