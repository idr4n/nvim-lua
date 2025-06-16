return {
  "zk-org/zk-nvim",
  ft = "markdown",
  cmd = { "ZkNotes", "ZkTags", "ZkNotesDir" },
  keys = {
    { "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", silent = true, desc = "ZK Find Notes" },
    { "<leader>nn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", silent = true, desc = "ZK New Note" },
    { "<leader>nd", "<Cmd>ZkNew { dir = 'journal/daily' }<CR>", silent = true, desc = "ZK Daily Note" },
    { "<leader>nw", "<Cmd>ZkNew { dir = 'journal/weekly' }<CR>", silent = true, desc = "ZK Weekly Note" },
    { "<leader>nt", "<Cmd>ZkTag<CR>", silent = true, desc = "ZK Tags" },
    -- Search for the notes matching a given query
    {
      "<leader>nss",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      silent = true,
      desc = "ZK Search query",
    },
    -- Search for the daily and weekly notes
    { "<leader>nsd", "<Cmd>ZkNotesDir<CR>", silent = true, desc = "ZK Search Daily Notes" },
    {
      "<leader>nsw",
      "<Cmd>ZkNotesDir { dir = 'journal/weekly', title = 'Weekly Notes' }<CR>",
      silent = true,
      desc = "ZK Search Weekly Notes",
    },
  },
  config = function()
    local commands = require("zk.commands")

    commands.add("ZkNotesDir", function(options)
      options = options or {}
      local dir = options.dir or "journal/daily"
      local title = options.title or "Daily Notes"

      require("zk.api").list(nil, {
        select = { "absPath", "path", "title", "created", "modified" },
        -- sort = { "created" },
      }, function(err, notes)
        if err then
          vim.notify("Error fetching notes: " .. vim.inspect(err), vim.log.levels.ERROR)
          return
        end

        -- Filter notes after retrieval and ensure valid paths
        local filtered_notes = {}
        for _, note in ipairs(notes) do
          if note.path and type(note.path) == "string" and string.match(note.path, dir .. "/") then
            table.insert(filtered_notes, note)
          end
        end

        if #filtered_notes == 0 then
          vim.notify(string.format("No notes found in %s directory", dir), vim.log.levels.INFO)
          return
        end

        -- sort filtered notes
        table.sort(filtered_notes, function(a, b)
          return a.created > b.created
        end)

        -- Use the picker to display filtered results
        require("zk.ui").pick_notes(filtered_notes, { title = title }, function(selected_notes)
          if selected_notes and #selected_notes > 0 then
            for _, note in ipairs(selected_notes) do
              vim.cmd("edit " .. note.absPath)
            end
          end
        end)
      end)
    end)

    require("zk").setup({
      picker = "telescope",
    })
  end,
}
