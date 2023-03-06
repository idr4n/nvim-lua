return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "BufReadPost",
    keys = {
        { "<c-p>", "<cmd>Telescope find_files<cr>", noremap = true, silent = true },
        { "<leader>r", "<cmd>Telescope live_grep<cr>", noremap = true, silent = true },
        { "<leader>b", "<cmd>Telescope current_buffer_fuzzy_find<cr>", noremap = true, silent = true },
        { "<leader>l", "<cmd>Telescope resume<cr>", noremap = true, silent = true },
        {
            "s",
            "<cmd>lua require('telescope.builtin').buffers({ initial_mode = 'normal', sort_lastused = true })<cr>",
            noremap = true,
            silent = true,
        },
        { "<c-t>", "<cmd>Telescope oldfiles<cr>", noremap = true, silent = true },
        {
            "<leader>gs",
            "<cmd>lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<cr>",
            noremap = true,
            silent = true,
        },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", noremap = true, silent = true },
        -- { "gd", "<cmd>Telescope lsp_definitions<cr>", noremap = true, silent = true },
        -- {  "gr", "<cmd>Telescope lsp_references<cr>",  noremap = true, silent = true  },
        { "gi", "<cmd>Telescope lsp_implementations<cr>", noremap = true, silent = true },
        { "<leader>w", "<cmd>Telescope lsp_document_symbols<cr>", noremap = true, silent = true },
        { "<leader>W", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", noremap = true, silent = true },
        { "<leader>D", "<cmd>Telescope diagnostics<cr>", noremap = true, silent = true },
        { "<leader>ts", "<cmd>Telescope luasnip<cr>", noremap = true, silent = true },
        { "<leader>gr", "<cmd>Telescope registers<cr>", noremap = true, silent = true },
        { "<leader>gj", "<cmd>Telescope jumplist<cr>", noremap = true, silent = true },
        {
            "<leader>fk",
            "<cmd>lua require('telescope.builtin').keymaps({ layout_config = { width = 0.9, height = 0.5 } })<cr>",
            noremap = true,
            silent = true,
        },
        { "<leader>cc", "<cmd>lcd ~/.config/nvim | Telescope find_files<cr>", noremap = true, silent = true },
        {
            "<leader>cw",
            "<cmd>lua require('plugins.telescope.workdirs-picker').set_workdir()<CR>",
            noremap = true,
            silent = true,
        },
    },
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        {
            "benfowler/telescope-luasnip.nvim",
            module = "telescope._extensions.luasnip", -- if you wish to lazy-load
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    opts = function()
        local actions = require("telescope.actions")
        return {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    ".DS_Store",
                },

                prompt_prefix = " ",
                selection_caret = " ",

                results_title = false,

                preview = {
                    hide_on_startup = false,
                },

                winblend = 0,
                sorting_strategy = "ascending",
                layout_strategy = "flex",

                layout_config = {
                    preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                    flex = {
                        flip_columns = 120,
                    },
                    vertical = {
                        preview_cutoff = 40,
                        prompt_position = "top",
                        preview_height = 0.4,
                        width = function(_, max_columns, _)
                            return math.min(max_columns, 90)
                        end,

                        height = function(_, _, max_lines)
                            return math.min(max_lines, 40)
                        end,
                    },
                    horizontal = {
                        -- width = 0.9,
                        width = function(_, max_columns, _)
                            return math.min(max_columns, 140)
                        end,
                        -- height = 0.7,
                        height = function(_, _, max_lines)
                            return math.min(max_lines, 30)
                        end,
                        prompt_position = "top",
                        preview_width = 0.54,
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
                        ["s"] = actions.close,
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
                        "!.git",
                        "-g",
                        "!node_modules",
                        "-g",
                        "!target",
                    },
                },
                live_grep = {
                    additional_args = function()
                        return {
                            "--hidden",
                            "--follow",
                            "--no-ignore",
                            "-g",
                            "!.git",
                            "-g",
                            "!node_modules",
                            "-g",
                            "!target",
                        }
                    end,
                },
            },
            extensions = {
                ["ui-select"] = {
                    -- require("telescope.themes").get_dropdown({
                    -- 	layout_config = {
                    -- 		height = function(_, _, max_lines)
                    -- 			return math.min(max_lines, 10)
                    -- 		end,
                    -- 	},
                    require("telescope.themes").get_cursor(),
                },
            },
        }
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("luasnip")
        telescope.load_extension("ui-select")
    end,
}
