local diagnostic_icons = require("utils").diagnostic_icons

return {
  keys = {
    { "-", ":Neotree reveal current<CR>", desc = "Neotree current" },
    {
      "<leader>e",
      ":Neotree reveal left toggle<CR>",
      desc = "Toggle Neo-Tree",
    },
    {
      "<C-n>",
      ":Neotree reveal show left toggle<CR>",
      desc = "Toggle Neo-Tree (No focus)",
    },
    {
      "<leader>ng",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Neo-tree Git",
    },
    { "<leader>nt", ":Neotree reveal left toggle<CR>", noremap = true, silent = true, desc = "Toggle Neo-Tree" },
    { "<leader>nf", ":Neotree float reveal toggle<CR>", noremap = true, silent = true, desc = "Neo-tree Float" },
    {
      "<leader>nb",
      ":Neotree toggle show buffers right<CR>",
      desc = "Neo-tree Buffers",
    },
    {
      "<leader>ns",
      ":Neotree toggle document_symbols right<CR>",
      desc = "Doc Symbols",
    },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        padding = 1,
        with_expanders = true,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        -- default = "󰈚",
      },
      git_status = {
        symbols = {
          added = "󰜄",
          deleted = "",
          modified = "",
          renamed = "󰑕",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
      diagnostics = {
        symbols = {
          hint = diagnostic_icons.Hint,
          info = diagnostic_icons.Info,
          warn = diagnostic_icons.Warn,
          error = diagnostic_icons.Error,
        },
      },
    },
    window = {
      width = 35,
      mappings = {
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
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
        },
      },
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt.statuscolumn = ""
        end,
        id = "statuscol",
      },
    },
    sources = {
      "filesystem",
      "buffers",
      "document_symbols",
      "git_status",
    },
    document_symbols = {
      follow_cursor = true,
    },
  },
}
