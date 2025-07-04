return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = { "Neotree" },
  -- event = { "BufReadPost", "BufNewFile" },
  -- event = "VimEnter",
  keys = {
    {
      ",e",
      ":Neotree reveal left<CR>",
      silent = true,
      desc = "Toggle Neo-Tree",
    },
    {
      ",.",
      ":Neotree reveal show left toggle<CR>",
      silent = true,
      desc = "Toggle Neo-Tree (No focus)",
    },
  },
  opts = function()
    return {
      document_symbols = {
        follow_cursor = true,
      },
      default_component_configs = {
        indent = {
          with_markers = true,
        },
        git_status = {
          symbols = {
            -- added = "",
            -- deleted = "",
            -- modified = "",
            -- renamed = "➜",
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            untracked = "",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        hijack_netrw_behavior = "disabled",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        scan_mode = "deep", -- Scan into directories to detect empty or grouped empty directories a priori.
      },
      window = {
        width = 28,
        mappings = {
          ["<space>"] = "none",
          ["<Enter>"] = "toggle_node",
          ["<space>e"] = { "close_window", desc = "Close Neo-Tree" },
          ["o"] = "open",
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            else
              require("neo-tree.sources.filesystem.commands").open(state)
            end
          end,
        },
      },
    }
  end,
}
