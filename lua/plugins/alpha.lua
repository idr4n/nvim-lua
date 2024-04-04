return {
  "goolord/alpha-nvim",
  -- enabled = false,
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
      -- dashboard.button("f", "󰱼  Find file", ":lua require('fzf-lua').files()<cr>"),
      dashboard.button(
        "f",
        "󰈞  Find file",
        -- ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
        -- ":lua require('telescope.builtin').find_files()<cr>"
        ":CommandTRipgrep<cr>"
      ),
      dashboard.button("t", "󰄉  File History", ":Telescope oldfiles<cr>"),
      dashboard.button("r", "󰺮  Find text", ":FzfLua live_grep_glob<cr>"),
      -- dashboard.button("r", "󰺮  Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("s", "  Restore session", ':lua require("session_manager").load_current_dir_session() <CR>'),
      -- dashboard.button(
      --   "S",
      --   "  Open directory",
      --   "<cmd>lua require('plugins.telescope.workdirs-picker').set_workdir()<CR>"
      -- ),
      -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Files<cr>"),
      -- dashboard.button("c", "  Configuration", "<cmd>lcd ~/.config/nvim | Telescope find_files<cr>"),
      dashboard.button("c", "  Config", "<cmd>lcd ~/.config/nvim | echo 'Directory:' getcwd()<cr>"),
      dashboard.button("d", "  Dotfiles", "<cmd>lcd ~/dotfiles | echo 'Directory:' getcwd()<cr>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      { type = "padding", val = 1 },
    }

    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = pick_color()
    dashboard.opts.layout[1].val = 8

    -- for _, el in pairs(dashboard.section.buttons.val) do
    --   el.opts.width = 51 -- or some other value
    -- end

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
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "AlphaReady",
    --   command = "set showtabline=0 | set laststatus=0",
    -- })
    local alpha_group = vim.api.nvim_create_augroup("idr4n/alpha", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = alpha_group,
      desc = "Minimal UI in Alpha dashboard",
      pattern = "AlphaReady",
      once = true,
      callback = function(args)
        vim.o.laststatus = 0
        vim.o.showtabline = 0
        vim.o.cmdheight = 0

        vim.api.nvim_create_autocmd("BufUnload", {
          group = alpha_group,
          buffer = args.buf,
          once = true,
          callback = function()
            vim.o.laststatus = 3
            vim.o.showtabline = 2
            vim.o.cmdheight = 1
          end,
        })
      end,
    })
  end,
}
