return {
  "wincent/command-t",
  enabled = false,
  build = "cd lua/wincent/commandt/lib && make",
  cmd = { "CommandT", "CommandTFind", "CommandTRipgrep" },
  keys = {
    { "<leader>a", ":CommandTRipgrep<cr>", silent = true, desc = "Find files (CmdT)" },
    -- { "<C-P>", ":CommandTRipgrep<cr>", silent = true, desc = "Find files (CmdT)" },
  },
  init = function()
    vim.g.CommandTPreferredImplementation = "lua"
  end,
  config = function()
    require("wincent.commandt").setup({
      always_show_dot_files = true,

      mappings = {
        i = { ["<C-g>"] = "close" },
        n = { ["<C-g>"] = "close" },
      },

      scanners = {
        file = {
          max_files = 100000,
        },
        find = {
          max_files = 100000,
        },
        rg = {
          max_files = 1000000,
        },
      },
      -- selection_highlight = "CursorLine",
    })
  end,
}
