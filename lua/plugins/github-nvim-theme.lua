return {
  "projekt0n/github-nvim-theme",
  lazy = true,
  config = function()
    -- local bg_ln = "#F6F8FA"
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
          StatusLine = { bg = "#F1F3F5" },
          -- StatusLine = { bg = "NONE", style = "underline" },
          Comment = { fg = "#6A737D" },
          NonText = { fg = "#EDEFF1" },
          Delimiter = { fg = "#24292F" }, -- for punctuation ',' '.', etc
          -- LineNr = { fg = "#BFC0C1", bg = bg_ln },
          LineNr = { fg = "#BABBBD" },
          FloatBorder = { fg = "#1F2328" },
          -- NvimTreeLineNr = { bg = "#F6F8FA" },
          -- GitSignsAdd = { fg = "git.add", bg = bg_ln },
          -- GitSignsDelete = { fg = "git.removed", bg = bg_ln },
          -- GitSignsChange = { fg = "git.changed", bg = bg_ln },
          -- DiagnostictHint = { fg = "palette.fg.muted", bg = bg_ln },
          -- DiagnostictError = { fg = "palette.danger.fg", bg = bg_ln },
          -- DiagnostictInfo = { fg = "palette.accent.fg", bg = bg_ln },
          -- DiagnostictWarn = { fg = "palette.attention.fg", bg = bg_ln },
          IblIndent = { fg = "palette.neutral.muted" },
          IblScope = { fg = "palette.fg.muted" },
          -- CursorLine = { bg = "#F6F8FA" },
          -- CursorLineNr = { fg = "#9A5BFF", bg = "palette.fg.muted", style = "bold" },
          CursorLineNr = { fg = "#9A5BFF", bg = "#F6F8FA", style = "bold" },
          EndOfBuffer = { fg = "#EDEFF1" },
          WhichKeyNormal = { bg = "#F6F8FA" },
          NeoTreeWinSeparator = { fg = "#FFFFFF" },
          NeoTreeCursorLine = { bg = "#EDEFF1" },
          NvimTreeNormalFloat = { bg = "#F6F8FA" },
          NvimTreeEndOfBuffer = { fg = "#F6F8FA" },
          -- NvimTreeCursorLine = { bg = "#EDEFF1" },
          NvimTreeCursorLineNr = { bg = "#EDEFF1" },
          NvimTreeIndentMarker = { fg = "#EDEFF1" },
          NvimTreeFolderArrowClosed = { fg = "#57606A" },
          NvimTreeFolderArrowOpen = { fg = "#57606A" },
          TreesitterContext = { bg = "#FFFFFF" },
          TreesitterContextBottom = { underline = true, sp = "#24292F" },
          -- TelescopeNormal = { bg = "#F3F5F7" },
          -- TelescopeBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          TelescopeSelection = { bg = "#F3F5F7" },
          -- TelescopeResultsBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          -- TelescopePreviewTitle = { fg = "#F3F5F7", bg = "#18654B" },
          -- TelescopePreviewBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          -- TelescopePromptNormal = { bg = "#EDEFF1" },
          -- TelescopePromptTitle = { fg = "#F3F5F7", bg = "#DE2C2E" },
          -- TelescopePromptPrefix = { fg = "#DE2C2E", bg = "#EDEFF1" },
          -- TelescopePromptBorder = { fg = "#EDEFF1", bg = "#EDEFF1" },
          -- -- TelescopeSelection = { bg = "#F3F5F7" },
          TelescopeSelectionCaret = { fg = "#FF87D7" },
          TelescopeMatching = { fg = "#FF87D7" },
        },
      },
    })
  end,
}
-- -- if changing background to something else such as #FAFAFA
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#EFF0F2" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#E7EAF0" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#F3F4F6" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#F3F4F6" })
-- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#E2E5EA" })
-- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#F3F4F6" })
-- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#F3F4F6", bg = "#F3F4F6" })
