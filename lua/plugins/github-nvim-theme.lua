return {
  "projekt0n/github-nvim-theme",
  lazy = true,
  config = function()
    -- local bg_ln = "#F6F8FA"
    local bg = "#F4F4F4"
    local bg_accent = "#EFEFEF"
    local bg_accent1 = "#EBEBEB"
    local bg_accent2 = "#E9E9E9"
    local accent_purple = "#9A5BFF"
    local fg_light = "#7A838E"
    require("github-theme").setup({
      options = {
        hide_end_of_buffer = false,
        darken = {
          floats = false,
          sidebars = {
            enable = true,
            list = { "qf", "netrw", "neotree" }, -- default is {}
          },
        },
      },
      groups = {
        github_dark_default = {
          LineNr = { fg = "#484E55" },
          IblIndent = { fg = "palette.neutral.subtle" },
          IblScope = { fg = "palette.fg.subtle" },
          CursorLine = { bg = "#181D25" },
          StatusLine = { fg = "palette.fg.default", bg = "#181D25" },
        },
        github_dark_colorblind = {
          LineNr = { fg = "#484E55" },
        },
        github_light = {
          Normal = { bg = bg },
          NormalNC = { bg = bg },
          StatusLine = { bg = "#F1F3F5" },
          Comment = { fg = "#6A737D" },
          NonText = { fg = "#EDEFF1" },
          Delimiter = { fg = "#24292F" }, -- for punctuation ',' '.', etc
          LineNr = { fg = "#BABBBD" },
          FloatBorder = { fg = "#1F2328" },
          NormalFloat = { bg = "None" },
          IblScope = { fg = "palette.fg.muted" },
          DiagnosticUnnecessary = { fg = "None" },
          -- CursorLine = { bg = "#F6F8FA" },
          CursorLineNr = { fg = accent_purple, style = "bold" },
          EndOfBuffer = { fg = "#EDEFF1" },
          NeoTreeWinSeparator = { fg = "#FFFFFF" },
          NeoTreeCursorLine = { bg = "#EDEFF1" },
          NvimTreeNormal = { bg = bg },
          NvimTreeNormalNC = { bg = bg },
          NvimTreeNormalFloat = { bg = bg },
          NvimTreeNormalFloatNC = { bg = bg },
          NvimTreeNormalFloatBorder = { fg = accent_purple },
          NvimTreeEndOfBuffer = { fg = "#F6F8FA" },
          NvimTreeCursorLineNr = { bg = "#EDEFF1" },
          NvimTreeIndentMarker = { fg = "#EDEFF1" },
          NvimTreeFolderArrowClosed = { fg = "#57606A" },
          NvimTreeFolderArrowOpen = { fg = "#57606A" },
          TreesitterContext = { bg = bg },
          TreesitterContextBottom = { style = "underline", sp = accent_purple },
          TelescopeSelection = { bg = "#F3F5F7" },
          TelescopeSelectionCaret = { fg = "#FF87D7" },
          TelescopeMatching = { fg = "#FF87D7" },
          MiniTablineFill = { bg = bg_accent1 },
          MiniTablineCurrent = { fg = "palette.gray", bg = bg },
          MiniTablineHidden = { fg = fg_light, bg = bg_accent1 },
          MiniTablineModifiedCurrent = { fg = "palette.red", bg = bg },
          MiniTablineModifiedHidden = { fg = "palette.red", bg = bg_accent1 },
          MiniTablineModifiedVisible = { fg = "palette.red", bg = "#90C5FF" },
          RenderMarkdownCode = { bg = bg_accent1 },
          illuminatedWord = { bg = bg_accent2 },
          illuminatedCurWord = { bg = bg_accent2 },
          IlluminatedWordText = { bg = bg_accent2 },
          IlluminatedWordRead = { bg = bg_accent2 },
          IlluminatedWordWrite = { bg = bg_accent2 },
          LspInlayHint = { bg = bg_accent2 },
        },
      },
    })
  end,
}
