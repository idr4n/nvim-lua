return {
  "stevearc/aerial.nvim",
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ta", "<cmd>AerialToggle!<cr>", desc = "Aerial Toggle" },
  },
  opts = {
    attach_mode = "global",
    backends = { "lsp", "markdown", "asciidoc", "man" },
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
    },
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
  },
}
