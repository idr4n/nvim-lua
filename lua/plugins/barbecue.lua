return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = false,
    event = "BufReadPre",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
        show_navic = true,
        show_dirname = true,
        show_modified = true,
        theme = {
            basename = { fg = "#9D7CD8", bold = true },
        },
    },
}
