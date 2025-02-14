return {
  {
    "nvim-telescope/telescope.nvim",
    -- enabled = false,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip", -- if you wish to lazy-load
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      "debugloop/telescope-undo.nvim",
    },
    keys = function()
      _G.dropdown_theme = function(opts)
        opts = vim.tbl_deep_extend("force", {
          disable_devicons = false,
          previewer = false,
          layout_config = {
            width = function(_, max_columns, _)
              return math.min(math.floor(max_columns * 0.82), 120)
            end,
            height = function(_, _, max_lines)
              return math.min(math.floor(max_lines * 0.8), 20)
            end,
          },
        }, opts or {})
        return require("telescope.themes").get_dropdown(opts)
      end

      return {
        -- {
        --   -- "<C-Space>",
        --   "<C-P>",
        --   -- "<leader>ff",
        --   function()
        --     -- require("telescope.builtin").find_files()
        --     require("telescope.builtin").find_files(dropdown_theme())
        --   end,
        --   noremap = true,
        --   silent = true,
        --   desc = "Telescope-find_files",
        -- },
        { "<leader>ot", "<cmd>Telescope resume<cr>", noremap = true, silent = true, desc = "Telescope Resume" },
        {
          "<leader>,",
          function()
            -- require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
            require("telescope.builtin").buffers(dropdown_theme({ initial_mode = "normal", sort_lastused = true }))
          end,
          noremap = true,
          silent = true,
          desc = "Switch buffers",
        },
        -- { "<leader>sh", "<cmd>Telescope help_tags<cr>", noremap = true, silent = true, desc = "Help pages" },
        {
          "<leader>sh",
          function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").help_tags({ default_text = text })
          end,
          mode = "v",
          noremap = true,
          silent = true,
          desc = "Help pages with selection",
        },
        { "<leader>os", "<cmd>Telescope luasnip theme=ivy<cr>", noremap = true, silent = true, desc = "LuaSnips" },
        {
          "<leader>lS",
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          noremap = true,
          silent = true,
          desc = "LSP workspace symbols",
        },
      }
    end,
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".DS_Store",
          },

          prompt_prefix = "  ",
          -- selection_caret = " ",
          selection_caret = "• ",

          results_title = false,

          preview = {
            hide_on_startup = false,
          },

          winblend = 0,
          sorting_strategy = "ascending",
          layout_strategy = "flex",

          layout_config = {
            preview_cutoff = 120,
            width = 0.87,
            height = 0.80,
            flex = {
              flip_columns = 120,
            },
            vertical = {
              preview_cutoff = 40,
              prompt_position = "top",
              preview_height = 0.4,
              -- width = function(_, max_columns, _)
              --     return math.min(max_columns, 90)
              -- end,

              -- height = function(_, _, max_lines)
              --     return math.min(max_lines, 40)
              -- end,
            },
            horizontal = {
              -- width = 0.9,
              -- width = function(_, max_columns, _)
              --     return math.min(max_columns, 140)
              -- end,
              -- height = function(_, _, max_lines)
              --     return math.min(max_lines, 35)
              -- end,
              prompt_position = "top",
              preview_width = 0.50,
            },
          },

          mappings = {
            i = {
              ["jk"] = { "<esc>", type = "command" },
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,
              ["<C-g>"] = {
                actions.close,
                type = "action",
                opts = { nowait = true, silent = true },
              },
              ["<C-l>"] = require("telescope.actions.layout").toggle_preview,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              -- ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-h>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<C-g>"] = actions.close,
              ["s"] = actions.close,
              ["<leader>,"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["f"] = actions.select_default,
              ["l"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              -- ["<C-t>"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = require("telescope.actions.layout").toggle_preview,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--follow",
              "--no-ignore",
              "-g",
              "!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}",
            },
          },
          live_grep = {
            additional_args = function()
              return {
                "--hidden",
                "--follow",
                "--no-ignore",
                "-g",
                "!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}",
              }
            end,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              layout_config = {
                height = function(_, _, max_lines)
                  return math.min(max_lines, 12)
                end,
              },
            }),
            -- require("telescope.themes").get_cursor(),
          },
          undo = {
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<s-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<c-r>"] = require("telescope-undo.actions").restore,
              },
              n = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<s-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<c-r>"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- dofile(vim.g.base46_cache .. "telescope")
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("luasnip")
      telescope.load_extension("ui-select")
      telescope.load_extension("undo")
    end,
  },
}
