return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        math.randomseed(os.time())

        local function pick_color()
            local colors = { "String", "Identifier", "Keyword", "Number" }
            return colors[math.random(#colors)]
        end

        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
            -- dashboard.button("f", "󰱼  Find file", ":Files<cr>"),
            dashboard.button("f", "󰱼  Find file", ":lua require('fzf-lua').files()<cr>"),
            -- dashboard.button(
            --     "f",
            --     "󰈞  Find file",
            --     -- ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
            --     ":lua require('telescope.builtin').find_files()<cr>"
            -- ),
            dashboard.button("t", "󰄉  File History", ":Telescope oldfiles<cr>"),
            dashboard.button("r", "󰺮  Find text", ":Rg<cr>"),
            -- dashboard.button("r", "󰺮  Find text", "<cmd>Telescope live_grep<cr>"),
            -- dashboard.button("s", "  Open session", ":SearchSession <CR>"),
            dashboard.button(
                "s",
                "  Open directory",
                "<cmd>lua require('plugins.telescope.workdirs-picker').set_workdir()<CR>"
            ),
            -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Files<cr>"),
            -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Telescope find_files<cr>"),
            dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | echo 'Directory:' getcwd()<cr>"),
            dashboard.button("d", "  Dotfiles", "<cmd>lcd ~/dotfiles | echo 'Directory:' getcwd()<cr>"),
            dashboard.button("u", "  Update plugins", ":Lazy<CR>"),
            dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
        }

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = pick_color()

        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
