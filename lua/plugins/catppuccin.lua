return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = function()
    -- local ucolors = require("catppuccin.utils.colors")
    local cp = require("catppuccin.palettes").get_palette()
    local acc_bg = "#181825"
    -- local acc_bg = cp.none
    -- local win_sep = "#24273A"
    return {
      -- transparent_background = true,
      styles = {
        functions = { "italic" },
        keywords = { "italic" },
        conditionals = {},
      },
      integrations = {
        native_lsp = {
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
      custom_highlights = {
        TSParameter = { fg = cp.maroon, style = {} },
        ["@parameter"] = { fg = cp.maroon, style = {} },
        TSInclude = { fg = cp.mauve, style = {} },
        ["@include"] = { fg = cp.mauve, style = {} },
        ["@namespace"] = { fg = cp.blue, style = {} },
        TSNamespace = { fg = cp.blue, style = {} },
        -- StatusLine = { bg = acc_bg },
        NeoTreeNormal = { bg = acc_bg },
        NeoTreeNormalNC = { bg = acc_bg },
        NotifyBackground = { bg = "#000000" },
      },
    }
  end,
}
