return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "sioyek" or "zathura"
    vim.g.vimtex_compiler_silent = 1
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_compiler_clean_paths = { "*.gz" }

    if vim.fn.has("linux") then
      local au_group = vim.api.nvim_create_augroup("idr4n/vimtex_events", {})

      -- Focus the terminal after inverse search
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventViewReverse",
        group = au_group,
        command = "call b:vimtex.viewer.xdo_focus_vim()",
      })
    end
  end,
}
