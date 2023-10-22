return {
    --: nvim-treesitter-textobjects {{{
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "LspAttach",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstallSync", "TSUninstall" },
        opts = {
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@conditional.outer",
                        ["ic"] = "@conditional.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },
                },
                lsp_interop = {
                    enable = true,
                    border = "rounded",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    --: }}}

    --: nvim-treesitter {{{
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
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
                    scope_incremental = false,
                    node_incremental = "<CR>",
                    node_decremental = "<TAB>",
                },
            },
            ensure_installed = {
                "bash",
                "cpp",
                "css",
                "elixir",
                "go",
                "html",
                "java",
                "javascript",
                "json",
                "latex",
                "lua",
                "luap",
                "markdown",
                "python",
                "regex",
                "rust",
                "tsx",
                "typescript",
                "scss",
                "svelte",
                "swift",
                "vim",
                "vue",
                "zig",
            },
            autopairs = { enable = true },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            playground = { enabled = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    --: }}}
}
