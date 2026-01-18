return {
  "nvim-tree/nvim-tree.lua",
  -- enabled = false,
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = {
    {
      "idr4n/nvim-tree-preview.lua",
      -- "b0o/nvim-tree-preview.lua",
      opts = {
        win_position = {
          ---@param tree_win number The tree window handle
          ---@param size {width: number, height: number} Desired window dimensions
          ---@return number Calculated column position
          col = function(tree_win, size)
            local tree_width = vim.fn.winwidth(tree_win)
            local total_width = vim.o.columns

            -- Get the tree side configuration
            local view = require("nvim-tree").config.view

            -- Check if nvim-tree is taking a significant portion of the screen
            local is_full_width = (tree_width / total_width) > 0.4

            if is_full_width then
              -- Place it on the right side of the tree window with a gap
              return 30
            elseif view.float.enable then
              return -1 * (size.width + 3)
            else
              -- Standard positioning based on tree side
              return view.side == "left" and tree_width + 1 or -size.width - 3
            end
          end,
        },
      },
    },
  },
  keys = {
    {
      ",.",
      function()
        require("nvim-tree.api").tree.toggle({ current_window = true })
      end,
      silent = true,
      desc = "NvimTree Open",
    },

    {
      -- "<C-n>",
      "<leader><Space>",
      "<cmd>lua require('nvim-tree.api').tree.toggle({ focus = false })<CR>",
      silent = true,
      desc = "Nvimtree Toggle",
    },
    {
      "<leader>e",
      -- ",e",
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
    -- {
    --   "<leader><Space>",
    --   function()
    --     require("nvim-tree.api").tree.toggle({ current_window = true })
    --   end,
    --   silent = true,
    --   desc = "NvimTree Open",
    -- },
  },
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

      vim.keymap.set("n", "<CR>", function()
        api.node.open.edit()
        api.tree.close_in_this_tab()
      end, opts("Open and close tree"))

      -- vim.keymap.set("n", "q", function()
      --   vim.cmd("Bdelete")
      -- end, opts("Close tree"))

      local preview = require("nvim-tree-preview")

      vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
      vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))
      vim.keymap.set("n", "<C-f>", function()
        return preview.scroll(4)
      end, opts("Scroll Down"))
      vim.keymap.set("n", "<C-b>", function()
        return preview.scroll(-4)
      end, opts("Scroll Up"))

      -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
      vim.keymap.set("n", "<Tab>", function()
        local ok, node = pcall(api.tree.get_node_under_cursor)
        if ok and node then
          if node.type == "directory" then
            api.node.open.edit()
          else
            if not preview.is_open() then
              preview.watch()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end
      end, opts("Preview"))
    end,

    filters = {
      dotfiles = false,
      git_ignored = false,
    },

    disable_netrw = false,
    hijack_netrw = false,
    hijack_cursor = true,
    sync_root_with_cwd = true,

    update_focused_file = {
      enable = true,
      update_root = false,
    },

    view = {
      adaptive_size = false,
      side = "left",
      -- side = "right",
      width = 29,
      preserve_window_proportions = true,
      signcolumn = "no",
      float = {
        -- enable = true,
        quit_on_focus_loss = false,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          -- local window_w = screen_w * 0.3
          local window_w = math.min(math.floor(screen_w * 0.28), 30)
          local window_h = screen_h * 0.9
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)

          -- adjust for the offset
          local col_right_aligned = screen_w - window_w_int - 3
          local row_offset = 1

          return {
            border = "rounded",
            relative = "editor",
            row = row_offset,
            col = col_right_aligned,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },

    git = {
      enable = true,
      ignore = true,
    },

    filesystem_watchers = {
      enable = true,
    },

    actions = {
      -- open_file = {
      --   quit_on_open = false,
      --   resize_window = true,
      -- },
      expand_all = {
        max_folder_discovery = 300,
        exclude = { ".git" },
      },
    },

    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
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
        -- diagnostics_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          diagnostics = true,
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
