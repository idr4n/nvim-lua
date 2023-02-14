return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    keys = {
        { "<leader>gt", "<cmd>TodoTrouble<cr>", noremap = true, silent = true },
    },
    opts = {
        highlight = {
            comments_only = false,
            after = "",
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--glob=!node_modules",
            },
        },
    },
}
