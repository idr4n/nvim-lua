return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "go", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
      { "<leader>jc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
      { "<leader>jl", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion Inline Assistant" },
      { "<leader>jA", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>js", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "CodeCompanion Add Selection" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      display = {
        chat = {
          window = {
            layout = "buffer",
            width = 0.4,
            position = "left",
          },
        },
      },
      strategies = {
        chat = {
          -- adapter = "anthropic",
          -- adapter = "openai",
          adapter = "copilot",
          keymaps = {
            change_adapter = {
              modes = { n = "gA" },
            },
          },
        },
        inline = { adapter = "copilot" },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = { model = { default = "claude-sonnet-4" } },
          })
        end,
      },
    },
  },

  {
    "Aaronik/GPTModels.nvim",
    enabled = false,
    cmd = { "GPTModelsCode" },
    keys = {
      { "<leader>jg", ":GPTModelsCode<cr>", mode = { "n", "v" }, desc = "GPTModelsCode" },
      { "<leader>jG", ":GPTModelsChat<cr>", mode = { "n", "v" }, desc = "GPTModelsChat" },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
