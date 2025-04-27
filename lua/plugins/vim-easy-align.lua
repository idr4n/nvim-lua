return {
  "junegunn/vim-easy-align",
  keys = {
    { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign" },
    { "<leader>pt", ":EasyAlign *|<cr>", mode = "x", desc = "Align Markdown Table" },
    { "<leader>pa", ":EasyAlign = l5", mode = "v", desc = "EasyAlign" },
  },
}
