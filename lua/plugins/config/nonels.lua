return {
    opts = function()
        local null_ls = require("null-ls")

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = null_ls.builtins.formatting

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics

        return {
            debug = false,
            border = "rounded",
            sources = {
                -- Prettier
                -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                formatting.prettier.with({
                    extra_args = { "--single-quote", "--jsx-single-quote" },
                    disabled_filetypes = { "markdown", "html", "vue" },
                    extra_filetype = { "svelte" },
                }),

                -- Python
                -- diagnostics.flake8,
                formatting.black.with({ extra_args = { "--fast", "--preview" } }),
                formatting.ruff,
                diagnostics.ruff,

                -- LUA
                formatting.stylua.with({ "--config-path", vim.fn.expand("~/.config/stylua.toml") }),
                -- diagnostics.vale,

                -- GOLANG
                -- diagnostics.golangci_lint,
                -- For revive, there is a ~/revive.toml config file to exclude linting rules
                diagnostics.revive,
                formatting.goimports,

                -- SQL
                -- sqlfluff: extra config option set in ~/.sqlfluff
                -- formatting.sql_formatter.with({ extra_args = { "--keywordCase", "upper" } }),
                formatting.sqlfluff.with({
                    extra_args = { "--dialect", "postgres" },
                }),

                -- Bash
                formatting.beautysh.with({
                    extra_args = { "--indent-size", "2" },
                }),
            },
        }
    end,
}
