local M = {}

M.treesitter = {
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
                init_selection = "<C-space>",
                scope_incremental = false,
                node_incremental = "<C-space>",
                node_decremental = "<bs>",
            },
        },
        ensure_installed = {
            "bash",
            "cpp",
            "css",
            "elixir",
            "go",
            "heex",
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
            "vimdoc",
            "vue",
            "zig",
        },
        autopairs = { enable = true },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        -- context_commentstring = { enable = true, enable_autocmd = false },
        playground = { enabled = true },
    },
}

M.textobjects = {
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
}

return M
