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
            -- schema = { model = { default = "o3-mini-2025-01-31" } },
            schema = { model = { default = "claude-3.5-sonnet" } },
            -- schema = { model = { default = "gpt-4o-2024-08-06" } },
          })
        end,
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
    version = false,
    build = "make",
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
        { "<leader>jt", ":AvanteToggle<cr>", desc = "Avante Toggle" },
      }
    end,
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
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

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    cmd = { "CopilotChat", "CopilotChatToggle" },
    keys = {
      { "<leader>jh", ":CopilotChat ", mode = { "n", "v" }, desc = "CopilotChat Input" },
      { "<leader>jo", ":CopilotChat<cr>", mode = { "n", "v" }, desc = "CopilotChat" },
    },
    opts = {
      highlight_headers = false, -- disable if using markdown renderers (like render-markdown.nvim)
      mappings = {
        reset = {
          normal = "",
          insert = "",
        },
      },
    },
  },
}
