return {
  "epwalsh/obsidian.nvim",
  -- enabled = false,
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- stylua: ignore
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/pCloud/Notes-Database/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/pCloud/Notes-Database/**.md",
    --   "BufReadPre " .. vim.fn.expand("~") .. "/pCloud/Notes-tdo/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/pCloud/Notes-tdo/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "~/pCloud/Notes-Database",
        overrides = {
          notes_subdir = "00-Inbox",
        },
      },
      {
        name = "work",
        path = "~/pCloud/Notes-tdo",
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
    -- ui = { enable = false },
    new_notes_location = "notes_subdir",
    wiki_link_func = "use_alias_only",
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
      ["<leader>tt"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = "Toggle check-box (Obsidian)" },
      },
    },

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@alias obsidian.Path string
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / spec.title
      return path:with_suffix(".md")
    end,

    -- Templates
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%I:%M%p",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
  },
}
