return {
  "gbprod/nord.nvim",
  lazy = true,
  opts = function()
    local nvimtree_bg = "#2A2F3A"
    local bufferline_bg = "#343A46"
    return {
      on_highlights = function(hl, c)
        hl.RenderMarkdownCode = { bg = bufferline_bg }
        hl.BufferLineSeparator = { fg = bufferline_bg, bg = bufferline_bg }
        hl.BufferLineSeparatorSelected = { fg = bufferline_bg, bg = bufferline_bg }
        hl.BufferLineSeparatorVisible = { fg = bufferline_bg, bg = bufferline_bg }
        hl.CursorLine = { bg = "#343A46" }
        hl.NvimTreeNormal = { bg = nvimtree_bg }
        hl.NvimTreeNormalFloat = { bg = nvimtree_bg }
        hl.NvimTreeNormalNC = { bg = nvimtree_bg }
        hl.NvimTreeIndentMarker = { fg = c.polar_night.brightest }
        hl.RenderMarkdownH1Bg = { bg = "", fg = c.aurora.green }
        hl.RenderMarkdownH2Bg = { bg = "", fg = c.aurora.purple }
        hl.RenderMarkdownH3Bg = { bg = "", fg = c.aurora.yellow }
        hl.RenderMarkdownH4Bg = { bg = "", fg = c.aurora.orange }
        hl.RenderMarkdownH5Bg = { bg = "", fg = c.aurora.orange }
        hl.RenderMarkdownH6Bg = { bg = "", fg = c.aurora.orange }
        hl.NoiceCmdlinePopUp = { bg = "#363E4C" }
      end,
    }
  end,
}
