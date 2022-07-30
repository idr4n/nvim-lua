-- 'goolord/alpha-nvim'

-- Dashboard
local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())

-- local function button(sc, txt, keybind, keybind_opts)
--   local b = dashboard.button(sc, txt, keybind, keybind_opts)
--   b.opts.hl = "Function"
--   b.opts.hl_shortcut = "Type"
--   return b
-- end

local function pick_color()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

local function footer()
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	return datetime
		.. "   "
		.. total_plugins
		.. " plugins"
		.. "   v"
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
end

dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}
dashboard.section.header.opts.hl = pick_color()

-- dashboard.section.buttons.val = {
--   button("<C-h>", "  File Explorer"),
--   button("<C-p>", "  Find file"),
--   button("<C-t>", "  Find word"),
--   button("<Leader>a", "  Open session"),
--   button("u", "  Update plugins", ":PackerSync<CR>"),
--   button("q", "  Quit", "<Cmd>qa<CR>"),
-- }

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  Find file", ":Files<cr>"),
	-- dashboard.button("f", "  Find file", ":lua require('fzf-lua').files()<cr>"),
	-- dashboard.button("f", "  Find file", ":Telescope find_files<cr>"),
	dashboard.button("r", "  Recently used files", ":History<cr>"),
	dashboard.button("t", "  Find text", ":Rg<cr>"),
	-- dashboard.button("s", "  Open session", ":SearchSession <CR>"),
	dashboard.button("s", "  Open directory", ":lua require('setup.fzf-lua.commands').workdirs()<CR>"),
	-- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Files<cr>"),
	-- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Telescope find_files<cr>"),
	dashboard.button("c", "  Configuration", "<cmd>tcd ~/.config/nvim<cr>"),
	dashboard.button("d", "  Dotfiles", "<cmd>tcd ~/dotfiles<cr>"),
	dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- local fortune = require("alpha.fortune")
-- dashboard.section.footer.val = fortune()
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

require("alpha").setup(dashboard.opts)
