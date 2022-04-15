-- rmagatti/session-lens

require("session-lens").setup({
  prompt_title = "Session Switcher",
})

require("telescope").load_extension("session-lens")

vim.api.nvim_set_keymap("n", "<leader>a", ":SearchSession<CR>", { noremap = true, silent = true })

