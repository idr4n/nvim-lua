return {
  "nanozuki/tabby.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- vim.o.showtabline = 2
    local theme = {
      fill = "TabLineFill",
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = "TabLine",
      current_tab = "TabLineSel",
      tab = "TabLine",
      win = "TabLine",
      tail = "TabLine",
    }
    require("tabby.tabline").set(function(line)
      return {
        {
          { "  ", hl = theme.head },
          line.sep("", theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep("", hl, theme.fill),
            tab.is_current() and "" or "",
            tab.number(),
            tab.name(),
            tab.close_btn("󱎘"),
            line.sep("", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        line.spacer(),
        hl = theme.fill,
      }
    end)
  end,
}
