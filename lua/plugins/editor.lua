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
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
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
            --  { "<C-P>", ":Files<cr>", noremap = true, silent = true },
            --  { "<leader>ff", ":Files<cr>", noremap = true, silent = true },
            --  { "<C-T>", ":History<cr>", noremap = true, silent = true },
            --  { "<C-B>", ":Buffers<cr>", noremap = true, silent = true },
            { "<leader>r", ":Rg<cr>", noremap = true, silent = true },
            --  { "<leader>gs", ":GitFiles?<cr>", noremap = true, silent = true },
            --  { "<leader>cc", "<cmd>lcd ~/.config/nvim | Files<cr>", noremap = true, silent = true },
            --  { "<leader>b", "<cmd>BLines<cr>", noremap = true, silent = true },
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
                "rg --files --hidden --follow --no-ignore -g '!.git/*' -g '!node_modules' -g '!target'"

            -- exlclude file name from fuzzy matching in Rg command
            vim.cmd([[
                command! -bang -nargs=* Rg
                \ call fzf#vim#grep('rg --column --hidden --line-number --no-heading --color=always --smart-case -g "!.git/*" -g !node_modules '
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
            local linenr_hl = vim.api.nvim_get_hl_by_name("LineNr", true)
            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#73DACA", bg = linenr_hl.background })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FF9E64", bg = linenr_hl.background })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F7768E", bg = linenr_hl.background })
            vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#BD73EC", bg = linenr_hl.background })

            return {
                signcolumn = true,
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
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end)

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
        branch = "v2.x",
        keys = {
            { "<leader>na", ":Neotree reveal left toggle<CR>", noremap = true, silent = true, desc = "Toggle" },
            { "<leader>nn", ":Neotree focus<CR>", noremap = true, silent = true, desc = "Focus" },
            { "<leader>nf", ":Neotree float reveal toggle<CR>", noremap = true, silent = true, desc = "Float" },
            { "<leader>nb", ":Neotree toggle show buffers right<CR>", noremap = true, silent = true, desc = "Buffers" },
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
                        added = "ﰂ",
                        deleted = "",
                        modified = "",
                        renamed = "凜",
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                width = 27,
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
                follow_current_file = true,
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
}
