return {
  -- "jose-elias-alvarez/null-ls.nvim",
  enabled = false,
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = { "mason.nvim" },
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
          disabled_filetypes = { "markdown", "html", "vue", "json" },
          extra_filetype = { "svelte" },
        }),

        -- LUA
        formatting.stylua,
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
        -- formatting.shfmt.with({ extra_filetype = { "bash", "zsh" } }),
        formatting.shfmt,
      },
    }
  end,
}
