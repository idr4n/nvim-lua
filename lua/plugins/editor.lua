return {
    --: close_buffers {{{
    {
        "kazhala/close-buffers.nvim",
        keys = {
            {
                "<leader>bk",
                "<cmd>lua vim.cmd('Alpha'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
                noremap = true,
                silent = false,
                desc = "Close all and show Alpha",
            },

            {
                "<leader>bo",
                "<cmd>lua require('close_buffers').wipe({ type = 'other', force = false })<CR>",
                noremap = true,
                silent = false,
                desc = "Close all other buffers",
            },
        },
    },
    --: }}},

    --: colorizer {{{
    {
        "NvChad/nvim-colorizer.lua",
        -- enabled = false,
        event = "BufReadPre",
        keys = {
            { ",c", "<cmd>ColorizerToggle<cr>", noremap = true, silent = true },
        },
        opts = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = true, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = true, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                tailwind = "lsp",
                -- Available modes: foreground, background
                -- Available modes for `mode`: foreground, background,  virtualtext
                -- mode = "background", -- Set the display mode.
                mode = "virtualtext", -- Set the display mode.
                virtualtext = "■",
            },
        },
    },
    --: }}},

    --: diffview {{{
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        keys = {
            { "<leader>vo", ":DiffviewOpen<cr>", noremap = true, silent = true },
            { "<leader>vh", ":DiffviewFileHistory %<cr>", noremap = true, silent = true },
        },
    },
    --: }}},

    --: fzf.vim {{{
    {
        "junegunn/fzf.vim",
        cmd = { "Files", "Rg", "Lines", "BLines", "History" },
        keys = {
            -- { "<C-P>", ":Files<cr>", noremap = true, silent = true },
            -- { "<leader>ff", ":Files<cr>", noremap = true, silent = true },
            -- { "<C-T>", ":History<cr>", noremap = true, silent = true },
            -- { "<C-B>", ":Buffers<cr>", noremap = true, silent = true },
            { "<leader>r", ":Rg<cr>", noremap = true, silent = true, desc = "Live Grep" },
            -- { "<leader>gs", ":GitFiles?<cr>", noremap = true, silent = true },
            -- { "<leader>cc", "<cmd>lcd ~/.config/nvim | Files<cr>", noremap = true, silent = true },
            -- { "<leader>b", "<cmd>BLines<cr>", noremap = true, silent = true },
        },
        dependencies = "junegunn/fzf",
        config = function()
            -- calculate window width and height in columns
            local function calcWinSize()
                return {
                    width = math.min(math.ceil(vim.fn.winwidth(0) * 0.95), 140),
                    height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 30),
                }
            end

            -- settings
            -- vim.g.fzf_layout = { down = "40%" }
            vim.g.fzf_preview_window = { "right:50%", "ctrl-l" }
            -- vim.g.fzf_preview_window = { "right:50%:hidden", "ctrl-l" }
            -- vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height, yoffset = 0.45 } }
            vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height } }
            -- vim.g.fzf_preview_window = { "up:40%", "ctrl-l" }

            -- Recalculate fzf window size on Window resize
            local function recalcWinSize()
                vim.g.fzf_layout = { window = { width = calcWinSize().width, height = calcWinSize().height } }
            end

            vim.api.nvim_create_augroup("fzf", { clear = true })
            vim.api.nvim_create_autocmd("VimResized", {
                pattern = { "*" },
                callback = recalcWinSize,
                group = "fzf",
            })

            -- colors
            vim.g.fzf_colors = {
                ["fg"] = { "fg", "Normal" },
                ["bg"] = { "bg", "Normal" },
                ["hl"] = { "fg", "Comment" },
                ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
                ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
                ["hl+"] = { "fg", "Statement" },
                ["info"] = { "fg", "PreProc" },
                ["border"] = { "fg", "Statement" },
                ["prompt"] = { "fg", "Conditional" },
                ["pointer"] = { "fg", "Exception" },
                ["marker"] = { "fg", "Keyword" },
                ["spinner"] = { "fg", "Label" },
                ["header"] = { "fg", "Comment" },
                ["gutter"] = { "bg", "Normal" },
            }

            -- Default command
            vim.env.FZF_DEFAULT_COMMAND =
                "rg --files --hidden --follow --no-ignore -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'"

            -- exlclude file name from fuzzy matching in Rg command
            vim.cmd([[
                command! -bang -nargs=* Rg
                \ call fzf#vim#grep('rg --column --hidden --line-number --no-heading --color=always --smart-case -g "!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}" '
                \ . (len(<q-args>) > 0 ? <q-args> : '""'), 0,
                \ fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=2..', '--layout=reverse', '--info=inline']}), <bang>0)
            ]])

            -- add preview to Blines
            vim.cmd([[
                command! -bang -nargs=* BLines
                \ call fzf#vim#grep(
                \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
                \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%', 'ctrl-l'))
            ]])
        end,
    },
    --: }}},

    --: gitsigns {{{
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            -- redefine gitsigns colors
            local linenr_hl = vim.api.nvim_get_hl(0, { name = "LineNr" })
            -- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#73DACA", bg = linenr_hl.background })
            -- vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FF9E64", bg = linenr_hl.background })
            -- vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F7768E", bg = linenr_hl.background })
            -- vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#BD73EC", bg = linenr_hl.background })

            return {
                signcolumn = true,
                _extmark_signs = false,
                numhl = false,
                signs = {
                    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    -- add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    -- add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = {
                        hl = "GitSignsChange",
                        -- text = "▍",
                        text = "▎",
                        -- text = "│",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        -- text = "▁",
                        text = "󰍵",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        -- text = "󰐊",
                        text = "~",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChangeDelete",
                        -- text = "▍",
                        text = "▎",
                        -- text = "‾",
                        -- text = "▋",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
                    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "Blame line" })
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end, { desc = "Diff this (~ last commit)" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            }
        end,
    },
    --: }}},

    --: neo-tree {{{
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v3.x",
        -- stylua: ignore
        keys = {
            { "<leader>e", ":Neotree reveal left toggle<CR>", noremap = true, silent = true, desc = "Toggle Neo-Tree" },
            { "<leader>nt", ":Neotree reveal left toggle<CR>", noremap = true, silent = true, desc = "Toggle Neo-Tree" },
            { "<leader>nf", ":Neotree float reveal toggle<CR>", noremap = true, silent = true, desc = "Neo-tree Float" },
            { "<leader>nb", ":Neotree toggle show buffers right<CR>", noremap = true, silent = true, desc = "Neo-tree Buffers" },
            {
                "<leader>ns",
                ":Neotree toggle document_symbols right<CR>",
                noremap = true,
                silent = true,
                desc = "Doc Symbols",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_diagnostics = false,
            default_component_configs = {
                indent = {
                    padding = 1,
                    with_expanders = true,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    default = "",
                },
                git_status = {
                    symbols = {
                        added = "󰜄",
                        deleted = "",
                        modified = "",
                        renamed = "󰑕",
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                -- width = 35,
                mappings = {
                    ["o"] = "open",
                    ["h"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == "directory" and node:is_expanded() then
                            require("neo-tree.sources.filesystem").toggle_directory(state, node)
                        else
                            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                        end
                    end,
                    ["l"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == "directory" then
                            if not node:is_expanded() then
                                require("neo-tree.sources.filesystem").toggle_directory(state, node)
                            elseif node:has_children() then
                                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                            end
                        else
                            require("neo-tree.sources.filesystem.commands").open(state)
                        end
                    end,
                },
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        ".DS_Store",
                    },
                },
                follow_current_file = { enabled = true },
                hijack_netrw_behavior = "disabled",
                use_libuv_file_watcher = true,
            },
            git_status = {
                window = {
                    position = "float",
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(_)
                        vim.opt_local.signcolumn = "auto"
                    end,
                },
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(_)
                        vim.opt.statuscolumn = ""
                    end,
                    id = "statuscol",
                },
            },
            sources = {
                "filesystem",
                "buffers",
                "document_symbols",
            },
            document_symbols = {
                follow_cursor = true,
            },
        },
        -- config = require("setup.neo-tree"),
    },
    --: }}}

    --: trouble {{{
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true, desc = "Toggle" },
            {
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                silent = true,
                noremap = true,
                desc = "workspace_diagnostics",
            },
            {
                "<leader>ld",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                silent = true,
                noremap = true,
                desc = "workspace_diagnostics",
            },
            {
                "<leader>xd",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                silent = true,
                noremap = true,
                desc = "document_diagnostics",
            },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", silent = true, noremap = true, desc = "loclist" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", silent = true, noremap = true, desc = "quickfix" },
            { "gr", "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true, desc = "LSP references" },
            -- { "gd", "<cmd>TroubleToggle lsp_definitions<cr>", silent = true, noremap = true },
        },
        opts = {
            height = 15,
        },
    },
    --: }}}

    --: glance {{{
    {
        "dnlhc/glance.nvim",
        keys = {
            { "<leader>gg", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
            { "<leader>gr", "<CMD>Glance references<CR>", desc = "Glance references" },
            { "<leader>lr", "<CMD>Glance references<CR>", desc = "LSP references" },
            { "<leader>gd", "<CMD>Glance type_definitions<CR>", desc = "Glance type definitions" },
            { "<leader>gm", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
        },
        opts = {
            border = { enable = true, top_char = "─", bottom_char = "─" },
        },
    },
    --: }}}

    --: vgit {{{
    {
        "tanvirtin/vgit.nvim",
        -- enabled = false,
        -- dev = true,
        -- event = "BufReadPre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- stylua: ignore
        keys = {
            { "<leader>gp", function() require('vgit').buffer_hunk_preview() end, desc = "Hunk preview (vgit)" }
        },
        opts = {
            settings = {
                live_blame = { enabled = false },
                live_gutter = { enabled = false },
                authorship_code_lens = { enabled = false },
                scene = {
                    diff_preference = "split",
                    keymaps = {
                        quit = "q",
                    },
                },
                signs = {
                    definitions = {
                        GitSignsAdd = { text = "▎" },
                        GitSignsDelete = { text = "󰍵" },
                        GitSignsChange = { text = "▎" },
                    },
                },
            },
        },
    },
    --: }}}

    --: indent-blankline {{{
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        -- enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = false,
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
                            "jsx_self_closing_element",
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

    --: mini.indentscope with animations {{{
    {
        "echasnovski/mini.indentscope",
        -- enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    --: }}}

    --: notify {{{
    {
        "rcarriga/nvim-notify",
        -- enabled = false,
        keys = {
            {
                "<leader>nn",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            -- background_colour = "#000000",
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
        },
    },
    --: }}}

    --: noice {{{
    {
        "folke/noice.nvim",
        -- enabled = false,
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
        },
        opts = {
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
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
                progress = { enabled = true },
            },
            -- cmdline = {
            --     opts = {
            --         -- -- remover border
            --         border = { style = "none", padding = { 1, 2 } },
            --     },
            -- },
            -- -- if want to position cmdline and search popup in the top instead
            -- views = {
            --     cmdline_popup = {
            --         position = { row = 0, col = "50%" },
            --         size = { width = "97%" },
            --     },
            -- },
            popupmenu = { backend = "cmp" },
            presets = {
                bottom_search = true,
                command_palette = true,
                inc_rename = true,
                long_message_to_split = true,
                lsp_doc_border = true,
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
        -- enabled = false,
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
                    { sign = { name = { "Dap*" }, auto = true }, click = "v:lua.ScSa" },
                    {
                        -- text = { "", builtin.lnumfunc, "   " },
                        text = { "", builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                    -- { text = { "%s" }, click = "v:lua.ScSa" },
                    -- { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
                    { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
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
        enabled = false,
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

    --: clipboard-image {{{
    {
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
    },
    --: }}}

    --: nvim-cmp {{{
    {
        "hrsh7th/nvim-cmp",
        -- event = "InsertEnter",
        event = { "InsertEnter", "BufReadPost" },
        -- event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            { "js-everts/cmp-tailwind-colors", config = true },
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local nvchad_icons = require("util").nvchad_icons

            -- require("luasnip/loaders/from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
            end

            local function border(hl_name)
                return {
                    { "╭", hl_name },
                    { "─", hl_name },
                    { "╮", hl_name },
                    { "│", hl_name },
                    { "╯", hl_name },
                    { "─", hl_name },
                    { "╰", hl_name },
                    { "│", hl_name },
                }
            end

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                preselect = cmp.PreselectMode.None,
                mapping = {
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.config.disable,
                    ["<C-x>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-l>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- START extra config for cmp-tailwind-colors (remove if not used)
                        if vim_item.kind == "Color" then
                            vim_item = require("cmp-tailwind-colors").format(entry, vim_item)

                            if vim_item.kind ~= "Color" then
                                vim_item.menu = "Color"
                                vim_item.kind = string.format(" %s", vim_item.kind)
                                return vim_item
                            end
                        end
                        -- END extra config for cmp-tailwind-colors

                        vim_item.menu = vim_item.kind
                        vim_item.kind = string.format(" %s ", nvchad_icons[vim_item.kind])
                        return vim_item
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "otter" },
                    -- { name = "copilot" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = {
                        border = border("CmpBorder"),
                        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                        side_padding = 0,
                        -- For oxocarbon style (comment out border and use winhighlight below)
                        -- winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:Pmenu,Search:None",
                    },
                    documentation = {
                        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        border = border("CmpDocBorder"),
                        winhighlight = "Normal:CmpPmenu",
                    },
                },
                experimental = {
                    ghost_text = false,
                    native_menu = false,
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local handlers = require("nvim-autopairs.completion.handlers")

            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    filetypes = {
                        -- "*" is a alias to all filetypes
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"],
                            },
                        },
                    },
                })
            )
        end,
    },
    --: }}},

    --: Comment.nvim {{{
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        },
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },
    --: }}}

    --: windwp/nvim-autopairs {{{
    {
        "windwp/nvim-autopairs",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup()

            local Rule = require("nvim-autopairs.rule")

            local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
            npairs.add_rules({
                Rule(" ", " "):with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                        brackets[2][1] .. brackets[2][2],
                        brackets[3][1] .. brackets[3][2],
                    }, pair)
                end),
            })
            for _, bracket in pairs(brackets) do
                npairs.add_rules({
                    Rule(bracket[1] .. " ", " " .. bracket[2])
                        :with_pair(function()
                            return false
                        end)
                        :with_move(function(opts)
                            return opts.prev_char:match(".%" .. bracket[2]) ~= nil
                        end)
                        :use_key(bracket[2]),
                })
            end
        end,
    },
    --: }}}

    --: yanky {{{
    {
        "gbprod/yanky.nvim",
        -- enabled = false,
        event = "BufReadPost",
        cmd = { "YankyRingHistory", "YankyClearHistory" },
        keys = {
            -- { ",r", "<cmd>YankyRingHistory<cr>", noremap = true, silent = true },
            -- { ",r", "<cmd>Telescope yank_history<cr>", noremap = true, silent = true },
            {
                ",y",
                "<cmd>lua require('telescope').extensions.yank_history.yank_history({ initial_mode = 'normal' })<cr>",
                noremap = true,
                silent = true,
                desc = "Yank history",
            },
        },
        opts = function()
            require("telescope").load_extension("yank_history")
            local utils = require("yanky.utils")
            local mapping = require("yanky.telescope.mapping")

            return {
                ring = {
                    history_length = 50,
                },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 70,
                },
                system_clipboard = {
                    sync_with_ring = false,
                },
                picker = {
                    telescope = {
                        mappings = {
                            -- default = mapping.put("p"),
                            default = mapping.special_put("YankyPutIndentAfter"),
                            i = {
                                ["<c-p>"] = mapping.special_put("YankyPutIndentBefore"),
                                ["<c-k>"] = nil,
                                ["<c-x>"] = mapping.delete(),
                                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
                            },
                            n = {
                                p = mapping.special_put("YankyPutIndentAfter"),
                                P = mapping.special_put("YankyPutIndentBefore"),
                                d = mapping.delete(),
                                r = mapping.set_register(utils.get_default_register()),
                            },
                        },
                    },
                },
            }
        end,
    },
    --: }}}

    --: lf {{{
    {
        "ptzz/lf.vim",
        dependencies = "voldikss/vim-floaterm",
        keys = {
            { ",l", ":Lf<cr>", noremap = true, silent = true, desc = "Open LF" },
        },
        config = function()
            local function calcFloatSize()
                return {
                    width = math.min(math.ceil(vim.fn.winwidth(0) * 0.9), 140),
                    height = math.min(math.ceil(vim.fn.winheight(0) * 0.9), 35),
                }
            end

            local function recalcFloatermSize()
                vim.g.floaterm_width = calcFloatSize().width
                vim.g.floaterm_height = calcFloatSize().height
            end

            vim.api.nvim_create_augroup("floaterm", { clear = true })
            vim.api.nvim_create_autocmd("VimResized", {
                pattern = { "*" },
                callback = recalcFloatermSize,
                group = "floaterm",
            })

            vim.g.floaterm_width = calcFloatSize().width
            vim.g.floaterm_height = calcFloatSize().height
        end,
    },
    --: }}},

    --: harpoon {{{
    {
        "ThePrimeagen/harpoon",
        keys = {
            { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon" },
            { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add Harpoon" },
            { "<M-u>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
            { "<M-i>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" },
            { "<M-o>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" },
            { "<M-p>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" },
            { "<M-[>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>" },
            { "<M-]>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>" },
        },
        dependencies = "nvim-lua/plenary.nvim",
    },
    --: }}}

    --: toggleterm {{{
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm" },
        opts = {
            -- size = 25,
            size = function(term)
                if term.direction == "horizontal" then
                    return 20
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<M-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = false,
            persist_size = true,
            -- direction = "float",
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                width = math.min(math.ceil(vim.fn.winwidth(0) * 0.8), 120),
                height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 28),
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        },
        keys = {
            { "<leader>gl", ":LazyGit<cr>", noremap = true, silent = true, desc = "LazyGit" },
            { "<M-\\>", ":ToggleTerm<cr>", noremap = true, silent = true },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            local float_opts = { height = math.floor(vim.fn.winheight(0) * 0.85) }

            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, float_opts = float_opts })

            -- :Lazygit
            vim.api.nvim_create_user_command("LazyGit", function()
                if os.getenv("TERM_PROGRAM") == "tmux" then
                    vim.cmd("execute 'silent !tmux split-window -v -p 80 lazygit'")
                else
                    lazygit:toggle()
                end
            end, {})
            function _G.set_terminal_keymaps()
                local op = { buffer = 0 }
                -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], op)
                vim.keymap.set("t", "jk", [[<C-\><C-n>]], op)
                vim.keymap.set("t", "<C-left>", [[<Cmd>wincmd h<CR>]], op)
                vim.keymap.set("t", "<C-down>", [[<Cmd>wincmd j<CR>]], op)
                vim.keymap.set("t", "<C-up>", [[<Cmd>wincmd k<CR>]], op)
                vim.keymap.set("t", "<M-`>", [[<Cmd>wincmd k<CR>]], op)
                vim.keymap.set("n", "<M-`>", "<Cmd>wincmd j<CR>")
                vim.keymap.set("t", "<C-right>", [[<Cmd>wincmd l<CR>]], op)
                vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], op)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },
    --: }}}

    -- stylua: ignore
    --: windex (max. window) {{{
    {
        "declancm/windex.nvim",
        keys = {
            { "<Leader>tm", "<Cmd>lua require('windex').toggle_nvim_maximize()<CR>", desc = "Toggle Maximize Window" },
            { "<C-Bslash>", "<Cmd>lua require('windex').toggle_terminal()<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
            { "<C-n>", "<C-Bslash><C-n>", mode = "t", desc = "Enter normal mode" },
        },
        config = true,
    },
    --: }}}

    --: vim-dirvish {{{
    {
        "justinmk/vim-dirvish",
        event = "VimEnter",
        -- enabled = false,
        config = function()
            vim.g.dirvish_git_show_ignored = 1

            -- sort folders at the top
            vim.g.dirvish_mode = ":sort ,^.*[\\/],"

            -- use h and l to navigate back and forward
            vim.cmd([[
            augroup dirvish_mappings
                autocmd!
                autocmd FileType dirvish nnoremap <silent><buffer> l :<C-U>.call dirvish#open("edit", 0)<CR>
                autocmd FileType dirvish nnoremap <silent><buffer> h :<C-U>exe "Dirvish %:h".repeat(":h",v:count1)<CR>
            augroup END
            ]])
        end,
    },
    --: }}}

    --: vim-fugitive {{{
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gi", ":Git<cr>", noremap = true, silent = true, desc = "Git Fugitive" },
        },
    },
    --: }}}

    --: neogit (magit for neovim) {{{
    {
        "TimUntersberger/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<leader>gn", ":Neogit<cr>", noremap = true, silent = true, desc = "Neogit" },
        },
        opts = {
            disable_signs = false,
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
            },
            integrations = { diffview = true },
        },
    },
    --: }}}

    --: code_runner {{{
    {
        "CRAG666/code_runner.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<leader>cc", ":RunCode<CR>", noremap = true, silent = false, desc = "Code run" },
            { "<leader>cf", ":RunFile float<CR>", noremap = true, silent = false, desc = "File run" },
        },
        config = function()
            require("code_runner").setup({
                focus = false,
                term = {
                    position = "vert",
                    size = 50,
                },
                float = {
                    close_key = "q",
                    border = "rounded",
                    height = 0.4,
                    width = 0.8,
                    x = 0.5,
                    y = 0.3,
                },
            })
        end,
    },
    --: }}}

    --: which-key {{{
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            window = {
                padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
            },
            layout = {
                height = { min = 4, max = 20 },
                width = { min = 10, max = 40 },
            },
        },
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 900
            local wk = require("which-key")
            wk.setup(opts)
            local keymaps_n = {
                ["gc"] = { name = "comment" },
                ["<leader>"] = {
                    b = { name = "buffer" },
                    c = { name = "coding" },
                    d = { name = "debug" },
                    f = { name = "file" },
                    g = { name = "Git/Glance" },
                    h = { name = "Gitsings/Harpoon" },
                    l = { name = "LSP" },
                    o = { name = "open" },
                    n = { name = "Neotree/Noice" },
                    q = { name = "Quit" },
                    s = { name = "Search" },
                    t = { name = "toggle" },
                    v = { name = "diffview" },
                    x = { name = "Trouble" },
                    z = { name = "misc" },
                    ["<tab>"] = { name = "Tabs" },
                    ["tb"] = "Blame current line",
                },
            }
            local keymaps_v = {
                ["<leader>"] = {
                    h = { name = "Gitsings" },
                    l = { name = "LSP" },
                    o = { name = "open" },
                },
            }
            wk.register(keymaps_n)
            wk.register(keymaps_v, { mode = "v" })
        end,
    },
    --: }}}

    --: oil - file manager {{{
    {
        "stevearc/oil.nvim",
        enabled = false,
        cmd = "Oil",
        keys = { { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" } },
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    --: }}}

    --: quarto {{{
    {
        "quarto-dev/quarto-nvim",
        dev = false,
        ft = { "quarto" },
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                dependencies = {
                    { "neovim/nvim-lspconfig" },
                },
                config = true,
            },
        },
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "lua", "html" },
            },
        },
        config = function(_, opts)
            require("quarto").setup(opts)
        end,
    },
    --: }}}

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
        enabled = false,
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
        cmd = { "ZenMode" },
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
            plugins = {
                -- gitsigns = { enabled = false },
                options = {
                    laststatus = 3,
                },
            },
        },
        keys = {
            { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true, desc = "Zen mode" },
        },
    },
    --: }}}

    --: no-neck-pain (another zen-mode plugin) {{{
    {
        "shortcuts/no-neck-pain.nvim",
        cmd = { "NoNeckPain" },
        keys = {
            {
                "<leader>tz",
                function()
                    vim.cmd([[
                        NoNeckPain
                        set invnumber
                        set invrelativenumber
                    ]])
                end,
                desc = "Zen-mode (No-neck-pain)",
            },
        },
        opts = {
            buffers = { wo = { number = false, relativenumber = false } },
        },
    },
    --: }}}

    --: bufferline... {{{
    {
        "akinsho/bufferline.nvim",
        -- enabled = false,
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        },
        opts = function()
            local bufferline = require("bufferline")
            return {
                options = {
                    buffer_close_icon = "",
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "Neo-tree",
                            highlight = "Directory",
                            text_align = "center",
                        },
                    },
                    style_preset = {
                        bufferline.style_preset.no_italic,
                        bufferline.style_preset.no_bold,
                    },
                    separator_style = "slope",
                },
            }
        end,
        config = function(_, opts)
            require("bufferline").setup(opts)
        end,
    },

    --: }}}
}
