return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 85,
            backdrop = 1,
            options = {
                number = true,
                relativenumber = false,
                signcolumn = "yes",
                cursorcolumn = false,
            },
        },
        -- plugins = {
        --	 gitsigns = { enabled = false },
        -- }
    },
    keys = {
        { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true },
    },
}
