-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " "

-- get config file function
local function get_setup(name)
	-- return string.format('require("setup.%s")', name)
	return function()
		local plugin = string.format("setup.%s", name)
		require(plugin)
	end
end

-- Install your plugins here
require("lazy").setup({
	-- General
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	{ "windwp/nvim-autopairs", config = get_setup("nvim-autopairs") },
	"tpope/vim-surround",
	"michaeljsmith/vim-indent-object",
	"tpope/vim-unimpaired",
	"tpope/vim-repeat",
	-- "tpope/vim-commentary",
	"tpope/vim-vinegar",
	"moll/vim-bbye",
	"aymericbeaumet/vim-symlink",
	"dag/vim-fish",
	{ "mattn/emmet-vim", config = get_setup("emmet-vim") },
	-- { "rmagatti/auto-session", config = get_setup("auto-session") },
	-- {
	-- 	"rmagatti/session-lens",
	-- 	dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	-- 	config = get_setup("session"),
	-- },
	{ "lukas-reineke/indent-blankline.nvim", config = get_setup("indent-blankline") },
	-- { "kyazdani42/nvim-tree.lua", config = get_setup("tree") },
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v2.x",
		keys = {
			{ "<leader>a", ":Neotree reveal left toggle<CR>", desc = "NeoTree" },
			{ "<leader>u", ":Neotree focus<CR>", desc = "NeoTree" },
			{ "<leader>i", ":Neotree float reveal toggle<CR>", desc = "NeoTree" },
			{ "<leader>A", ":Neotree toggle show buffers right<CR>", desc = "NeoTree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = get_setup("neo-tree"),
	},
	-- { "simrat39/symbols-outline.nvim", config = get_setup("outline") },
	{ "folke/zen-mode.nvim", config = get_setup("zen-mode") },
	{ "folke/todo-comments.nvim", config = get_setup("todo-comments") },
	{ "folke/trouble.nvim", config = get_setup("trouble") },
	{
		"mg979/vim-visual-multi",
		branch = "master",
		config = get_setup("vim-visual-multi"),
	},
	{ "akinsho/toggleterm.nvim", config = get_setup("toggleterm") },
	{ "goolord/alpha-nvim", config = get_setup("alpha") },
	-- { "preservim/vim-markdown", config = get_setup("vim-markdown") },
	{ "ixru/nvim-markdown", config = get_setup("vim-markdown") },
	-- { "luukvbaal/nnn.nvim", config = get_setup("nnn") },
	-- { "justinmk/vim-dirvish", config = get_setup("dirvish") },
	-- { "kristijanhusak/vim-dirvish-git" },
	{ "tpope/vim-eunuch" },
	-- { "phaazon/hop.nvim", config = get_setup("hop") },
	{ "kazhala/close-buffers.nvim", config = get_setup("close-buffers") },
	{ "mickael-menu/zk-nvim", config = get_setup("zk-nvim") },
	{ "ThePrimeagen/harpoon", dependencies = "nvim-lua/plenary.nvim", config = get_setup("harpoon") },
	{ "kyazdani42/nvim-web-devicons" },
	{ "NvChad/nvim-colorizer.lua", config = get_setup("colorizer") },
	{ "ptzz/lf.vim", dependencies = "voldikss/vim-floaterm", config = get_setup("floaterm") },
	{ "ekickx/clipboard-image.nvim", config = get_setup("clipboard-image") },
	{ "numToStr/Comment.nvim", config = get_setup("comment") }, -- Easily comment stuff
	-- {
	--   "Raimondi/delimitMate",
	--   config = get_setup("delimitmate"),
	-- }

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			{
				"abecodes/tabout.nvim",
				config = get_setup("tabout"),
				dependencies = { "nvim-treesitter" }, -- or require if not used so far
			},
		},
		config = get_setup("cmp"),
	},

	-- snippets
	{ "L3MON4D3/LuaSnip", config = get_setup("luasnip") }, --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = get_setup("gitsigns"),
	},
	{ "tpope/vim-fugitive", config = get_setup("fugitive") },
	{ "sindrets/diffview.nvim", config = get_setup("diffview"), dependencies = "nvim-lua/plenary.nvim" },

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	{ "jose-elias-alvarez/null-ls.nvim", config = get_setup("null-ls") },
	-- use({
	-- 	"filipdutescu/renamer.nvim",
	-- 	branch = "master",
	-- 	dependencies = { { "nvim-lua/plenary.nvim" } },
	-- 	config = get_setup("renamer"),
	-- })
	{ "mfussenegger/nvim-jdtls", config = get_setup("jdtls") },
	-- { "mfussenegger/nvim-jdtls" },
	-- { "crispgm/nvim-go", config = get_setup("nvim-go") },
	{ "simrat39/rust-tools.nvim", config = get_setup("rust-tools") },
	{ "nanotee/sqls.nvim" },
	{ "ray-x/lsp_signature.nvim", config = get_setup("lsp_signature") },

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		config = get_setup("lualineTwo"),
		event = "VimEnter",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},
	-- use({
	-- 	"feline-nvim/feline.nvim",
	-- 	config = get_setup("feline"),
	-- 	after = { "zenbones.nvim", "rasmus.nvim" },
	-- })
	-- use({
	-- 	"akinsho/bufferline.nvim",
	-- 	tag = "v2.*",
	-- 	dependencies = "kyazdani42/nvim-web-devicons",
	-- 	config = get_setup("bufferline"),
	-- })

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = get_setup("telescope"),
	},
	{
		"benfowler/telescope-luasnip.nvim",
		module = "telescope._extensions.luasnip", -- if you wish to lazy-load
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- FZF
	{ "junegunn/fzf", build = ":call fzf#install()" },
	{ "junegunn/fzf.vim", config = get_setup("fzf") },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = get_setup("fzf-lua"),
	}, -- alternative to fzf.vim
	-- { "mfussenegger/nvim-fzy", config = get_setup("nvim-fzy") },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = get_setup("treesitter"),
	},
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = get_setup("textobjects"),
	},
	"nvim-treesitter/playground",
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Rocks from Luarocks
	-- use_rocks({ "dkjson" })

	-- Colorschemes
	{
		"mcchrish/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		config = get_setup("zenbones"),
	},
	{ "folke/tokyonight.nvim", config = get_setup("tokyonight") },
	{ "EdenEast/nightfox.nvim", config = get_setup("nightfox") },
	{ "kvrohit/rasmus.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", config = get_setup("catppuccin") },
	{ "rebelot/kanagawa.nvim", config = get_setup("kanagawa") },
	{ "rose-pine/neovim", config = get_setup("rose-pine") },
	{ "sainnhe/sonokai", config = get_setup("sonokai") },
	-- {
	--   "RRethy/nvim-base16",
	--   config = get_setup("nvim-base16"),
	-- },
})
