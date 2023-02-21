return {
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 3000,
            background_colour = "#000000",
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-notify",
        },
        -- stylua: ignore
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
                hover = { enabled = false },
                signature = { enabled = false },
                progress = { enabled = false },
            },
            presets = {
                long_message_to_split = true,
                command_palette = {
                    views = {
                        cmdline_popup = {
                            position = {
                                row = "30%",
                            },
                        },
                        popupmenu = {
                            position = {
                                row = "38%",
                            },
                        },
                    },
                },
            },
        },
    },
}
