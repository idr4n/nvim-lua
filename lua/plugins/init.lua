-- get config file function
local function get_setup(name)
	-- return string.format('require("setup.%s")', name)
	return function()
		local plugin = string.format("setup.%s", name)
		require(plugin)
	end
end

return {
	-- Misc
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"nvim-tree/nvim-web-devicons",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "michaeljsmith/vim-indent-object", event = "BufReadPost" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	-- { "tpope/vim-vinegar", event = "VeryLazy" },
	{ "moll/vim-bbye", event = "BufReadPost" },
	{ "aymericbeaumet/vim-symlink", event = "VeryLazy" },
	{ "dag/vim-fish", ft = "fish" },
	{ "junegunn/fzf", build = ":call fzf#install()" },
	-- { "edluffy/hologram.nvim", ft = "markdown", opts = { auto_display = true } },

	-- LSP
	"simrat39/rust-tools.nvim",
	"nanotee/sqls.nvim",

	-- Treesitter
	"windwp/nvim-ts-autotag",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = get_setup("textobjects"),
	},
	"nvim-treesitter/playground",
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Colorschemes
	{
		"mcchrish/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		config = get_setup("zenbones"),
	},
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000, config = get_setup("tokyonight") },
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
}
