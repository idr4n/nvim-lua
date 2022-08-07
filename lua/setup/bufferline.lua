-- 'akinsho/bufferline.nvim'

require("bufferline").setup({
	options = {
		-- color_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		indicator_icon = "",
		offsets = { { filetype = "neo-tree", text = "Neo-Tree" } },
	},
	highlights = {
		buffer_selected = {
			gui = "none",
		},
	},
})
