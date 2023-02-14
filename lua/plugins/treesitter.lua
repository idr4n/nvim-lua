return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        autotag = {
            enable = true,
            filetypes = {
                "html",
                "javascript",
                "typescript",
                "markdown",
            },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<TAB>",
            },
        },
        ensure_installed = {
            "bash",
            "cpp",
            "css",
            "go",
            "help",
            -- "html",
            "java",
            "javascript",
            "json",
            "latex",
            "lua",
            "markdown",
            "python",
            "rust",
            "tsx",
            "typescript",
            "swift",
            "vim",
        },
        autopairs = { enable = true },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        context_commentstring = { enable = true },
        playground = { enabled = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
