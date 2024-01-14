return {
  opts = {
    -- size = 25,
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<M-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    -- direction = "float",
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      width = math.min(math.ceil(vim.fn.winwidth(0) * 0.8), 120),
      height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 28),
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local float_opts = { height = math.floor(vim.fn.winheight(0) * 0.85) }

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, float_opts = float_opts })

    -- :Lazygit
    vim.api.nvim_create_user_command("LazyGit", function()
      if os.getenv("TERM_PROGRAM") == "tmux" then
        vim.cmd("execute 'silent !tmux split-window -v -p 80 lazygit'")
      else
        lazygit:toggle()
      end
    end, {})
    function _G.set_terminal_keymaps()
      local op = { buffer = 0 }
      -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], op)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], op)
      vim.keymap.set("t", "<C-left>", [[<Cmd>wincmd h<CR>]], op)
      vim.keymap.set("t", "<C-down>", [[<Cmd>wincmd j<CR>]], op)
      vim.keymap.set("t", "<C-up>", [[<Cmd>wincmd k<CR>]], op)
      vim.keymap.set("t", "<M-`>", [[<Cmd>wincmd k<CR>]], op)
      vim.keymap.set("n", "<M-`>", "<Cmd>wincmd j<CR>")
      vim.keymap.set("t", "<C-right>", [[<Cmd>wincmd l<CR>]], op)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], op)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
