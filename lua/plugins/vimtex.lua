return {
  "lervag/vimtex",
  -- enabled = false,
  ft = { "tex" },
  config = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_silent = 1
    -- vim.g.vimtex_syntax_enabled = 0
  end,
}
