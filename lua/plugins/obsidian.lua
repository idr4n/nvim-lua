return {
  "obsidian-nvim/obsidian.nvim",
  cond = function()
    local cwd = vim.fn.getcwd()
    local enabled_dirs = {
      vim.fn.expand("~/Dropbox/Notes-Database"),
    }
    return vim.tbl_contains(enabled_dirs, cwd)
  end,

  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  opts = {
    -- ui = { enable = false },
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = "~/Dropbox/Notes-Database",
        overrides = {
          notes_subdir = "00-Inbox",
        },
      },
      {
        name = "no-vault",
        path = function()
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
        overrides = {
          notes_subdir = vim.NIL,
          new_notes_location = "current_dir",
          templates = {
            subdir = vim.NIL,
          },
        },
      },
    },
    new_notes_location = "notes_subdir",
    wiki_link_func = "use_alias_only",
    frontmatter = { enabled = false },
    callbacks = {
      enter_note = function(_)
        vim.keymap.set("n", "<leader>tt", "<cmd>Obsidian toggle_checkbox<cr>", {
          buffer = true,
          desc = "Toggle checkbox",
        })
      end,
    },

    note_path_func = function(spec)
      local path = spec.dir / spec.title
      return path:with_suffix(".md")
    end,

    daily_notes = { folder = "Daily-Notes" },

    -- Templates
    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%I:%M%p",
      substitutions = {},
    },
  },
}
