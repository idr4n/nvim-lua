return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
        -- enabled = false,
        -- show_end_of_line = true,
        -- char = "",
        -- context_char = "│",
        -- show_current_context = true,
        -- show_current_context_start = true,
        filetype_exclude = {
            "alpha",
            "NvimTree",
            "help",
            "markdown",
            "dirvish",
            "nnn",
            "packer",
            "toggleterm",
            "lsp-installer",
            "Outline",
        },
    },
}
