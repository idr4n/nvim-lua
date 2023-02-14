return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
        { "<leader>vo", ":DiffviewOpen<cr>", noremap = true, silent = true },
        { "<leader>vh", ":DiffviewFileHistory %<cr>", noremap = true, silent = true },
    },
}
