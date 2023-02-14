-- load plugins that don't need special configuration

return {
    -- Misc
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
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
    "nvim-treesitter/nvim-treesitter-context",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
