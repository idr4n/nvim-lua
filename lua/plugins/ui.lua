return {
    --: indent-blankline {{{
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            -- enabled = false,
            -- show_end_of_line = true,
            -- char = "",
            -- context_char = "│",
            -- show_current_context = true,
            -- show_current_context_start = true,
            show_first_indent_level = false,
            show_trailing_blankline_indent = false,
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
    },
    --: }}},

    --: notify {{{
    {
        "rcarriga/nvim-notify",
        enabled = false,
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
    --: }}}

    --: noice {{{
    {
        "folke/noice.nvim",
        enabled = true,
        event = "VeryLazy",
        -- dependencies = {
        --     "rcarriga/nvim-notify",
        -- },
        -- stylua: ignore
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
        },
        opts = {
            routes = {
                -- Avoid all messages with kind ""
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                    },
                    opts = { skip = true },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = { enabled = true },
                signature = { enabled = true },
                progress = { enabled = false },
            },
            cmdline = {
                format = {
                    cmdline = { pattern = "^:", icon = " ", lang = "vim" },
                    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                    lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                    input = {},
                },
                opts = {
                    win_options = {
                        winhighlight = {
                            Normal = "NormalFloat",
                            FloatBorder = "FloatBorder",
                        },
                    },
                    border = { style = "none", padding = { 1, 2 } },
                },
            },
            views = {
                cmdline_popup = {
                    position = { row = 0, col = "50%" },
                    size = { width = "97%" },
                },
            },
            popupmenu = { backend = "cmp" },
            presets = {
                long_message_to_split = true,
                lsp_doc_border = true,
                -- command_palette = {
                --     views = {
                --         cmdline_popup = {
                --             position = {
                --                 row = 6,
                --             },
                --         },
                --         popupmenu = {
                --             position = {
                --                 row = 9,
                --             },
                --         },
                --     },
                -- },
            },
        },
    },
    --: }}},

    --: modes.nvim {{{
    {
        "mvllow/modes.nvim",
        event = "InsertEnter",
        enabled = false,
        opts = {
            colors = {
                copy = "#42be65",
                delete = "#ff7eb6",
                insert = "#be95ff",
                visual = "#82cfff",
            },
        },
    },
    --: }}}

    --: nvim-ufo "folding" {{{
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = { "BufReadPost", "BufNewFile" },
        -- stylua: ignore
        keys = {
            { "zR", function() require("ufo").openAllFolds() end, },
            { "zM", function() require("ufo").closeAllFolds() end, },
        },
        config = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            local ftMap = {
                markdown = "",
            }

            require("ufo").setup({
                open_fold_hl_timeout = 0,
                -- close_fold_kinds = { "imports", "regions", "comments" },
                provider_selector = function(bufnr, filetype, buftype)
                    -- return { "treesitter", "indent" }
                    return ftMap[filetype] or { "treesitter", "indent" }
                end,
            })
        end,
    },
    --: }}}

    --: statucol {{{
    {
        "luukvbaal/statuscol.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                segments = {
                    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    {
                        text = { builtin.lnumfunc, "  " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                },
            }
        end,
        config = function(_, opts)
            require("statuscol").setup(opts)
        end,
    },
    --: }}}
}
