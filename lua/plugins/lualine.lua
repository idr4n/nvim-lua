local utils = require("utils")
local theme = require("config.lualine.themes").theme

local function fileinfo()
  local dir = utils.pretty_dirpath()()
  local path = vim.fn.expand("%:t")
  -- local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
  local name = path:match("([^/\\]+)[/\\]*$")

  return dir .. name .. " %m%r%h%w "
end

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "󰑋 " .. recording_register
  end
end

return {
  "nvim-lualine/lualine.nvim",
  cond = false,
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    -- local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    -- listen lsp-progress event and refresh lualine
    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = "lualine_augroup",
      pattern = { "dracula", "nord", "*" },
      callback = function()
        if vim.g.colors_name == "nord" then
          require("lualine").setup({ options = { theme = "nord" } })
        else
          require("lualine").setup({ options = { theme = theme[vim.g.colors_name] or "auto" } })
        end
      end,
    })

    local opts = {
      options = {
        -- theme = "auto",
        theme = theme[vim.g.colors_name] or "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "telescope" } },
        -- component_separators = { left = "", right = "" },
        component_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
          or { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- section_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
        --   or { left = "", right = "" },
        section_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
          or { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local m = vim.api.nvim_get_mode().mode
              if m == "\22" then
                return "C-V"
              end
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            fmt = function(str)
              local count = str:match("%d+")
              if count then
                return str:gsub("%d+%s*", "")
              end
              return str
            end,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
            -- symbols = { added = "•", modified = "•", removed = "•" },
            symbols = { added = "▪", modified = "▪", removed = "▪" },
            padding = { left = 0, right = 1 },
          },
          {
            "diagnostics",
            symbols = { error = "◦", warn = "◦", info = "◦", hint = "◦" },
            -- symbols = { error = "◌", warn = "◌", info = "◌", hint = "◌" },
            padding = { left = 0, right = 1 },
            fmt = function(str)
              local count = str:match("%d+")
              if count then
                return str:gsub("%d+%s*", "")
              end
              return str
            end,
          },
        },
        lualine_c = {
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { fileinfo, padding = { left = 0, right = 1 } },
          {
            fileinfo,
            padding = { left = 1, right = 0 },
          },
          function()
            return "%="
          end,
          {
            utils.get_words,
            padding = { left = 0, right = 0 },
            color = { fg = "#333333", bg = "#FFAFF3" },
            separator = vim.env.TERM ~= "alacritty" and { left = "", right = "" },
            cond = function()
              return utils.get_words() ~= ""
            end,
          },
          {
            show_macro_recording,
            color = { fg = "#333333", bg = "#ff6666", gui = "bold" },
            separator = { left = "", right = "" },
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("lsp-progress").progress() end,
            color = function() return utils.get_fg("Added") and utils.get_fg("Added") or utils.get_fg("DiffAdded") and utils.get_fg("DiffAdded") or utils.get_fg("DiffAdd") end
          },
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = function() return utils.get_fg("Statement") end
          -- },
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --   color = function() return utils.get_fg("Constant") end
          -- },
          "searchcount",
          {
            function()
              return " "
            end,
            cond = function()
              local is_terminal_open = false
              for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
                if vim.bo[buffer].buftype == "terminal" then
                  is_terminal_open = true
                end
              end
              return is_terminal_open
            end,
            color = function()
              return utils.get_fg("Special")
            end,
          },
          {
            "copilot",
            symbols = {
              status = {
                icons = {
                  enabled = " ",
                  sleep = " ",
                  disabled = "",
                  warning = " ",
                  unknown = "",
                },
              },
            },
            show_colors = false,
            show_loading = true,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          },
          {
            function()
              if rawget(vim, "lsp") then
                local stbufnr = 0
                for _, client in ipairs(vim.lsp.get_clients()) do
                  stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
                  if client.attached_buffers[stbufnr] and client.name ~= "null-ls" then
                    return (vim.o.columns > 100 and "󰄭  " .. client.name) or "󰄭  LSP"
                  end
                end
              end
              return ""
            end,
            cond = function()
              return _G.show_more_info
            end,
          },
          -- stylua: ignore
          {
            function () return "Ux%04B" end,
            cond = function() return _G.show_more_info end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return utils.get_fg("Special")
            end,
          },
        },
        lualine_y = {
          {
            "location",
            padding = { left = 1, right = 0 },
            separator = " ",
            cond = function()
              return _G.show_more_info
            end,
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            function()
              return vim.bo.filetype:upper()
            end,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_z = {
          {
            "progress",
            separator = " ",
            -- padding = { left = 1, right = 0 },
            fmt = function(str)
              local lines = vim.api.nvim_buf_line_count(0)
              return str .. "/" .. lines
            end,
          },
        },
      },
      extensions = {
        "neo-tree",
        "lazy",
        "nvim-tree",
        "fugitive",
        "quickfix",
        "fzf",
        "mason",
        "nvim-dap-ui",
        "oil",
        "trouble",
        "toggleterm",
      },
    }

    return opts
  end,
}
