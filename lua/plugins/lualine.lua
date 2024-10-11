local utils = require("utils")
local theme = require("config.lualine.themes").theme

local function fileinfo()
  local dir = utils.pretty_dirpath()()
  local path = vim.fn.expand("%:t")
  -- local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
  local name = path:match("([^/\\]+)[/\\]*$")

  return dir .. name
end

return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
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
          require("lualine").setup({ options = { theme = dracula_custom } })
        end
      end,
    })

    local opts = {
      options = {
        -- theme = "auto",
        theme = theme[vim.g.colors_name] or "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "telescope" } },
        -- component_separators = { left = "", right = "" },
        component_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
          or { left = "", right = "" },
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
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = utils.diagnostic_icons.Error,
              warn = utils.diagnostic_icons.Warn,
              info = utils.diagnostic_icons.Info,
              hint = utils.diagnostic_icons.Hint,
            },
          },
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { fileinfo, padding = { left = 0, right = 1 } },
          fileinfo,
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("lsp-progress").progress() end,
            color = function() return utils.get_fg("Added") and utils.get_fg("Added") or utils.get_fg("DiffAdded") and utils.get_fg("DiffAdded") or utils.get_fg("DiffAdd") end
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return utils.get_fg("Statement") end
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return utils.get_fg("Constant") end
          },
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
                  sleep = " ", -- auto-trigger disabled
                  -- disabled = " ",
                  disabled = "",
                  warning = " ",
                  -- unknown = " "
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
          { utils.get_words, padding = { right = 0 } },
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
          {
            "diff",
            symbols = {
              added = utils.git_icons.added,
              modified = utils.git_icons.modified,
              removed = utils.git_icons.removed,
            },
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
          -- stylua: ignore
          -- {
          --   function() return vim.api.nvim_buf_line_count(0) .. "" end,
          --   separator = " ",
          --   padding = { left = 1, right = 0 },
          -- },
        },
        lualine_z = {
          -- {
          --   function()
          --     local name = " " .. vim.loop.cwd():match("([^/\\]+)[/\\]*$")
          --     return name
          --   end,
          --   -- stylua: ignore
          --   cond = function() return vim.o.columns > 85 end,
          -- },
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
