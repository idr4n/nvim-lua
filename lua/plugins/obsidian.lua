return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- stylua: ignore
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/Sync/Notes-Database/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/Sync/Notes-Database/**.md",
    --   "BufReadPre " .. vim.fn.expand("~") .. "/Sync/Notes-tdo/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/Sync/Notes-tdo/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
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
        },
      },
    },
    new_notes_location = "notes_subdir",
    disable_frontmatter = true,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian Follow Link" },
      },
      -- Toggle check-boxes.
      ["<leader>oc"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = "Toggle check-boxes" },
      },
    },
  },
}
