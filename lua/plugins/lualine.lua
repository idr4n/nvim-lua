local utils = require("utils")

local function fileinfo()
  local dir = utils.pretty_dirpath()()
  local path = vim.fn.expand("%:t")
  -- local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
  local name = path:match("([^/\\]+)[/\\]*$")

  return dir .. name
end

local c_dracula = {
  gray = "#2C2E3A",
  lightgray = "#333540",
  lightgray2 = "#3D4053",
  orange = "#ffb86c",
  purple = "#bd93f9",
  pink = "#FF86D3",
  red = "#ff5555",
  yellow = "#f1fa8c",
  green = "#50fa7b",
  white = "#92939B",
  black = "#282a36",
  stealth = "#787982",
}

local dracula_custom = {
  normal = {
    a = { bg = c_dracula.purple, fg = c_dracula.black, gui = "bold" },
    b = { bg = c_dracula.lightgray, fg = c_dracula.white },
    c = { bg = c_dracula.gray, fg = c_dracula.stealth },
  },
  insert = {
    a = { bg = c_dracula.green, fg = c_dracula.black, gui = "bold" },
  },
  visual = {
    a = { bg = c_dracula.pink, fg = c_dracula.black, gui = "bold" },
  },
  replace = {
    a = { bg = c_dracula.red, fg = c_dracula.black, gui = "bold" },
  },
  command = {
    a = { bg = c_dracula.orange, fg = c_dracula.black, gui = "bold" },
  },
  inactive = {
    a = { bg = c_dracula.gray, fg = c_dracula.white, gui = "bold" },
    b = { bg = c_dracula.lightgray, fg = c_dracula.white },
    c = { bg = c_dracula.gray, fg = c_dracula.stealth },
  },
}

local c_nord = {
  nord1 = "#3B4252",
  -- nord3 = "#4C566A",
  nord3 = "#323946",
  nord4 = "#96A6C4",
  nord5 = "#B1BDD2",
  nord6 = "#ECEFF4",
  nord7 = "#8FBCBB",
  nord8 = "#88C0D0",
  nord9 = "#81A1C1",
  nord11 = "#BF616A",
  nord13 = "#EBCB8B",
  nord15 = "#B48EAD",
}

local nord_custom = {
  normal = {
    a = { fg = c_nord.nord1, bg = c_nord.nord8, gui = "bold" },
    b = { fg = c_nord.nord5, bg = c_nord.nord1 },
    c = { fg = c_nord.nord4, bg = c_nord.nord3 },
  },
  insert = { a = { fg = c_nord.nord1, bg = c_nord.nord6, gui = "bold" } },
  visual = { a = { fg = c_nord.nord1, bg = c_nord.nord15, gui = "bold" } },
  command = { a = { fg = c_nord.nord1, bg = c_nord.nord13, gui = "bold" } },
  replace = { a = { fg = c_nord.nord5, bg = c_nord.nord11, gui = "bold" } },
  inactive = {
    a = { fg = c_nord.nord1, bg = c_nord.nord8, gui = "bold" },
    b = { fg = c_nord.nord5, bg = c_nord.nord1 },
    c = { fg = c_nord.nord4, bg = c_nord.nord3 },
  },
}

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
      pattern = { "dracula", "nord" },
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
        -- theme = theme,
        theme = vim.g.colors_name == "nord" and nord_custom or dracula_custom,
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "telescope" } },
        -- component_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        section_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
          or { left = "", right = "" },
      },
      sections = {
        -- stylua: ignore
        lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end, } },
        -- stylua: ignore
        lualine_b = { { function() return vim.bo.filetype:upper() end, } },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { fileinfo, padding = { left = 0, right = 1 } },
          {
            "diagnostics",
            symbols = {
              error = utils.diagnostic_icons.Error,
              warn = utils.diagnostic_icons.Warn,
              info = utils.diagnostic_icons.Info,
              hint = utils.diagnostic_icons.Hint,
            },
          },
        },
        lualine_x = {
          function()
            return require("lsp-progress").progress()
          end,
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return utils.get_fg('Statement') end
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return utils.get_fg('Constant') end
          },
          "searchcount",
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
            "progress",
            separator = " ",
            padding = { left = 1, right = 0 },
            cond = function()
              return _G.show_more_info
            end,
          },
          {
            "location",
            padding = { left = 0, right = 1 },
            cond = function()
              return _G.show_more_info
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
          { "branch", icon = "" },
        },
        lualine_z = {
          {
            function()
              local name = " " .. vim.loop.cwd():match("([^/\\]+)[/\\]*$")
              return name
            end,
            -- stylua: ignore
            cond = function() return vim.o.columns > 85 end,
          },
        },
      },
      extensions = { "neo-tree", "lazy", "nvim-tree" },
    }

    return opts
  end,
}
