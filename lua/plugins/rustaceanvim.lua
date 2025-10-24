return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  ft = { "rust" },
  opts = {
    tools = {
      float_win_config = {
        border = "rounded",
      },
    },
    server = {
      on_attach = function(client, bufnr)
        require("config.lsp").on_attach(client, bufnr)
        vim.keymap.set("n", "<leader>ca", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action (Rust)", buffer = bufnr })
        vim.keymap.set("n", "<leader>dR", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- Enable clippy when saving
          checkOnSave = true,
          check = {
            command = "clippy",
            extraArgs = { "--no-deps" },
            allTargets = false,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  end,
}
