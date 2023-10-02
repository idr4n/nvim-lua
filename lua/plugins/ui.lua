return {
    --: indent-blankline {{{
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        -- enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                show_start = false,
                show_end = false,
                include = {
                    node_type = {
                        ["*"] = {
                            "argument_list",
                            "arguments",
                            "assignment_statement",
                            "Block",
                            "chunk",
                            "class",
                            "ContainerDecl",
                            "dictionary",
                            "do_block",
                            "do_statement",
                            "element",
                            "except",
                            "FnCallArguments",
                            "for",
                            "for_statement",
                            "function",
                            "function_declaration",
                            "function_definition",
                            "if_statement",
                            "IfExpr",
                            "IfStatement",
                            "import",
                            "InitList",
                            "list_literal",
                            "method",
                            "object",
                            "ParamDeclList",
                            "repeat_statement",
                            "return_statement",
                            "selector",
                            "SwitchExpr",
                            "table",
                            "table_constructor",
                            "try",
                            "tuple",
                            "type",
                            "var",
                            "while",
                            "while_statement",
                            "with",
                        },
                    },
                },
            },
            whitespace = {
                remove_blankline_trail = true,
            },
            exclude = {
                filetypes = {
                    "",
                    "alpha",
                    "dashboard",
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
        enabled = false,
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
            { "z1", function() require("ufo").closeFoldsWith(1) end, },
            { "z2", function() require("ufo").closeFoldsWith(2) end, },
        },
        config = function()
            -- vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            local ftMap = {
                markdown = "",
                vue = "lsp",
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

    --: statuscol {{{
    {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                -- relculright = true,
                ft_ignore = { "toggleterm" },
                bt_ignore = { "terminal" },
                segments = {
                    -- { text = { builtin.foldfunc, "" }, click = "v:lua.ScFa" },
                    -- { text = { "%s" }, click = "v:lua.ScSa" },
                    { sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
                    {
                        -- text = { "", builtin.lnumfunc, "   " },
                        text = { "", builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                    -- { text = { "%s" }, click = "v:lua.ScSa" },
                    { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
                },
            }
        end,
        config = function(_, opts)
            require("statuscol").setup(opts)
        end,
    },
    --: }}}

    --: tabby {{{
    {
        "nanozuki/tabby.nvim",
        -- enabled = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            -- vim.o.showtabline = 2
            local theme = {
                fill = "TabLineFill",
                -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
                head = "TabLine",
                current_tab = "TabLineSel",
                tab = "TabLine",
                win = "TabLine",
                tail = "TabLine",
            }
            require("tabby.tabline").set(function(line)
                return {
                    {
                        { "  ", hl = theme.head },
                        line.sep("", theme.head, theme.fill),
                    },
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep("", hl, theme.fill),
                            tab.is_current() and "" or "",
                            tab.number(),
                            tab.name(),
                            tab.close_btn("󱎘"),
                            line.sep("", hl, theme.fill),
                            hl = hl,
                            margin = " ",
                        }
                    end),
                    line.spacer(),
                    -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                    --     return {
                    --         line.sep("", theme.win, theme.fill),
                    --         win.is_current() and "" or "",
                    --         win.buf_name(),
                    --         line.sep("", theme.win, theme.fill),
                    --         hl = theme.win,
                    --         margin = " ",
                    --     }
                    -- end),
                    -- {
                    --     line.sep("", theme.tail, theme.fill),
                    --     { "  ", hl = theme.tail },
                    -- },
                    hl = theme.fill,
                }
            end)
        end,
    },
    --: }}}
}
