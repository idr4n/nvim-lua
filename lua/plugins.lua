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
	max_jobs = 20,
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
	use("tpope/vim-vinegar")
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
	-- use({ "kyazdani42/nvim-tree.lua", config = get_setup("tree") })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = get_setup("neo-tree"),
	})
	use({ "simrat39/symbols-outline.nvim", config = get_setup("outline") })
	use({ "folke/zen-mode.nvim", config = get_setup("zen-mode") })
	use({ "folke/todo-comments.nvim", config = get_setup("todo-comments") })
	use({ "folke/trouble.nvim", config = get_setup("trouble") })
	use({
		"mg979/vim-visual-multi",
		branch = "master",
		config = get_setup("vim-visual-multi"),
	})
	use({ "akinsho/toggleterm.nvim", config = get_setup("toggleterm") })
	use({ "goolord/alpha-nvim", config = get_setup("alpha") })
	-- use({ "preservim/vim-markdown", config = get_setup("vim-markdown") })
	use({ "ixru/nvim-markdown", config = get_setup("vim-markdown") })
	use({ "luukvbaal/nnn.nvim", config = get_setup("nnn") })
	use({ "justinmk/vim-dirvish", config = get_setup("dirvish") })
	-- use({ "kristijanhusak/vim-dirvish-git" })
	use({ "tpope/vim-eunuch" })
	use({ "phaazon/hop.nvim", config = get_setup("hop") })
	use({ "kazhala/close-buffers.nvim", config = get_setup("close-buffers") })
	use({ "mickael-menu/zk-nvim", config = get_setup("zk-nvim") })
	use("dag/vim-fish")
	use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim", config = get_setup("harpoon") })
	use({ "kyazdani42/nvim-web-devicons", config = get_setup("devicons") })
	use({ "NvChad/nvim-colorizer.lua", config = get_setup("colorizer") })
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
	use({ "tpope/vim-fugitive", config = get_setup("fugitive") })
	use({ "sindrets/diffview.nvim", config = get_setup("diffview"), requires = "nvim-lua/plenary.nvim" })

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", config = get_setup("null-ls") })
	-- use({
	-- 	"filipdutescu/renamer.nvim",
	-- 	branch = "master",
	-- 	requires = { { "nvim-lua/plenary.nvim" } },
	-- 	config = get_setup("renamer"),
	-- })
	use({ "mfussenegger/nvim-jdtls", config = get_setup("jdtls") })
	-- use({ "mfussenegger/nvim-jdtls" })
	-- use({ "crispgm/nvim-go", config = get_setup("nvim-go") })
	use({ "simrat39/rust-tools.nvim", config = get_setup("rust-tools") })
	use({ "nanotee/sqls.nvim" })

	-- Statusline
	-- use({
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = get_setup("lualine"),
	-- 	event = "VimEnter",
	-- 	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	-- })
	use({
		"feline-nvim/feline.nvim",
		config = get_setup("feline"),
		after = { "zenbones.nvim", "rasmus.nvim" },
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = get_setup("bufferline"),
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
	use({
		"benfowler/telescope-luasnip.nvim",
		module = "telescope._extensions.luasnip", -- if you wish to lazy-load
	})
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	-- FZF
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use({ "junegunn/fzf.vim", config = get_setup("fzf") })
	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "kyazdani42/nvim-web-devicons" },
		config = get_setup("fzf-lua"),
	}) -- alternative to fzf.vim
	-- use({ "mfussenegger/nvim-fzy", config = get_setup("nvim-fzy") })

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
	use("nvim-treesitter/playground")

	-- Rocks from Luarocks
	-- use_rocks({ "dkjson" })

	-- Copilot
	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup()
	-- 		end, 100)
	-- 	end,
	-- })
	-- use({
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua", "nvim-cmp" },
	-- })
	-- use({ "github/copilot.vim", config = get_setup("copilot") })

	-- Colorschemes
	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim",
		config = get_setup("zenbones"),
	})
	use({ "folke/tokyonight.nvim", config = get_setup("tokyonight") })
	use({ "EdenEast/nightfox.nvim", config = get_setup("nightfox") })
	use({ "kvrohit/rasmus.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin", config = get_setup("catppuccin") })
	use({ "rebelot/kanagawa.nvim", config = get_setup("kanagawa") })
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
