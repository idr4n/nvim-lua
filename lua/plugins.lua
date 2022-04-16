local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- get config file function
local function get_setup(name)
	return string.format('require("setup.%s")', name)
end

-- Install your plugins here
return packer.startup(function(use)
	-- General
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use({ "windwp/nvim-autopairs", config = get_setup("nvim-autopairs") })
	use("tpope/vim-surround")
	use("michaeljsmith/vim-indent-object")
	use("tpope/vim-unimpaired")
	use("tpope/vim-repeat")
	use("tpope/vim-commentary")
	use("moll/vim-bbye")
	use("aymericbeaumet/vim-symlink")
	use({
		"svermeulen/vim-easyclip",
		config = get_setup("easyclip"),
	}) -- Adds m to cut and save to clipboard or register
	use({ "mattn/emmet-vim", config = get_setup("emmet-vim") })
	-- use({ "rmagatti/auto-session", config = get_setup("auto-session") })
	-- use({
	-- 	"rmagatti/session-lens",
	-- 	requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	-- 	config = get_setup("session"),
	-- })
	use({ "lukas-reineke/indent-blankline.nvim", config = get_setup("indent-blankline") })
	use({
		"abecodes/tabout.nvim",
		config = get_setup("tabout"),
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
	})
	use({ "kyazdani42/nvim-tree.lua", config = get_setup("tree") })
	use({ "simrat39/symbols-outline.nvim", config = get_setup("outline") })
	use({ "folke/zen-mode.nvim", config = get_setup("zen-mode") })
	use({
		"mg979/vim-visual-multi",
		branch = "master",
		config = get_setup("vim-visual-multi"),
	})
	use({ "akinsho/toggleterm.nvim", config = get_setup("toggleterm") })
	use({ "goolord/alpha-nvim", config = get_setup("alpha") })
	-- use ({ "norcalli/nvim-colorizer.lua", config = get_setup("colorizer") })
	use({
		"rrethy/vim-hexokinase",
		run = "make hexokinase",
		config = get_setup("hexokinase"),
	}) -- Display colors, similar to colorizer
	use({ "preservim/vim-markdown", config = get_setup("vim-markdown") })
	use({ "luukvbaal/nnn.nvim", config = get_setup("nnn") })
	use({ "justinmk/vim-dirvish", config = get_setup("dirvish") })
	use({ "kristijanhusak/vim-dirvish-git" })
	use({ "tpope/vim-eunuch" })
	use({ "phaazon/hop.nvim", config = get_setup("hop") })
	-- use ({
	--   "numToStr/Comment.nvim",
	--   config = get_setup("comment"),
	-- }) -- Easily comment stuff
	-- use ({
	--   "Raimondi/delimitMate",
	--   config = get_setup("delimitmate"),
	-- })

	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
		},
		config = get_setup("cmp"),
	})

	-- snippets
	use({ "L3MON4D3/LuaSnip", config = get_setup("luasnip") }) --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = get_setup("gitsigns"),
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", config = get_setup("null-ls") })
	-- use ({
	--   'filipdutescu/renamer.nvim',
	--   branch = 'master',
	--   requires = { {'nvim-lua/plenary.nvim'} },
	--   config = get_setup("renamer"),
	-- })
	use({ "mfussenegger/nvim-jdtls", config = get_setup("jdtls") })
	-- use({ "mfussenegger/nvim-jdtls" })

	-- LuaLine
	use({
		"nvim-lualine/lualine.nvim",
		config = get_setup("lualine"),
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = get_setup("telescope"),
	})
	use("nvim-telescope/telescope-file-browser.nvim")

	-- FZF
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use({ "junegunn/fzf.vim", config = get_setup("fzf") })
	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "kyazdani42/nvim-web-devicons" },
		config = get_setup("fzf-lua"),
	}) -- alternative to fzf.vim

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = get_setup("treesitter"),
	})
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = get_setup("textobjects"),
	})

	-- Rocks from Luarocks
	-- use_rocks({ "dkjson" })

	-- Colorschemes
	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim",
		config = get_setup("zenbones"),
	})
	use({ "folke/tokyonight.nvim", config = get_setup("tokyonight") })
	use({ "EdenEast/nightfox.nvim", config = get_setup("nightfox") })
	-- use ({
	--   "RRethy/nvim-base16",
	--   config = get_setup("nvim-base16"),
	-- })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
