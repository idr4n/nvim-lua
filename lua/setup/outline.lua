-- "simrat39/symbols-outline.nvim"

vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  relative_width = false,
  width = 45,
  position = "right",
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = { "null-ls" },
}

vim.api.nvim_set_keymap("n", "<C-F>", ":SymbolsOutline<cr>", { noremap = true, silent = true })
