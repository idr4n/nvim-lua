return {
  {
    "idr4n/github-monochrome.nvim",
    dev = false,
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

        if s == "solarized" then
          hl.IblScope = { fg = "#62868C" }
        end
      end,
      -- on_colors = function(c, s)
      --   if s == "dark" then
      --     -- c.bg = "#000000"
      --     c.bg = "#012351"
      --     -- c.fg = "#F9FFFF"
      --     c.bg_statusline = c.bg
      --     c.comment = "#6E86B8"
      --   end
      -- end,

      plugins = {
        -- ["neo-tree"] = true,
      },
    },
  },
}
