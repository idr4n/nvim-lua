-- "mcchrish/zenbones.nvim",

local t = os.date("*t").hour
-- local term = os.getenv("TERM_PROGRAM")

-- vim.g.zenbones = { lightness = "bright" }
vim.g.zenbones = { lightness = "bright", darkness = "stark", lighten_line_nr = 30 }

-- if (t >= 7 and t < 18) and (term == 'iTerm.app' or term == 'tmux') then
if t >= 7 and t < 18 then
	vim.cmd("set background=light")
	vim.cmd("colorscheme zenbones")
  vim.env.BAT_THEME = "Monokai Extended Light"
else
	vim.cmd("set background=dark")
	-- vim.cmd('autocmd ColorScheme tokyobones lua require "setup.customize_zenbones"')
	-- vim.cmd("colorscheme tokyobones")
	-- vim.cmd('autocmd ColorScheme zenbones lua require "setup.customize_zenbones"')
	-- vim.cmd("colorscheme zenbones")
  vim.cmd("colorscheme nordbones")
	-- vim.cmd("colorscheme zenburned")
end
