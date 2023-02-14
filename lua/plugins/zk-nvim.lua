return {
    "mickael-menu/zk-nvim",
    ft = "markdown",
    opts = {
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",

        lsp = {
            -- `config` is passed to `vim.lsp.start_client(config)`
            config = {
                cmd = { "zk", "lsp" },
                name = "zk",
                -- on_attach = ...
                on_attach = require("plugins.lsp.handlers").on_attach,
                capabilities = require("plugins.lsp.handlers").capabilities,
                -- etc, see `:h vim.lsp.start_client()`
            },

            -- automatically attach buffers in a zk notebook that match the given filetypes
            auto_attach = {
                enabled = true,
                filetypes = { "markdown" },
            },
        },
    },
    config = function(_, opts)
        require("zk").setup(opts)
    end,
    keys = {
        -- Create a new note after asking for its title.
        { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", noremap = true, silent = false },

        -- Open notes.
        { "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", noremap = true, silent = false },
        -- Open notes associated with the selected tags.
        { "<leader>zt", "<Cmd>ZkTags<CR>", noremap = true, silent = false },

        -- Search for the notes matching a given query.
        {
            "<leader>zf",
            "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>",
            noremap = true,
            silent = false,
        },
        -- Search for the notes matching the current visual selection.
        { "<leader>zf", ":'<,'>ZkMatch<CR>", mode = "v", noremap = true, silent = false },

        -- Open links and backlinks
        { "<leader>zb", "<Cmd>ZkBacklinks<CR>", noremap = true, silent = false },
        { "<leader>zl", "<Cmd>ZkLinks<CR>", noremap = true, silent = false },
    },
}
