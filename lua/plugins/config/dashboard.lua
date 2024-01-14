local M = {}

M.dashboard = {
  opts = function()
    local logo = [[
         ███╗   ██╗██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ████╗  ██║██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
         ██╔██╗ ██║██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
         ██║╚██╗██║██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
         ██║ ╚████║███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
         ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      -- hide = {
      --     -- this is taken care of by lualine
      --     -- enabling this messes up the actual laststatus setting after loading a file
      --     statusline = false,
      -- },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                           desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                              desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                             desc = " Recent files",    icon = " ", key = "t" },
          { action = "Rg",                                                             desc = " Find text",       icon = "󰺮 ", key = "r" },
          { action = "lcd ~/.config/nvim | echo 'Directory:' getcwd()",                desc = " Config",          icon = " ", key = "c" },
          { action = "lcd ~/dotfiles | echo 'Directory:' getcwd()",                    desc = " Dotfiles",        icon = " ", key = "d" },
          { action = 'lua require("persistence").load()',                              desc = " Restore Session", icon = " ", key = "s" },
          { action = "Lazy",                                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "lua require('plugins.telescope.workdirs-picker').set_workdir()", desc = " Open directory",  icon = " ", key = "S" },
          { action = "qa",                                                             desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    -- vim.api.nvim_create_autocmd("User", {
    --     pattern = "DashboardLoaded",
    --     command = "set laststatus=0",
    -- })

    return opts
  end,
}

M.alpha = {
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
      dashboard.button("c", "  Config", "<cmd>lcd ~/.config/nvim | echo 'Directory:' getcwd()<cr>"),
      dashboard.button("d", "  Dotfiles", "<cmd>lcd ~/dotfiles | echo 'Directory:' getcwd()<cr>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = pick_color()
    dashboard.opts.layout[1].val = 8

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
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      command = "set showtabline=0 | set laststatus=0",
    })
  end,
}

return M
