-- load plugins that don't need special configuration

return {
    -- Misc
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "JoosepAlviste/nvim-ts-context-commentstring",
    { "tpope/vim-surround", event = "BufReadPost" },
    { "michaeljsmith/vim-indent-object", event = "BufReadPost" },
    { "tpope/vim-unimpaired", event = "BufReadPost" },
    { "tpope/vim-repeat", event = "BufReadPost" },
    { "tpope/vim-vinegar", event = "VeryLazy" },
    { "moll/vim-bbye", event = "BufReadPost" },
    { "aymericbeaumet/vim-symlink", event = "VeryLazy" },
    { "dag/vim-fish", ft = "fish" },
    { "junegunn/fzf", build = ":call fzf#install()" },
    { "mg979/vim-visual-multi", event = "VeryLazy" },
    -- { "edluffy/hologram.nvim", ft = "markdown", opts = { auto_display = true } },

    -- LSP
    "simrat39/rust-tools.nvim",
    "nanotee/sqls.nvim",

    -- Treesitter
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
}
