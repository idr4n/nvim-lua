return {
  "folke/zen-mode.nvim",
  cmd = { "ZenMode" },
  keys = {
    { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true, desc = "Zen mode" },
  },
  opts = {
    window = {
      width = 87,
      height = 0.95,
      backdrop = 1,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        cursorcolumn = false,
      },
    },
    plugins = {
      -- gitsigns = { enabled = false },
      options = {
        laststatus = 3,
      },
    },
    on_open = function(win)
      local buffline = package.loaded["bufferline"]
      local minitabline = package.loaded["mini.tabline"]
      if buffline or minitabline then
        local view = require("zen-mode.view")
        local layout = view.layout(view.opts)
        vim.api.nvim_win_set_config(win, {
          width = layout.width,
          height = layout.height - 1,
        })
        vim.api.nvim_win_set_config(view.bg_win, {
          width = vim.o.columns,
          height = view.height() - 1,
          row = 1,
          col = layout.col,
          relative = "editor",
        })
      end
    end,
  },
}
