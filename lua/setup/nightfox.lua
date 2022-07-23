-- "EdenEast/nightfox.nvim"

local options = {
	styles = {
		comments = "italic",
		functions = "italic,bold",
	},
}

require("nightfox").setup({
	options = options,
})

-- Load the colorscheme
-- local t = os.date("*t").hour
-- local t = os.date("*t").hour + os.date("*t").min / 60

-- if t >= 8 and t < 18 then
-- 	vim.cmd("colorscheme dawnfox")
-- else
-- 	-- vim.cmd("colorscheme nightfox")
-- 	-- vim.cmd("colorscheme duskfox")
-- 	vim.cmd("colorscheme nordfox")
-- end
