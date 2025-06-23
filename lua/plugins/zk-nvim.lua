return {
  "zk-org/zk-nvim",
  ft = "markdown",
  cmd = { "ZkNotes", "ZkTags", "ZkNotesDir", "ZkBacklinks" },
  keys = {
    { "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", silent = true, desc = "ZK Find Notes" },
    { "<leader>nn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", silent = true, desc = "ZK New Note" },
    { "<leader>nd", "<Cmd>ZkNew { dir = 'journal/daily' }<CR>", silent = true, desc = "ZK Daily Note" },
    { "<leader>nw", "<Cmd>ZkNew { dir = 'journal/weekly' }<CR>", silent = true, desc = "ZK Weekly Note" },
    { "<leader>nt", "<Cmd>ZkTag<CR>", silent = true, desc = "ZK Tags" },
    { "<leader>nb", "<Cmd>ZkBacklinks<CR>", silent = true, desc = "ZK Backlinks" },
    -- Search for the notes matching a given query
    {
      "<leader>nss",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      silent = true,
      desc = "ZK Search query",
    },
    -- Search for the daily and weekly notes
    { "<leader>nsd", "<Cmd>ZkNotesDaily<CR>", silent = true, desc = "ZK Search Daily Notes" },
    { "<leader>nsw", "<Cmd>ZkNotesWeekly<CR>", silent = true, desc = "ZK Search Weekly Notes" },
  },
  config = function()
    local zk = require("zk")
    local zk_api = require("zk.api")
    local commands = require("zk.commands")

    local function make_edit_fn(defaults, picker_options)
      return function(options)
        options = vim.tbl_extend("force", defaults, options or {})
        zk.edit(options, picker_options)
      end
    end

    commands.add(
      "ZkNotesDaily",
      make_edit_fn({ hrefs = { "journal/daily" }, sort = { "modified" } }, { title = "Zk Daily Notes" })
    )
    commands.add(
      "ZkNotesWeekly",
      make_edit_fn({ hrefs = { "journal/weekly" }, sort = { "modified" } }, { title = "Zk Weekly Notes" })
    )

    require("zk").setup({
      picker = "telescope",
    })

    -- Initialize zk backlinks module
    require("config.statusline.zk-backlinks").setup(zk_api)
  end,
}
