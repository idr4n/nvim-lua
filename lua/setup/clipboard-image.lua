-- 'ekickx/clipboard-image.nvim'

require("clipboard-image").setup({
	-- Default configuration for all filetype
	default = {
		img_dir = { "%:p:h", "assets" },
	},
	markdown = {
		img_dir_txt = "./assets",
	},
})
