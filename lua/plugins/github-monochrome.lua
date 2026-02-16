return {
  {
    "idr4n/github-monochrome.nvim",
    -- dev = false,
    lazy = true,
    priority = 1000,
    opts = {
      -- style = "dark",
      -- alternate_style = "rosepine",
      -- transparent = true,
      styles = {
        comments = { italic = false },
        -- keywords = { bold = false },
        -- functions = { bold = false },
        -- statements = { bold = false }, -- e.g., try/except statements, but also if, for, etc.
        -- sidebars = "transparent", -- "dark", "transparent" or "normal"
        -- sidebars = "dark", -- "dark", "transparent" or "normal"
        -- floats = "transparent", -- "dark", "transparent" or "normal"
      },
      on_highlights = function(hl, c, s)
        -- hl.FloatBorder = { fg = c.magenta }
        -- hl.TreesitterContext = { bg = c.none }
        -- hl.TreesitterContextBottom = { bg = c.none, underline = true, sp = c.magenta }
        hl.gitcommitSummary = { italic = false }
        hl.gitcommitFirstLine = { italic = false }
        hl.Identifier = { fg = c.magenta, bold = true }
        hl.BufferLineIndicatorSelected = { fg = c.bg, bg = c.bg }
        -- hl.Type = { bold = false }
        -- hl["@type.builtin"] = { bold = false }
        -- hl["@keyword.function"] = { bold = true }
        hl.floatermborder = { fg = c.red }
        hl.insertcursor = { bg = c.red }
        hl.MiniIndentscopeSymbol = { fg = c.magenta }

        if s == "solarized" then
          hl.IblScope = { fg = "#62868C" }
        end

        local new_bg = ""
        if s == "light" then
          -- new_bg = "#FAF9F5"
          new_bg = "#FCFBF8"
          hl.Bold = { bg = "#FDFBF8", bold = true } -- fix this in the theme
        end

        if s == "zenbones" then
          new_bg = "#000000"
          hl.Bold = { bg = "#070808", bold = true } -- fix this in the theme
        end
        hl.lualine_c_normal = { bg = c.magenta }
        hl.NormalFloat = { bg = new_bg }
        hl.FloatBoarder = { fg = c.border_highlight, bg = new_bg }
        hl.CmpBorder = { fg = c.border_highlight, bg = new_bg }
        hl.NoicePopupBorder = { bg = new_bg }
        hl.StatusLine = { bg = new_bg }
        hl.TelescopeNormal = { bg = new_bg }
        hl.TelescopeBorder = { fg = c.border_highlight, bg = new_bg }
        hl.TelescopePromptTitle = { bg = new_bg }
        hl.TelescopePromptBorder = { fg = c.border_highlight, bg = new_bg }
        hl.SnacksPickerBorder = { fg = c.border_highlight, bg = new_bg }
        hl.SnacksPickerTitle = { bg = new_bg }
        hl.SnacksPickerInputBorder = { fg = c.magenta, bg = new_bg }
        hl.NeoTreeNormal = { bg = new_bg }
        hl.NeoTreeNormalNC = { bg = new_bg }
      end,

      on_colors = function(c, s)
        -- if s == "dark" then
        --   -- c.bg = "#000000"
        --   c.bg = "#012351"
        --   -- c.fg = "#F9FFFF"
        --   c.bg_statusline = c.bg
        --   c.comment = "#6E86B8"
        -- end
        if s == "light" then
          -- c.bg = "#F1F3F2"
          -- c.bg = "#F4F4F4"
          -- c.bg = "#FAF9F5"
          c.bg = "#FCFBF8"
        end

        if s == "zenbones" then
          c.bg = "#000000"
        end
      end,

      plugins = {
        -- ["neo-tree"] = true,
      },
    },
  },
}
