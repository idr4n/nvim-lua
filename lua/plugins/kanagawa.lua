return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  opts = {
    compile = true, -- enable compiling the colorscheme
    functionStyle = { italic = true },
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    background = {
      dark = "wave",
    },
    overrides = function(colors) -- add/modify highlights
      local theme = colors.theme
      return {
        CursorLine = { bg = "#2B2B37" },
        StatusLine = { bg = theme.ui.bg_m2 },
        StatusLineNC = { bg = theme.ui.bg_m2 },
      }
    end,
    colors = {
      theme = {
        all = { ui = { bg_gutter = "none" } },
      },
    },
  },
}
