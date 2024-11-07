return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>om", "<cmd>Mason<cr> " } },
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "astro-language-server",
      "bash-language-server",
      "clangd",
      "codelldb",
      "css-lsp",
      "cssmodules-language-server",
      -- "emmet-ls",
      "flake8",
      "gofumpt",
      "goimports",
      "gopls",
      "html-lsp",
      "jdtls",
      "json-lsp",
      "lua-language-server",
      "prettier",
      "pyright",
      "ruff",
      "rust-analyzer",
      "shfmt",
      "sqlfluff",
      "sqlls",
      "stylelint-lsp",
      "stylua",
      "svelte-language-server",
      "tailwindcss-language-server",
      "vim-language-server",
      "vtsls",
      -- "typescript-language-server",
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
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
