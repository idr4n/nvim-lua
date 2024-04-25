return {
  "nvim-tree/nvim-tree.lua",
  -- enabled = false,
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    {
      "<C-n>",
      "<cmd>lua require('nvim-tree.api').tree.toggle({ focus = false })<CR>",
      silent = true,
      desc = "Nvimtree Toggle",
    },
    {
      "<leader>e",
      "<cmd>lua require('nvim-tree.api').tree.open()<CR>",
      silent = false,
      desc = "Nvimtree Focus window",
    },
    {
      "<leader>na",
      "<cmd>lua require('nvim-tree.api').tree.collapse_all()<CR>",
      silent = true,
      desc = "NvimTree Collapse All",
    },
    {
      "<leader>nc",
      function()
        require("nvim-tree.api").tree.collapse_all({ focus = false })
        require("nvim-tree.api").tree.find_file()
      end,
      silent = true,
      desc = "NvimTree Collapse",
    },
    {
      "<leader><Space>",
      function()
        require("nvim-tree.api").tree.close()
        require("nvim-tree.api").tree.find_file({ open = true, current_window = true })
      end,
      silent = true,
      desc = "NvimTree Open",
    },
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("nvim-tree")
      end
    end
  end,
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- remove a default mapping
      vim.keymap.del("n", "<C-t>", { buffer = bufnr })

      vim.keymap.set("n", "l", api.node.open.edit, opts("Edit Or Open"))
      vim.keymap.set("n", "h", function()
        local node = api.tree.get_node_under_cursor()
        if node.nodes ~= nil then
          api.node.navigate.parent_close()
        else
          api.node.navigate.parent()
        end
      end, opts("Go to parent or close"))
    end,

    filters = {
      dotfiles = false,
    },

    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,

    hijack_directories = {
      enable = true,
      auto_open = true,
    },

    update_focused_file = {
      enable = true,
      update_root = false,
    },

    view = {
      adaptive_size = false,
      side = "left",
      width = 32,
      preserve_window_proportions = true,
      -- signcolumn = "no",
    },

    git = {
      enable = true,
      ignore = true,
    },

    filesystem_watchers = {
      enable = true,
    },

    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = true,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = { ".git" },
      },
    },

    renderer = {
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = "none",

      indent_markers = {
        enable = true,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },
}
