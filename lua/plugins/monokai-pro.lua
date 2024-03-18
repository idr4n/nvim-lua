return {
  "loctvl842/monokai-pro.nvim",
  lazy = true,
  opts = {
    -- transparent_background = true,
    background_clear = {
      "float_win",
      "telescope",
      -- "neo-tree",
    },
    override = function()
      local acc_bg = "#221F22"
      -- local background = "#2A2A2A"
      local background = "#1D1F21"
      return {
        Normal = { bg = background },
        NormalNC = { bg = background },
        FoldColumn = { fg = "#535353", bg = acc_bg },
        CursorLine = { bg = "#29272A" },
        CursorLineFold = { fg = "#4f4e4f", bg = acc_bg },
        CursorLineNr = { bg = "#29272A", bold = true },
        LineNr = { fg = "#676667", bg = background },
        SignColumn = { bg = background },
        LspReferenceText = { bg = "#3F3F3F" },
        LspReferenceRead = { bg = "#3F3F3F" },
        LspReferenceWrite = { bg = "#3F3F3F" },
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        -- StatusLine = { bg = acc_bg },
        StatusLine = { bg = "#111314" },
        WinSeparator = { fg = "#111314" },
        NeoTreeNormal = { bg = "#111314" },
        NeoTreeNormalNC = { bg = "#111314" },
        NeoTreeWinSeparator = { bg = "#111314" },
        NeoTreeEndOfBuffer = { bg = "#111314" },
      }
    end,
  },
}
