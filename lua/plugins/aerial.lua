return {
  "stevearc/aerial.nvim",
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ta", "<cmd>AerialToggle<cr>", desc = "Aerial Toggle" },
    { "<leader>tn", "<cmd>AerialNavToggle<cr>", desc = "Aerial Nav Toggle" },
  },
  opts = {
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    show_guides = true,
    layout = {
      resize_to_content = false,
      max_width = { 40, 0.3 },
      width = 32,
      default_direction = "prefer_left",
      win_opts = {
        signcolumn = "yes",
        statuscolumn = " ",
      },
    },
    highlight_on_hover = false,
    autojump = true,
    icons = require("utils").lazyvim_icons,
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
      -- "Variable",
    },
    guides = {
      mid_item = "├╴",
      last_item = "└╴",
      nested_top = "│ ",
      whitespace = "  ",
    },
    nav = {
      preview = true,
    },
  },
}
