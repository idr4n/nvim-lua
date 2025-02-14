return {
  {
    "idr4n/github-monochrome.nvim",
    dev = false,
    -- cond = false,
    lazy = true,
    priority = 1000,
    opts = {
      style = "light",
      -- style = "dark",
      styles = {
        comments = { italic = false },
        keywords = { bold = false },
        functions = { bold = false },
        -- statements = { bold = false }, -- e.g., try/except statements, but also if, for, etc.
        sidebars = "dark",
        -- floats = "dark",
      },
      on_highlights = function(hl, c, s)
        hl.FloatBorder = { fg = c.magenta }
        hl.TreesitterContext = { bg = c.bg }
        hl.TreesitterContextBottom = { bg = c.none, underline = true, sp = c.magenta }
        hl.gitcommitSummary = { italic = false }
        hl.gitcommitFirstLine = { italic = false }
        hl.Type = { bold = false }
        hl["@type.builtin"] = { bold = false }
        hl["@keyword.function"] = { bold = true }

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
        ["neo-tree"] = false,
      },
    },
  },
}
