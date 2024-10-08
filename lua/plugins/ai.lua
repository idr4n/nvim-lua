return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
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
    },
    keys = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>ja", group = "Avante AI" },
      })
      return {
        { "<leader>jt", ":AvanteToggle<cr>", mode = { "n" }, desc = "Avante Toggle" },
      }
    end,
    opts = {
      windows = {
        width = 45,
      },
      mappings = {
        ask = "<leader>jaa",
        edit = "<leader>jae",
        refresh = "<leader>jar",
        toggle = {
          default = "<leader>jat",
          debug = "<leader>jad",
          hint = "<leader>jah",
          suggestion = "<leader>jas",
        },
      },
    },
  },
}
