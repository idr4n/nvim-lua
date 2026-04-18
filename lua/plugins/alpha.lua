return {
  "goolord/alpha-nvim",
  enabled = false,
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    math.randomseed(os.time())

    local function pick_color()
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    dashboard.section.header.val = {
      " ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓",
      " ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
      "▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░",
      "▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ",
      "▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒",
      "░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░",
      "░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░",
      "   ░   ░ ░     ░░   ▒ ░░      ░   ",
      "               ░                  ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("a", "󰱼  Find file", function()
        require("snacks").picker.files({
          layout = { preset = "select", layout = { width = 0.6, min_width = 100, height = 0.4, min_height = 17 } },
        })
      end),
      dashboard.button("s", "  Restore session", ':lua require("sessions").load_session() <CR>'),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("n", "  File Explorer", function()
        -- require("mini.files").open()
        vim.cmd("Neotree reveal")
      end),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      { type = "padding", val = 1 },
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
        local prev_statuscol = vim.opt.statuscolumn
        vim.o.laststatus = 0
        vim.o.showtabline = 0
        -- vim.o.cmdheight = 0 -- uncomment if not useing noice
        vim.opt.statuscolumn = ""

        vim.api.nvim_create_autocmd("BufUnload", {
          group = alpha_group,
          buffer = args.buf,
          once = true,
          callback = function()
            vim.o.laststatus = 3
            -- vim.o.showtabline = 2
            -- vim.o.cmdheight = 1 -- uncomment if not useing noice
            vim.opt.statuscolumn = prev_statuscol
          end,
        })
        -- -- If we want Alpha to start at launch
        -- vim.api.nvim_create_autocmd("BufUnload", {
        --   group = alpha_group,
        --   buffer = args.buf,
        --   once = true,
        --   callback = vim.schedule_wrap(function()
        --     local width = vim.o.columns
        --     local min_width_threshhold = 140
        --
        --     if width >= min_width_threshhold then
        --       vim.cmd("Neotree show")
        --     end
        --   end),
        -- })
      end,
    })
  end,
}
