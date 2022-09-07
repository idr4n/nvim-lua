local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".DS_Store",
		},

		prompt_prefix = " ",
		selection_caret = " ",

		results_title = false,

		-- sorting_strategy = "ascending",
		-- layout_strategy = "center",
		-- layout_config = {
		-- 	preview_cutoff = 1, -- Preview should always show (unless previewer = false)

		-- 	width = function(_, max_columns, _)
		-- 		return math.min(max_columns, 83)
		-- 	end,

		-- 	height = function(_, _, max_lines)
		-- 		return math.min(max_lines, 20)
		-- 	end,
		-- },

		-- border = true,
		-- borderchars = {
		-- 	prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
		-- 	results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
		-- 	preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		-- },

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
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-h>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<C-c>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

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
			-- find_command = { "fd", "--type", "f", "-L", "--hidden", "-E", ".git" },
			-- find_command = { "rg", "--files", "--hidden", "-L", "--iglob", "!.git" },
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
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
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
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("luasnip")
require("telescope").load_extension("ui-select")

-- Mappings

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- keymap("n", "<c-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<c-p>", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>r", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>l", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<c-b>", "<cmd>lua require('telescope.builtin').buffers({ initial_mode = 'normal' })<cr>", opts)
keymap("n", "s", "<cmd>lua require('telescope.builtin').buffers({ initial_mode = 'normal' })<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
-- keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
keymap("n", "<leader>w", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>W", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
keymap("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>ts", "<cmd>Telescope luasnip<cr>", opts)
keymap(
	"n",
	"<leader>fk",
	"<cmd>lua require('telescope.builtin').keymaps({ layout_config = { width = 0.9, height = 0.5 } })<cr>",
	opts
)
keymap(
	"n",
	"<leader>cc",
	-- "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.config/nvim' })<cr>",
	"<cmd>lcd ~/.config/nvim | Telescope find_files<cr>",
	opts
)
keymap("n", "<leader>cd", ":Telescope find_files cwd=", opts)
