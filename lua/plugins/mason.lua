return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>om", "<cmd>Mason<cr> " } },
  opts = {
    ensure_installed = {
      "astro-language-server",
      "bash-language-server",
      "clangd",
      "css-lsp",
      "cssmodules-language-server",
      -- "emmet-ls",
      "flake8",
      "goimports",
      "gopls",
      "html-lsp",
      "jdtls",
      "json-lsp",
      "lua-language-server",
      "prettier",
      "pyright",
      "revive",
      "ruff-lsp",
      "rust-analyzer",
      "shfmt",
      "sqlfluff",
      "sqlls",
      "stylelint-lsp",
      "stylua",
      "svelte-language-server",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vim-language-server",
      "vue-language-server",
      "zls",
    },
    ui = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    for _, value in ipairs(opts.ensure_installed) do
      local p = mr.get_package(value)
      if not p:is_installed() then
        p:install()
      end
    end
  end,
}
