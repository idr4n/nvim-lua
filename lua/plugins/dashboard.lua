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

        local stats = require("lazy").stats()

        local function footer()
            local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
            return datetime
                .. "   "
                -- .. string.format("%s/%s", stats.loaded, stats.count)
                .. stats.count
                .. " plugins in "
                .. stats.startuptime
                .. "ms"
                .. "   v"
                .. vim.version().major
                .. "."
                .. vim.version().minor
                .. "."
                .. vim.version().patch
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
        dashboard.section.header.opts.hl = pick_color()

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            -- dashboard.button("f", "  Find file", ":Files<cr>"),
            -- dashboard.button("f", "  Find file", ":lua require('fzf-lua').files()<cr>"),
            dashboard.button("f", "  Find file", ":Telescope find_files<cr>"),
            dashboard.button("r", "  Recently used files", ":History<cr>"),
            dashboard.button("t", "  Find text", ":Rg<cr>"),
            -- dashboard.button("s", "  Open session", ":SearchSession <CR>"),
            dashboard.button("s", "  Open directory", ":lua require('plugins.fzf-lua.commands').workdirs()<CR>"),
            -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Files<cr>"),
            -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Telescope find_files<cr>"),
            dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim<cr>"),
            dashboard.button("d", "  Dotfiles", "<cmd>lcd ~/dotfiles<cr>"),
            dashboard.button("u", "  Update plugins", ":Lazy<CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        -- local fortune = require("alpha.fortune")
        -- dashboard.section.footer.val = fortune()
        -- dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "Constant"

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                dashboard.section.footer.val = footer()
            end,
        })

        require("alpha").setup(dashboard.opts)
    end,
}
