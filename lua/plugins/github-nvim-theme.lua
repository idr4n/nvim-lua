return {
  "projekt0n/github-nvim-theme",
  lazy = true,
  config = function()
    require("github-theme").setup({
      options = {
        darken = {
          floats = false,
          sidebars = {
            enabled = true,
            list = { "qf", "netrw", "neotree" }, -- default is {}
          },
        },
      },
      groups = {
        github_light = {
          StatusLine = { bg = "#F1F3F5" },
          Comment = { fg = "#6A737D" },
          Delimiter = { fg = "#24292F" }, -- for punctuation ',' '.', etc
          LineNr = { fg = "#BFC0C1" },
          CursorLine = { bg = "#F6F8FA" },
          NeoTreeWinSeparator = { fg = "#FFFFFF" },
          TreesitterContext = { bg = "#FFFFFF" },
          TreesitterContextBottom = { underline = true, sp = "#24292F" },
          TelescopeNormal = { bg = "#F3F5F7" },
          TelescopeBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          TelescopeSelection = { bg = "#EDEFF1" },
          TelescopeResultsBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          TelescopePreviewTitle = { fg = "#F3F5F7", bg = "#18654B" },
          TelescopePreviewBorder = { fg = "#F3F5F7", bg = "#F3F5F7" },
          TelescopePromptNormal = { bg = "#EDEFF1" },
          TelescopePromptTitle = { fg = "#F3F5F7", bg = "#DE2C2E" },
          TelescopePromptPrefix = { fg = "#DE2C2E", bg = "#EDEFF1" },
          TelescopePromptBorder = { fg = "#EDEFF1", bg = "#EDEFF1" },
        },
      },
    })
  end,
}
