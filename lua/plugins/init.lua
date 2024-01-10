-- load plugins that don't need special configuration

return {
    -- Misc
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- { "tpope/vim-vinegar", event = "VeryLazy" },
    { "moll/vim-bbye", event = "BufReadPost" },
    -- { "aymericbeaumet/vim-symlink", event = "VeryLazy" },
    { "dag/vim-fish", ft = "fish" },

    -- LSP
    "simrat39/rust-tools.nvim",
    "nanotee/sqls.nvim",

    -- Treesitter
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
}
