-- local bg_ln = "#2F343E"
-- local bg_ln = "$bg1"

return {
  "navarasu/onedark.nvim",
  lazy = true,
  opts = {
    -- style = "darker",
    code_style = { comments = "none" },
    highlights = {
      LspInlayHint = { fg = "#7F8A9E", bg = "#2C313A" },
      IblScope = { fg = "#634E89" },
      illuminatedWord = { bg = "$bg2", fmt = "none" },
      illuminatedCurWord = { bg = "$bg2", fmt = "none" },
      IlluminatedWordText = { bg = "$bg2", fmt = "none" },
      IlluminatedWordRead = { bg = "$bg2", fmt = "none" },
      IlluminatedWordWrite = { bg = "$bg2", fmt = "none" },
      -- LazyNormal = { bg = "#1B1F27" },
      -- LazyNormal = { bg = "#1E222A" },
      FloatBorder = { fg = "$blue", bg = "NONE" },
      Folded = { fg = "$grey", bg = "NONE" },
      NormalFloat = { bg = "NONE" },
      -- MiniIndentscopeSymbol = { fg = "#525A66" },
      -- NeoTreeNormal = { bg = "#1B1F27" },
      -- NeoTreeNormalNC = { bg = "#1B1F27" },
      -- NeoTreeEndOfBuffer = { bg = "#1B1F27" },
      -- NeoTreeGitModified = { fg = "$blue" },
      -- NeoTreeGitModified = { fg = "#485A86" },
      NeoTreeWinSeparator = { fg = "$bg0", bg = "$bg0" },
      -- NvimTreeWinSeparator = { fg = "#1E222A" },
      NvimTreeWinSeparator = { fg = "$bg0" },
      NvimTreeIndentMarker = { fg = "$bg3" },
      NvimTreeFolderIcon = { fg = "$purple" },
      NvimTreeNormalFloat = { bg = "$bg_d" },
      -- FileExplorerHl = { bg = "$bg_d" },
      -- Normal = { bg = "#1E222A" },
      -- NormalNC = { bg = "#1E222A" },
      -- EndOfBuffer = { bg = "#1E222A" },
      -- Conceal = { bg = "NONE" },
      -- DiagnosticVirtualTextError = { bg = "NONE" },
      -- DiagnosticVirtualTextWarn = { bg = "NONE" },
      -- DiagnosticVirtualTextInfo = { bg = "NONE" },
      -- DiagnosticVirtualTextHint = { bg = "NONE" },
      -- CursorLine = { bg = "#282C34" },
      StatusLine = { fg = "$fg", bg = "#bg0" },
      -- LineNr = { fg = "#41454D" },
      -- LineNr = { fg = "#4A4F58" },
      -- LineNr = { fg = "#4A4F58", bg = bg_ln },
      -- CursorLineNr = { fg = "$purple", fmt = "bold" },
      CursorLineNr = { fg = "$purple" },
      NvimTreeLineNr = { bg = "$bg_d" },
      -- GitSignsAdd = { bg = bg_ln },
      -- GitSignsDelete = { bg = bg_ln },
      -- GitSignsChange = { bg = bg_ln },
      -- DiagnostictSignHint = { bg = bg_ln },
      -- DiagnostictSignError = { bg = bg_ln },
      -- DiagnostictSignInfo = { bg = bg_ln },
      -- DiagnostictSignWarn = { bg = bg_ln },
      TreesitterContext = { bg = "$bg0" },
      TreesitterContextBottom = { fmt = "underline", sp = "$purple" },
      Visual = { bg = "#3A4B5E" },
      TelescopePromptBorder = { fg = "$grey" },
      TelescopeResultsBorder = { fg = "$grey" },
      TelescopePreviewBorder = { fg = "$grey" },
      TelescopeTitle = { fg = "$grey" },
      TelescopeSelectionCaret = { fg = "#FF87D7" },
      TelescopeMatching = { fg = "#FF87D7" },
      TelescopeSelection = { bg = "$bg1" },

      NonText = { fg = "$bg1" },

      -- borderless telescope
      -- TelescopeNormal = { bg = "#1B1F27" },
      -- TelescopeBorder = { fg = "#1B1F27", bg = "#1B1F27" },
      -- TelescopeSelection = { bg = "#252931" },
      -- TelescopeResultsBorder = { fg = "#1B1F27", bg = "#1B1F27" },
      -- TelescopePreviewTitle = { fg = "#1B1F27", bg = "$green" },
      -- TelescopePreviewBorder = { fg = "#1B1F27", bg = "#1B1F27" },
      -- TelescopePromptNormal = { bg = "$bg0" },
      -- TelescopePromptTitle = { fg = "#1B1F27", bg = "$red" },
      -- TelescopePromptPrefix = { fg = "$red", bg = "$bg0" },
      -- TelescopePromptBorder = { fg = "$bg0", bg = "$bg0" },

      -- Other changes
      MiniTablineCurrent = { fg = "$fg", bg = "$bg0", fmt = "none" },
      MiniTablineVisible = { fg = "$purple", bg = "$bg3" },
      MiniTablineHidden = { fg = "$light_grey", bg = "$bg1" },
      MiniTablineModifiedCurrent = { fg = "$red", bg = "$bg0", fmt = "none" },
      RenderMarkdownCode = { bg = "$bg_d" },
      ["@module"] = { fg = "$fg" },
      ["@variable"] = { fg = "$fg" },
      ["@variable.builtin"] = { fg = "$orange" },
      ["@variable.member"] = { fg = "$red" },
      ["@type"] = { fg = "$cyan" },
      ["@type.builtin"] = { fg = "$cyan" },
      ["@constant"] = { fg = "$yellow" },
      ["@constant.builtin"] = { fg = "$yellow" },
      ["@keyword.operator"] = { fg = "$cyan" },
      SnacksPickerDir = { fg = "$grey" },
      SnacksPickerListCursorLine = { bg = "$bg2" },
      SnacksPickerMatch = { fg = "$purple" },
      SnacksPickerSelected = { fg = "$purple" },
      SnacksPickerTotals = { fg = "$grey" },
      MiniFilesNormal = { bg = "NONE" },
      MiniFilesBorder = { fg = "$blue", bg = "NONE" },
      Substitute = { bg = "$red" },
      NotifyBackground = { bg = "$bg0" },
    },
  },
  -- config = function(_, opts)
  --   vim.o.background = "dark"
  --   require("onedark").setup(opts)
  -- end,
}

-- local dark = {
--   black = "#181a1f",
--   bg0 = "#282c34",
--   bg1 = "#31353f",
--   bg2 = "#393f4a",
--   bg3 = "#3b3f4c",
--   bg_d = "#21252b",
--   bg_blue = "#73b8f1",
--   bg_yellow = "#ebd09c",
--   fg = "#abb2bf",
--   purple = "#c678dd",
--   green = "#98c379",
--   orange = "#d19a66",
--   blue = "#61afef",
--   yellow = "#e5c07b",
--   cyan = "#56b6c2",
--   red = "#e86671",
--   grey = "#5c6370",
--   light_grey = "#848b98",
--   dark_cyan = "#2b6f77",
--   dark_red = "#993939",
--   dark_yellow = "#93691d",
--   dark_purple = "#8a3fa0",
--   diff_add = "#31392b",
--   diff_delete = "#382b2c",
--   diff_change = "#1c3448",
--   diff_text = "#2c5372",
-- }
