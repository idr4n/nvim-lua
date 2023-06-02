return {
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
            { "<Leader>tm", "<Cmd>lua require('windex').toggle_maximize()<CR>", desc = "Toggle Maximize Window" },
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
        enabled = false,
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
            local keymaps = {
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
                    n = { name = "Neotree" },
                    t = { name = "toggle" },
                    x = { name = "Trouble" },
                    z = { name = "misc" },
                    ["tb"] = "Blame current line",
                },
            }
            wk.register(keymaps)
        end,
    },
    --: }}}

    --: oil - file manager {{{
    {
        "stevearc/oil.nvim",
        -- enabled = false,
        cmd = "Oil",
        keys = { { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" } },
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    --: }}}
}
