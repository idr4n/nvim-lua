return {
  "stevearc/oil.nvim",
  -- enabled = false,
  cmd = "Oil",
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("oil")
      end
    end
  end,
  keys = {
    -- { "<leader>-", "<cmd>Oil --float<cr>", desc = "Oil Float - Parent Dir" },
    { "s", "<cmd>Oil --float<cr>", desc = "Oil Float - Parent Dir" },
    { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },
    win_options = {
      wrap = true,
      winblend = 0,
    },
    keymaps = {
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["q"] = "actions.close",
      -- ["<leader>-"] = "actions.close",
      [";"] = "actions.select",
      ["s"] = "actions.close",
      ["Y"] = "actions.yank_entry",
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["gf"] = {
        function()
          require("telescope.builtin").find_files({
            cwd = require("oil").get_current_dir(),
          })
        end,
        mode = "n",
        nowait = true,
        desc = "Find files in the current directory with Telescope",
      },
      ["."] = {
        "actions.open_cmdline",
        opts = {
          shorten_path = true,
          -- modify = ":h",
        },
        desc = "Open the command line with the current directory as an argument",
      },
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
