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
    { "-", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" },
    { "<leader>oo", "<cmd>Oil --float<cr>", desc = "Oil Float - Parent Dir" },
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
      signcolumn = "yes",
    },
    keymaps = {
      ["<C-s>"] = false,
      -- ["<C-h>"] = false,
      ["q"] = "actions.close",
      -- ["h"] = "actions.parent",
      -- ["l"] = "actions.select",
      -- ["s"] = "actions.close",
      ["Y"] = "actions.yank_entry",
      ["<C-p>"] = {
        callback = function()
          local oil = require("oil")
          -- Function to find if preview window is open
          local function find_preview_window()
            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.api.nvim_win_is_valid(winid) and vim.wo[winid].previewwindow and vim.w[winid]["oil_preview"] then
                return winid
              end
            end
            return nil
          end

          local preview_winid = find_preview_window()
          if preview_winid then
            -- Close the preview window if it's open
            vim.api.nvim_win_close(preview_winid, true)
          else
            -- Open preview if it's not open
            oil.open_preview({ vertical = true, split = "botright" }, function(err)
              if not err then
                vim.cmd("vertical resize 40")
              end
            end)
          end
        end,
        desc = "Toggle Oil preview",
      },
      ["gw"] = {
        desc = "Go to working directory",
        callback = function()
          require("oil").open(vim.fn.getcwd())
        end,
      },
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
