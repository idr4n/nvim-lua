return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>jt", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Toggle" },
      { "<leader>jc", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
      { "<leader>jA", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>ja", "<cmd>CodeCompanionAdd<cr>", mode = { "v" }, desc = "CodeCompanion Add Selection" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      strategies = {
        chat = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
      },
    },
  },

  {
    "Aaronik/GPTModels.nvim",
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

  {
    "yetone/avante.nvim",
    -- enabled = false,
    build = ":AvanteBuild source=false",
    cmd = { "AvanteAsk", "AvanteToggle" },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    keys = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>a", group = "Avante AI" },
      })
      return {
        { "<leader>aa", ":AvanteAsk<cr>", mode = { "n" }, desc = "avante: ask" },
        { "<leader>at", ":AvanteToggle<cr>", mode = { "n" }, desc = "avante: toggle" },
      }
    end,
    opts = {
      windows = {
        width = 45,
      },
      -- mappings = {
      --   ask = "<leader>aa",
      --   edit = "<leader>ae",
      --   refresh = "<leader>ar",
      --   toggle = {
      --     default = "<leader>at",
      --     debug = "<leader>ad",
      --     hint = "<leader>ah",
      --   },
      -- },
    },
  },
}
