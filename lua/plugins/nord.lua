return {
  "gbprod/nord.nvim",
  lazy = true,
  opts = function()
    return {
      styles = {
        comments = { italic = false },
      },
      on_highlights = function(hl, c)
        hl.CursorLine = { bg = "#343A46" }
        -- hl.NvimTreeNormal = { bg = nvimtree_bg }
        -- hl.NvimTreeNormalFloat = { bg = nvimtree_bg }
        -- hl.NvimTreeNormalNC = { bg = nvimtree_bg }
        hl.NvimTreeIndentMarker = { fg = c.polar_night.brightest }
        hl.RenderMarkdownH1Bg = { fg = c.aurora.green }
        hl.RenderMarkdownH2Bg = { fg = c.aurora.purple }
        hl.RenderMarkdownH3Bg = { fg = c.aurora.yellow }
        hl.RenderMarkdownH4Bg = { fg = c.aurora.orange }
        hl.RenderMarkdownH5Bg = { fg = c.aurora.orange }
        hl.RenderMarkdownH6Bg = { fg = c.aurora.orange }
        hl.RenderMarkdownCode = { bg = c.polar_night.bright }
        hl.NoiceCmdlinePopUp = { bg = "#363E4C" }
        hl.StatusLine = { bg = c.polar_night.origin }
        hl.Substitute = { bg = c.aurora.red }
        hl.BufferLineFill = { bg = c.polar_night.origin }
        hl.BufferLineIndicatorSelected = { fg = c.aurora.yellow, bg = c.polar_night.origin }
        hl.WarningMsg = { fg = c.aurora.yellow, bg = c.polar_night.origin }
        hl.ErrorMsg = { fg = c.aurora.red, bg = c.polar_night.origin }
        hl.NonText = { fg = c.polar_night.bright }
        hl.IblIndent = { fg = c.polar_night.bright }
        hl.VisualNonText = { fg = c.polar_night.light, bg = c.polar_night.brighter }
        hl.WhichKeyNormal = { bg = "#282D37" }
      end,
    }
  end,
}
