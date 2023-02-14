return {
    "ekickx/clipboard-image.nvim",
    ft = "markdown",
    opts = {
        -- Default configuration for all filetype
        default = {
            img_dir = { "%:p:h", "assets" },
        },
        markdown = {
            img_dir_txt = "./assets",
        },
    },
    config = function(_, opts)
        require("clipboard-image").setup(opts)
    end,
}
