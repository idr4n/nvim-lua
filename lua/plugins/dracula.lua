local colors = {
  -- bg = "#22212C",
  bg = "#282A36",
  bg_light = "#2E2B3B",
  bg_lighter = "#393649",
  bright_blue = "#D6ACFF",
  bright_cyan = "#A4FFFF",
  bright_green = "#69FF94",
  bright_magenta = "#FF92DF",
  bright_red = "#FF6E6E",
  bright_white = "#FFFFFF",
  bright_yellow = "#FFFFA5",
  comment = "#7970A9",
  cyan = "#80FFEA",
  fg = "#F8F8F2",
  green = "#8AFF80",
  gutter_fg = "#4B5263",
  menu = "#21222C",
  nontext = "#3B4048",
  orange = "#FFCA80",
  pink = "#FF80BF",
  -- purple = "#9580FF",
  purple = "#BD93F9",
  red = "#FF9580",
  -- red = "#FF5555",
  selection = "#454158",
  visual = "#3E4452",
  -- yellow = "#FFFF80",
  yellow = "#F1FA8C",
}

-- local colors_default = {
local colors = {
  bg = "#282A36",
  black = "#191A21",
  bg_light = "#2E2B3B",
  bright_blue = "#D6ACFF",
  bright_cyan = "#A4FFFF",
  bright_green = "#69FF94",
  bright_magenta = "#FF92DF",
  bright_red = "#FF6E6E",
  bright_white = "#FFFFFF",
  bright_yellow = "#FFFFA5",
  comment = "#6272A4",
  cyan = "#8BE9FD",
  fg = "#F8F8F2",
  green = "#50fa7b",
  gutter_fg = "#4B5263",
  menu = "#21222C",
  -- nontext = "#3B4048",
  nontext = "#34393F",
  orange = "#FFB86C",
  pink = "#FF79C6",
  purple = "#BD93F9",
  red = "#FF5555",
  selection = "#44475A",
  -- visual = "#3E4452",
  visual = "#463F5D",
  white = "#ABB2BF",
  yellow = "#F1FA8C",
  diffadd_bg = "#273849",
  diffadd_fg = "#B8DB87",
  diffdelete_bg = "#3A273A",
  diffdelete_fg = "#E26A75",
}

return {
  "Mofiqul/dracula.nvim",
  lazy = true,
  config = function()
    local dracula = require("dracula")

    dracula.setup({
      -- customize dracula color palette
      colors = colors,
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = false, -- default false
      -- use transparent background
      transparent_bg = false, -- default false
      -- set italic comment
      italic_comment = true, -- default false
      -- overrides the default highlights see `:h synIDattr`
      overrides = {
        -- https://github.com/Mofiqul/dracula.nvim/blob/main/lua/dracula/groups.lua
        Comment = { fg = colors.comment, italic = true },
        Constant = { fg = colors.yellow, italic = true },
        Keyword = { fg = colors.cyan, italic = true },
        DiagnosticUnderlineError = { fg = colors.red, italic = true, underline = true },
        Special = { fg = colors.pink },
        ["@keyword"] = { fg = colors.pink, italic = true },
        ["@keyword.function"] = { fg = colors.pink },
        ["@keyword.conditional"] = { fg = colors.pink, italic = true },
        ["@variable.member"] = { fg = colors.purple },
        ["@variable.parameter"] = { fg = colors.orange, italic = true },
        ["@constant"] = { fg = colors.purple, italic = true },
        ["@type"] = { fg = colors.bright_cyan, italic = true },
        ["@number"] = { fg = colors.purple, italic = true },
        ["@lsp.type.parameter"] = { fg = colors.orange, italic = true },
        NvimTreeNormal = { fg = colors.fg, bg = colors.bg_light },
        -- CmpItemAbbr = { fg = colors.white, bg = colors.bg_light },
        -- CmpItemKind = { fg = colors.white, bg = colors.bg_light },
        NormalFloat = { fg = colors.fg, bg = colors.bg_light },
        NeogitDiffAdd = { fg = colors.diffadd_fg, bg = colors.diffadd_bg },
        NeogitDiffAddHighlight = { fg = colors.diffadd_fg, bg = colors.diffadd_bg },
        NeogitDiffDelete = { fg = colors.diffdelete_fg, bg = colors.diffdelete_bg },
        NeogitDiffDeleteHighlight = { fg = colors.diffdelete_fg, bg = colors.diffdelete_bg },
        -- TelescopeNormal = { fg = colors.fg, bg = colors.bg_light },
        -- TelescopePromptBorder = { fg = colors.cyan },
        -- TelescopeResultsBorder = { fg = colors.cyan },
        -- TelescopePreviewBorder = { fg = colors.cyan },
        FloatBorder = { fg = colors.cyan },
        VertSplit = { fg = colors.cyan },
        WinSeparator = { fg = colors.cyan },
        -- LineNr = { fg = "#696B71" },
        LineNr = { fg = "#5F6166" },
        CursorLineNr = { fg = "#C9A8F9" },
      },
    })
  end,
}
