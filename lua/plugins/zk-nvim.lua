return {
  "zk-org/zk-nvim",
  ft = "markdown",
  cmd = { "ZkNotes", "ZkTags" },
  keys = {
    { "<leader>nf", "<Cmd>ZkNotes<CR>", silent = true, desc = "ZK Search Notes" },
    { "<leader>nn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", silent = true, desc = "ZK New Note" },
    -- Search for the notes matching a given query
    {
      "<leader>ns",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      silent = true,
      desc = "ZK Search query",
    },
  },
  config = function()
    require("zk").setup({
      picker = "telescope",
      -- picker = "snacks_picker",
    })
  end,
}
