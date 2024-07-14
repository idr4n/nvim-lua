return {
  "loctvl842/monokai-pro.nvim",
  lazy = true,
  opts = {
    -- transparent_background = true,
    -- filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    background_clear = {
      "float_win",
      "telescope",
      -- "nvim-tree",
      "toggleterm",
      "trouble",
    },
    override = function(c)
      return {
        Special = { fg = c.base.magenta }, -- for HTML in tsx/jsx
        IblIndent = { fg = c.base.dimmed5 },
        IblScope = { fg = "#7E67A8" },
        Visual = { bg = "#403C7A" },
        FloatBorder = { fg = c.base.cyan, bg = "none" },
        CursorLineNr = { fg = c.base.magenta, bold = false },
        NonText = { fg = c.base.dimmed5, bg = "none" },
        -- NvimTreeNormal = { bg = c.editor.background },
        -- NvimTreeNormalNC = { bg = c.editor.background },
        NvimTreeNormalFloat = { fg = c.base.dimmed2, bg = c.base.black },
        NvimTreeFolderIcon = { fg = c.base.magenta },
      }
    end,
  },
}

-- Pro:
-- dark = "#19181a",
-- black = "#221f22",
-- blue = "#fc9867",
-- editor.background = "#2d2a2e",
-- white = "#fcfcfa",
-- red = "#ff6188",
-- yellow = "#ffd866",
-- green = "#a9dc76",
-- cyan = "#78dce8",
-- magenta = "#ab9df2",
-- dimmed1 = "#c1c0c0",
-- dimmed2 = "#939293", -- border
-- dimmed3 = "#727072",
-- dimmed4 = "#5b595c",
-- dimmed5 = "#403e41",
