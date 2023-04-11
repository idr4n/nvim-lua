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
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>xt", "<cmd>TodoTrouble<cr>", noremap = true, silent = true, desc = "TodoTrouble" },
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
                height = 0.95,
                backdrop = 1,
                options = {
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
                    cursorcolumn = false,
                },
            },
            -- plugins = {
            --   gitsigns = { enabled = false },
            -- }
        },
        keys = {
            { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true, desc = "Zen mode" },
        },
    },
    --: }}}
}
