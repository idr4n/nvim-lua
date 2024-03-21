return {
  "rebelot/heirline.nvim",
  enabled = false,
  -- event = "BufEnter",
  event = "VeryLazy",
  opts = function()
    local colors = require("utils.status").colors
    local sl = require("utils.status.statusline")
    local tl = require("utils.status.tabline")

    local simple_status = true
    -- simple_status = false

    local StatusLines = {
      fallthrough = false,
      -- sl.HiddenStatusline,
      {
        condition = function()
          return simple_status
        end,
        fallthrough = false,
        sl.SpecialStatusline({ aligned_right = true }),
        sl.SimpleStatusline({ show_more_info = false }),
      },
      sl.SpecialStatusline({ with_delimiter = true }),
      sl.DefaultStatusline,
    }

    return {
      opts = {
        colors = colors,
        -- disable_winbar_cb = function(args)
        --   return conditions.buffer_matches({
        --     buftype = { "nofile", "prompt", "help", "quickfix" },
        --     filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
        --   }, args.buf)
        -- end,
      },
      statusline = StatusLines,
      -- winbar = { hl = "Normal", provider = "%=" }, -- empty winbar as gapbetween the tabline and the buffer
      tabline = {
        tl.TabLineOffset,
        {
          -- hl = { fg = "normal_fg", bg = "#181925" },
          -- hl = { fg = "normal_fg", bg = "normal_bg" },
          hl = { fg = "normal_fg", bg = "status_bg" },
          tl.BufferLine,
          { provider = "%=" },
        },
      },
    }
  end,
}
