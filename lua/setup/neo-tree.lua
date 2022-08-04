--  "nvim-neo-tree/neo-tree.nvim",

local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neotree.setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_diagnostics = false,
	default_component_configs = {
		indent = {
			padding = 0,
			with_expanders = false,
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			default = "",
		},
		git_status = {
			symbols = {
				added = "ﰂ",
				deleted = "",
				modified = "",
				renamed = "➜",
				untracked = "★",
				ignored = "◌",
				unstaged = "✗",
				staged = "✓",
				conflict = "",
			},
		},
	},
	window = {
		width = 25,
		mappings = {
			["o"] = "open",
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
		follow_current_file = true,
		hijack_netrw_behavior = "disabled",
		use_libuv_file_watcher = true,
	},
	git_status = {
		window = {
			position = "float",
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
	},
})

-- Mappings

local opts = { noremap = true, silent = true }

-- vim.api.nvim_set_keymap("n", "<leader>a", ":Neotree show left toggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>a", ":Neotree reveal left toggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>u", ":Neotree focus<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>i", ":Neotree float reveal toggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>A", ":Neotree toggle show buffers right<CR>", opts)
