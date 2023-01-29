return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v2.x",
	keys = {
		{ "<leader>a", ":Neotree reveal left toggle<CR>", noremap = true, silent = true },
		{ "<leader>u", ":Neotree focus<CR>", noremap = true, silent = true },
		{ "<leader>i", ":Neotree float reveal toggle<CR>", noremap = true, silent = true },
		{ "<leader>A", ":Neotree toggle show buffers right<CR>", noremap = true, silent = true },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	opts = {
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
	},
	-- config = require("setup.neo-tree"),
}
