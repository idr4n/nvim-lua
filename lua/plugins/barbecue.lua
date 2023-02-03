return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	enabled = false,
	event = "BufReadPre",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		show_navic = true,
		show_dirname = false,
		show_modified = true,
		-- modifiers = {
		-- 	dirname = ":s?.*??",
		-- },
		theme = {
			basename = { fg = "#9D7CD8", bold = true },
		},
	},
}
