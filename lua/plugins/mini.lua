return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.icons",
    -- enabled = false,
    lazy = true,
    opts = function()
      vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#28A2D4" })
      return {
        file = {
          [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          README = { glyph = "", hl = "MiniIconsYellow" },
          ["README.md"] = { glyph = "", hl = "MiniIconsYellow" },
          ["README.txt"] = { glyph = "", hl = "MiniIconsYellow" },
        },
        filetype = {
          dotenv = { glyph = "", hl = "MiniIconsYellow" },
        },
        -- extension = {
        --   lua = { glyph = "󰢱", hl = "MiniIconsCyan" },
        -- },
      }
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    {
      "echasnovski/mini.move",
      -- event = "VeryLazy",
      keys = {
        -- { "<M-down>", mode = { "n", "v" } },
        -- { "<M-up>", mode = { "n", "v" } },
        -- { "<M-left>", mode = { "n", "v" } },
        -- { "<M-right>", mode = { "n", "v" } },
        { "<M-j>", mode = { "n", "v" } },
        { "<M-k>", mode = { "n", "v" } },
        { "<M-h>", mode = { "n", "v" } },
        { "<M-l>", mode = { "n", "v" } },
      },
      -- opts = {
      --   mappings = {
      --     -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      --     left = "<M-left>",
      --     right = "<M-right>",
      --     down = "<M-down>",
      --     up = "<M-up>",
      --
      --     -- Move current line in Normal mode
      --     line_left = "<M-left>",
      --     line_right = "<M-right>",
      --     line_down = "<M-down>",
      --     line_up = "<M-up>",
      --   },
      -- },
      config = true,
    },
  },

  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "S", -- Add surrounding
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "fsr", -- Find surrounding (to the right)
        find_left = "fsl", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`
      },
    },
  },

  {
    "echasnovski/mini.tabline",
    version = false,
    cond = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_icons = false,
      format = function(buf_id, label)
        local MiniTabline = require("mini.tabline").default_format(buf_id, label)
        -- local suffix = vim.bo[buf_id].modified and "+ " or "  "
        -- return string.format("  %s%s", MiniTabline, suffix)
        return string.format(" %s ", MiniTabline)
      end,
    },
  },

  {
    "echasnovski/mini.splitjoin",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = {},
  },
}
