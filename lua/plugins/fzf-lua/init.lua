return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
        { "<leader>r", "<cmd>lua require('fzf-lua').live_grep()<CR>", noremap = true, silent = true },
        { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
        -- { "<leader>l", "<cmd>lua require('fzf-lua').resume()<CR>", noremap = true, silent = true },
        -- { "<C-P>", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
        -- { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
        -- { "<C-T>", "<cmd>lua require('fzf-lua').oldfiles()<CR>", noremap = true, silent = true },
        -- { "<C-B>", "<cmd>lua require('fzf-lua').buffers()<CR>", noremap = true, silent = true },
        { "<leader>ol", "<cmd>lua require('fzf-lua').blines()<CR>", noremap = true, silent = true },
        { "<leader>oa", "<cmd>lua require('fzf-lua').lines()<CR>", noremap = true, silent = true },
        {
            "<leader>os",
            "<cmd>lua require'fzf-lua'.lsp_document_symbols({ fzf_cli_args = '--with-nth 3..' })<cr>",
            noremap = true,
            silent = true,
        },
        -- { "<leader>r", "<cmd>lua require('fzf-lua').live_grep()<CR>", noremap = true, silent = true },
        -- { "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", noremap = true, silent = true },
        -- { "<leader>cc", "<cmd>lcd ~/.config/nvim | lua require('fzf-lua').files()<cr>", noremap = true, silent = true },

        -- sets new working dir,
        { "<leader>cw", "<cmd>lua require('plugins.fzf-lua.commands').workdirs()<CR>", noremap = true, silent = true },
        {
            "<leader>/",
            "<cmd>lua require('plugins.fzf-lua.commands').workdirs({ nvim_tmux = true })<CR>",
            noremap = true,
            silent = true,
        },
        -- { "<leader>/", "<cmd>lua require('plugins.fzf-lua.commands').workdirs({ nvim_alacritty = true })<CR>", noremap = true, silent = true },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        vim.api.nvim_set_hl(0, "FZFLuaBorder", { fg = "#9D7CD8" })

        return {
            winopts = {
                height = 0.4,
                width = 0.9,
                -- row = 0.2,
                preview = {
                    vertical = "up:40%",
                    horizontal = "right:54%",
                    flip_columns = 120,
                    delay = 60,
                    scrollbar = false,
                    hidden = "nohidden",
                },
            },
            winopts_fn = function()
                -- smaller width if neovim win has over 80 columns
                local max_width = 140 / vim.o.columns
                local max_height = 30 / vim.o.lines
                -- return { width = vim.o.columns > 140 and max_width or 1 }
                return {
                    width = math.min(max_width, 1),
                    height = math.min(max_height, 1),
                }
            end,
            fzf_opts = {
                -- ["--layout"] = "default",
                ["--layout"] = "reverse",
                ["--pointer"] = " ",
            },
            fzf_colors = {
                ["fg"] = { "fg", "CursorLine" },
                ["bg"] = { "bg", "Normal" },
                ["hl"] = { "fg", "Comment" },
                -- ["fg+"] = { "fg", "ModeMsg" },
                ["fg+"] = { "fg", "Normal" },
                ["bg+"] = { "bg", "CursorLine" },
                ["hl+"] = { "fg", "Statement" },
                ["info"] = { "fg", "PreProc" },
                ["border"] = { "fg", "FZFLuaBorder" },
                ["prompt"] = { "fg", "Conditional" },
                ["pointer"] = { "fg", "Exception" },
                ["marker"] = { "fg", "Keyword" },
                ["spinner"] = { "fg", "Label" },
                ["header"] = { "fg", "Comment" },
                ["gutter"] = { "bg", "Normal" },
            },
            files = {
                cmd = "rg --files --hidden --follow --no-ignore -g '!.git/*' -g '!node_modules'",
                prompt = " ",
            },
            grep = {
                rg_opts = "--hidden --column --follow --line-number --no-heading "
                    .. "--color=always --smart-case -g '!{.git,node_modules}/*'",
                prompt = " ",
            },
            blines = { prompt = " " },
            keymap = {
                builtin = {
                    ["<C-L>"] = "toggle-preview",
                    ["<S-down>"] = "preview-page-down",
                    ["<S-up>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-l"] = "toggle-preview",
                    ["ctrl-q"] = "select-all+accept", -- send all to quick list
                },
            },
            -- needed for kitty for better icon rendering
            file_icon_padding = " ",
            nbsp = "\xc2\xa0",
        }
    end,
}
