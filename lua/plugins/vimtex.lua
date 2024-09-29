return {
  "lervag/vimtex",
  -- enabled = false,
  ft = { "tex" },
  config = function()
    vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura"
    vim.g.vimtex_compiler_silent = 1
    vim.g.vimtex_syntax_enabled = 0
  end,
}
