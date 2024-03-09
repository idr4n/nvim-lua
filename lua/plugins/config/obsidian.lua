return {
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Sync/Notes-Database",
        overrides = {
          notes_subdir = "00-Inbox",
        },
      },
      {
        name = "work",
        path = "~/Sync/Notes-tdo",
        overrides = {
          notes_subdir = "notes",
        },
      },
      -- Usage outside of a workspace or vault
      {
        name = "no-vault",
        path = function()
          -- alternatively use the CWD:
          -- return assert(vim.fn.getcwd())
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
        overrides = {
          notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
          new_notes_location = "current_dir",
          templates = {
            subdir = vim.NIL,
          },
          disable_frontmatter = true,
        },
      },
    },
    new_notes_location = "notes_subdir",
    mappings = {
      -- Toggle check-boxes.
      ["<leader>th"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = "Toggle check-boxes" },
      },
    },
  },
}
