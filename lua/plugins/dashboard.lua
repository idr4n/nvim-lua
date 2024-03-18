return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  keys = {
    { "<leader>od", "<cmd>Dashboard<cr>", desc = "Open Dashboard" },
  },
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
          { action = "FzfLua files",                                                   desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                              desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                             desc = " Recent files",    icon = " ", key = "t" },
          { action = "Telescope live_grep",                                            desc = " Find text",       icon = "󰺮 ", key = "r" },
          { action = "lcd ~/.config/nvim | echo 'Directory:' getcwd()",                desc = " Config",          icon = " ", key = "c" },
          { action = "lcd ~/dotfiles | echo 'Directory:' getcwd()",                    desc = " Dotfiles",        icon = " ", key = "d" },
          -- { action = 'lua require("persistence").load()',                              desc = " Restore Session", icon = " ", key = "s" },
          { action = 'lua require("session_manager").load_current_dir_session()',      desc = " Restore Session", icon = " ", key = "s" },
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
