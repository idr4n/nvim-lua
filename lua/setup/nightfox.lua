-- "EdenEast/nightfox.nvim"

local options = {
	styles = {
		comments = "italic",
		functions = "italic,bold",
	},
}

local groups = {
	nightfox = {
		CursorLine = { bg = "#1F2A38" },
	},
	nordfox = {
		CursorLine = { bg = "#343946" },
	},
	duskfox = {
		CursorLine = { bg = "#2C2A40" },
	},
	dawnfox = {
		CursorLine = { bg = "#F2E9ED" },
	},
}

require("nightfox").setup({
	options = options,
	groups = groups,
})

-- Load the colorscheme
-- local t = os.date("*t").hour
local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 8 and t < 18 then
	-- vim.cmd("colorscheme dawnfox")
else
	-- vim.cmd("colorscheme nightfox")
	vim.cmd("colorscheme duskfox")
	-- vim.cmd("colorscheme terafox")
	-- vim.cmd("colorscheme nordfox")
end
