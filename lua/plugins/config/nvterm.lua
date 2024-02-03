local M = {}

M.keys = function(terminal)
  return {
    {
      "<C-Bslash>",
      function()
        terminal.toggle("vertical")
      end,
      mode = { "n", "t" },
      desc = "Toggle Vertical Term",
    },
    {
      "<M-\\>",
      function()
        terminal.toggle("horizontal")
      end,
      mode = { "n", "t" },
      desc = "Toggle Horizontal Term",
    },
    {
      "<C-F>",
      function()
        terminal.toggle("float")
      end,
      mode = { "n", "t" },
      desc = "Toggle Float term",
    },
    {
      "<leader>gl",
      function()
        local term = terminal.new("float")
        vim.api.nvim_chan_send(term.job_id, "lazygit\n")
      end,
      desc = "LazyGit",
    },
  }
end

M.opts = {
  terminals = {
    type_opts = {
      float = {
        relative = "editor",
        row = 0.2,
        col = 0.12,
        width = 0.76,
        height = 0.6,
        border = "single",
      },
    },
  },
}

M.setup = function()
  local ft_cmds = {
    python = "python3",
  }
  vim.keymap.set("n", "<leader>ct", function()
    if ft_cmds[vim.bo.filetype] then
      local file = vim.fn.expand("%")
      local cmd = string.format("%s %s", ft_cmds[vim.bo.filetype], file)
      require("nvterm.terminal").send(cmd, "vertical")
    end
  end, { noremap = true, silent = true, desc = "Run file in term" })

  local op = { noremap = true, silent = true }
  vim.keymap.set("t", "<C-N>", [[<C-\><C-n>]], op)
  vim.keymap.set("t", "<C-left>", [[<Cmd>wincmd h<CR>]], op)
  vim.keymap.set("t", "<C-down>", [[<Cmd>wincmd j<CR>]], op)
  vim.keymap.set("t", "<C-up>", [[<Cmd>wincmd k<CR>]], op)
  vim.keymap.set("t", "<M-`>", [[<Cmd>wincmd w<CR>]], op)
  vim.keymap.set("n", "<M-`>", "<Cmd>wincmd w<CR>")
  vim.keymap.set("t", "<C-right>", [[<Cmd>wincmd l<CR>]], op)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], op)
end

return M
