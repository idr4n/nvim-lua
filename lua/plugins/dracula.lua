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

local c = {
  bg = "#282A36",
  black = "#191A21",
  bg_light = "#2E2B3B",
  -- bg_light = "#222430",
  bright_blue = "#D6ACFF",
  bright_cyan = "#A4FFFF",
  bright_green = "#69FF94",
  bright_magenta = "#FF92DF",
  bright_red = "#FF6E6E",
  bright_white = "#FFFFFF",
  bright_yellow = "#FFFFA5",
  -- comment = "#6272A4",
  comment = "#666771",
  cyan = "#8BE9FD",
  -- fg = "#F8F8F2",
  fg = "#E9E9F4",
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
  illuminated_bg = "#544B6F",
}

return {
  "Mofiqul/dracula.nvim",
  lazy = true,
  config = function()
    local dracula = require("dracula")

    dracula.setup({
      -- customize dracula color palette
      colors = c,
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = false, -- default false
      -- use transparent background
      transparent_bg = false, -- default false
      -- set italic comment
      italic_comment = false, -- default false
      -- overrides the default highlights see `:h synIDattr`
      overrides = {
        -- https://github.com/Mofiqul/dracula.nvim/blob/main/lua/dracula/groups.lua
        Comment = { fg = c.comment, italic = false },
        CursorLine = { bg = "#2E303E" },
        BufferLineFill = { bg = "#2E303E" },
        BufferLineModifiedSelected = { fg = c.green },
        BufferLineSeparator = { fg = "#2E303E", bg = "#2E303E" },
        BufferLineSeparatorSelected = { fg = "#2E303E", bg = "#2E303E" },
        BufferLineSeparatorVisible = { fg = "#2E303E", bg = "#2E303E" },
        RenderMarkdownCode = { bg = "#2D303E" },
        Constant = { fg = c.yellow, italic = false },
        Keyword = { fg = c.cyan, italic = false },
        DiagnosticUnderlineError = { fg = c.red, italic = false, underline = false },
        Special = { fg = c.pink },
        ["@keyword"] = { fg = c.pink, italic = true },
        ["@keyword.function"] = { fg = c.pink },
        ["@keyword.conditional"] = { fg = c.pink, italic = false },
        ["@variable.member"] = { fg = c.purple },
        ["@variable.parameter"] = { fg = c.orange, italic = false },
        ["@constant"] = { fg = c.purple, italic = false },
        ["@type"] = { fg = c.bright_cyan, italic = false },
        ["@number"] = { fg = c.purple, italic = false },
        ["@lsp.type.parameter"] = { fg = c.orange, italic = false },
        NvimTreeNormal = { fg = c.fg, bg = c.bg_light },
        -- CmpItemAbbr = { fg = colors.white, bg = colors.bg_light },
        -- CmpItemKind = { fg = colors.white, bg = colors.bg_light },
        NormalFloat = { fg = c.fg, bg = c.bg_light },
        NeogitDiffAdd = { fg = c.diffadd_fg, bg = c.diffadd_bg },
        NeogitDiffAddHighlight = { fg = c.diffadd_fg, bg = c.diffadd_bg },
        NeogitDiffDelete = { fg = c.diffdelete_fg, bg = c.diffdelete_bg },
        NeogitDiffDeleteHighlight = { fg = c.diffdelete_fg, bg = c.diffdelete_bg },
        GitSignsAddPreview = { fg = c.diffadd_fg, bg = c.diffadd_bg },
        GitSignsStagedAddLn = { fg = c.diffadd_fg, bg = c.diffadd_bg },
        GitSignsUntrackedLn = { fg = c.diffadd_fg, bg = c.diffadd_bg },
        -- TelescopeNormal = { fg = colors.fg, bg = colors.bg_light },
        -- TelescopePromptBorder = { fg = colors.cyan },
        -- TelescopeResultsBorder = { fg = colors.cyan },
        -- TelescopePreviewBorder = { fg = colors.cyan },
        FloatBorder = { fg = c.cyan },
        VertSplit = { fg = c.cyan },
        WinSeparator = { fg = c.cyan },
        -- LineNr = { fg = "#696B71" },
        LineNr = { fg = "#5F6166" },
        CursorLineNr = { fg = "#C9A8F9" },
        NoiceCmdlinePopUp = { bg = "#2C2E3A" },
        illuminatedWord = { bg = c.illuminated_bg },
        illuminatedCurWord = { bg = c.illuminated_bg },
        IlluminatedWordText = { bg = c.illuminated_bg },
        IlluminatedWordRead = { bg = c.illuminated_bg },
        IlluminatedWordWrite = { bg = c.illuminated_bg },
      },
    })
  end,
}
