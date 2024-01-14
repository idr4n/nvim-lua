return {
  config = function()
    -- calculate window width and height in columns
    local function calcWinSize()
      return {
        width = math.min(math.ceil(vim.fn.winwidth(0) * 0.8), 170),
        -- height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 30),
        height = 0.8,
      }
    end

    -- settings
    -- vim.g.fzf_layout = { down = "40%" }
    vim.g.fzf_preview_window = { "right:45%", "ctrl-l" }
    -- vim.g.fzf_preview_window = { "right:50%:hidden", "ctrl-l" }
    -- vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height, yoffset = 0.45 } }
    vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height } }
    -- vim.g.fzf_preview_window = { "up:40%", "ctrl-l" }

    -- Recalculate fzf window size on Window resize
    local function recalcWinSize()
      vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height } }
    end

    vim.api.nvim_create_augroup("fzf", { clear = true })
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = { "*" },
      callback = recalcWinSize,
      group = "fzf",
    })

    -- colors
    vim.g.fzf_colors = {
      ["fg"] = { "fg", "Normal" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Comment" },
      ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
      ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["border"] = { "fg", "Statement" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Exception" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
    }

    -- Default command
    vim.env.FZF_DEFAULT_COMMAND =
      "rg --files --hidden --follow --no-ignore -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'"

    -- exlclude file name from fuzzy matching in Rg command
    vim.cmd([[
      command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --column --hidden --line-number --no-heading --color=always --smart-case -g "!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}" '
      \ . (len(<q-args>) > 0 ? <q-args> : '""'), 0,
      \ fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=2..', '--layout=reverse', '--info=inline']}), <bang>0)
    ]])

    -- add preview to Blines
    vim.cmd([[
      command! -bang -nargs=* BLines
      \ call fzf#vim#grep(
      \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
      \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%', 'ctrl-l'))
    ]])
  end,
}
