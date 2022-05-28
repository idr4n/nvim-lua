-- "mcchrish/zenbones.nvim",

local t = os.date("*t").hour + os.date("*t").min / 60
-- local term = os.getenv("TERM_PROGRAM")

-- vim.g.zenbones = { lightness = "bright" }
vim.g.zenbones = { lightness = "bright", darkness = "stark", lighten_line_nr = 30 }

-- if (t >= 7 and t < 18) and (term == 'iTerm.app' or term == 'tmux') then
if t >= 5.5 and t < 19.5 then
	vim.cmd("set background=light")
	vim.cmd("colorscheme zenbones")
	-- vim.env.BAT_THEME = "Monokai Extended Light"
	vim.env.BAT_THEME = "gruvbox-light"
else
	vim.cmd("set background=dark")
	-- vim.cmd('autocmd ColorScheme tokyobones lua require "setup.customize_zenbones"')
	-- vim.cmd("colorscheme tokyobones")
	-- vim.cmd('autocmd ColorScheme zenbones lua require "setup.customize_zenbones"')
	vim.cmd("colorscheme zenbones")
	-- vim.cmd("colorscheme rasmus")
	-- vim.cmd("colorscheme nordbones")
	-- vim.env.BAT_THEME = "gruvbox-dark"
	vim.env.BAT_THEME = "Nord"
	-- vim.env.BAT_THEME = "Nord"
end
