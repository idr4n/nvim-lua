return {
    --: barbecue {{{
    {
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
    },
    --: }}},

    --: emmet {{{
    {
        "mattn/emmet-vim",
        event = "InsertEnter",
        init = function()
            vim.g.user_emmet_leader_key = "<C-W>"
        end,
    },
    --: }}},

    --: incline {{{
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("incline").setup({
                highlight = {
                    groups = {
                        InclineNormal = { guifg = "#9d7cd8", guibg = colors.black },
                        InclineNormalNC = { guibg = colors.blue7, guifg = colors.fg },
                    },
                },
                hide = { cursorline = "focused_win", only_win = true },
                window = { margin = { vertical = 0, horizontal = 1 } },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return { { icon, guifg = color }, { " " }, { filename } }
                end,
            })
        end,
    },
    --: }}},

    --: lsp_signature {{{
    {
        "ray-x/lsp_signature.nvim",
        event = "BufReadPre",
        enabled = true,
        opts = function()
            local icons = require("icons")

            return {
                debug = false, -- set to true to enable debug logging
                log_path = "debug_log_file_path", -- debug log path
                verbose = false, -- show debug line number

                bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
                floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
                -- will set to true when fully tested, set to false will use whichever side has more space
                -- this setting will be helpful if you do not want the PUM and floating win overlap

                floating_window_off_x = 1, -- adjust float windows x position.
                floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

                fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
                hint_enable = false, -- virtual hint enable
                hint_prefix = icons.misc.Squirrel .. " ", -- Panda for parameter
                -- hint_scheme = "Comment",
                hint_scheme = "String",
                use_lspsaga = false, -- set to true if you want to use lspsaga popup
                -- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                hi_parameter = "IncSearch", -- how your parameter will be highlight
                max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                -- to view the hiding contents
                max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "rounded", -- double, rounded, single, shadow, none
                },

                always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

                auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
                extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

                padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

                transparency = nil, -- disabled by default, allow floating win transparent value 1~100
                shadow_blend = 36, -- if you using shadow as border use this set the opacity
                shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
                toggle_key = "<M-x>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
            }
        end,
        config = function(_, opts)
            require("lsp_signature").setup(opts)
            require("lsp_signature").on_attach(opts)
        end,
    },
    --: }}},

    --: nvim-markdown {{{
    {
        "ixru/nvim-markdown",
        ft = "markdown",
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_new_list_item_indent = 0
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_follow_anchor = 1
            vim.g.vim_markdown_conceal = 0
            vim.g.tex_conceal = ""
        end,
    },
    --: }}}

    --: tabout {{{
    {
        "abecodes/tabout.nvim",
        event = "InsertEnter",
        dependencies = { "nvim-treesitter" },
        opts = {
            tabkey = [[<C-\>]], -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = [[<C-S-\>]], -- key to trigger backwards tabout, set to an empty string to disable
            act_as_tab = false, -- shift content if tab out is not possible
            act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            enable_backwards = true, -- well ...
            completion = true, -- if the tabkey is used in a completion pum
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
            },
            ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
            exclude = {}, -- tabout will ignore these filetypes
        },
        -- config = function(_, opts)
        --  require("tabout").setup(opts)
        -- end,
    },
    --: }}}

    --: todo-comments {{{
    {
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
    },
    --: }}}

    --: zen-mode {{{
    {
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
            --   gitsigns = { enabled = false },
            -- }
        },
        keys = {
            { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true },
        },
    },
    --: }}}
}
