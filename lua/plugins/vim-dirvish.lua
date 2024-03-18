return {
  "justinmk/vim-dirvish",
  -- event = "VimEnter",
  keys = { "-" },
  cmd = "Dirvish",
  enabled = false,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        vim.cmd("Dirvish")
      end
    end
  end,
  config = function()
    vim.g.dirvish_git_show_ignored = 1
    -- sort folders at the top
    vim.g.dirvish_mode = ":sort ,^.*[\\/],"
    -- use h and l to navigate back and forward
    vim.cmd([[
            augroup dirvish_mappings
                autocmd!
                autocmd FileType dirvish nnoremap <silent><buffer> l :<C-U>.call dirvish#open("edit", 0)<CR>
                autocmd FileType dirvish nnoremap <silent><buffer> h :<C-U>exe "Dirvish %:h".repeat(":h",v:count1)<CR>
            augroup END
            ]])
  end,
}
