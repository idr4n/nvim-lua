local c_dracula = {
  gray = "#2C2E3A",
  lightgray = "#373946",
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

local c_minimal = {
  highlight = "#444444",
  statusline_bg = "#303030",
  statusline_fg = "#D4BE98",
  statusline_nc = "#A89983",
  grey = "#505257",
  red = "#CC241D",
  green = "#A8B765",
  magenta = "#FF87D7",
  yellow = "#D8A658",
}

local minimal = {
  normal = {
    a = { bg = c_minimal.statusline_nc, fg = c_minimal.statusline_bg, gui = "bold" },
    b = { bg = c_minimal.highlight, fg = c_minimal.statusline_nc },
    c = { bg = c_minimal.statusline_bg, fg = c_minimal.statusline_nc },
  },
  insert = {
    a = { bg = c_minimal.green, fg = c_minimal.statusline_bg, gui = "bold" },
  },
  visual = {
    a = { bg = c_minimal.magenta, fg = c_minimal.statusline_bg, gui = "bold" },
  },
  replace = {
    a = { bg = c_minimal.red, fg = c_minimal.statusline_fg, gui = "bold" },
  },
  command = {
    a = { bg = c_minimal.yellow, fg = c_minimal.statusline_bg, gui = "bold" },
  },
  inactive = {
    a = { bg = c_minimal.grey, fg = c_minimal.statusline_fg, gui = "bold" },
    b = { bg = c_minimal.lightgray, fg = c_minimal.statusline_fg },
    c = { bg = c_minimal.statusline_bg, fg = c_minimal.grey },
  },
}

local dracula_custom = {
  normal = {
    a = { bg = c_dracula.purple, fg = c_dracula.black, gui = "bold" },
    b = { bg = c_dracula.lightgray, fg = c_dracula.purple },
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

-- return {
--   "nvim-lualine/lualine.nvim",
--   opts = function()
--     -- local theme = vim.g.colors_name == "dracula" and "dracula-nvim" or "auto"
--     local theme = vim.g.colors_name == "dracula" and dracula_custom or "auto"
--     return {
--       options = {
--         -- component_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
--         --   or { left = "", right = "" },
--         section_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
--           or { left = "", right = "" },
--         theme = theme,
--       },
--     }
--   end,
-- }

local utils = require("utils")
local theme = vim.g.colors_name == "dracula" and dracula_custom or "auto"
-- local theme = "powerline"
-- local custom_theme = require("lualine.themes.github-monochrome-light")
-- local custom_theme = require("lualine.themes.base").get({ style = "light" })
-- custom_theme.normal.c.fg = "#000000"
-- custom_theme.normal.c.bg = "#ff0000"

local function fileinfo()
  local dir = utils.pretty_dirpath()()
  local path = vim.fn.expand("%:t")
  -- local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")
  local name = path:match("([^/\\]+)[/\\]*$")

  return dir .. "/" .. "%#Bold#" .. name .. "%#lualine_c_normal#" .. " %m%r%h%w "
end

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "󰑋 " .. recording_register
  end
end

local function scrollbar()
  local sbar_chars = { "󰋙", "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈" }

  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)

  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
  local sbar = sbar_chars[i]

  return sbar
end

local group_number = function(num, sep)
  if num < 999 then
    return tostring(num)
  else
    num = tostring(num)
    return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
  end
end

local function get_vlinecount_str()
  local raw_count = vim.fn.line(".") - vim.fn.line("v")
  raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

  return group_number(math.abs(raw_count), ",")
end

---Get wordcount for current buffer or visual selection
--- @return string word count
local function get_fileinfo_widget()
  local wc_table = vim.fn.wordcount()

  if wc_table.visual_words and wc_table.visual_chars then
    return table.concat({
      "‹›",
      " ",
      get_vlinecount_str(),
      " lines  ",
      group_number(wc_table.visual_chars, ","),
      " chars",
    })
  end
  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  cond = false,
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

    vim.o.laststatus = vim.g.lualine_laststatus

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = "lualine_augroup",
      pattern = { "dracula", "nord", "*" },
      callback = function()
        if vim.g.colors_name == "nord" then
          require("lualine").setup({ options = { theme = "nord" } })
        else
          require("lualine").setup({ options = { theme = theme } })
        end
      end,
    })

    local opts = {
      options = {
        theme = vim.g.colors_name == "minimal" and minimal or theme,
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "telescope" } },
        -- section_separators = vim.env.TERM == "alacritty" and { left = "", right = "" }
        --   or { left = "", right = "" },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
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
          {
            "branch",
            icon = "",
            cond = function()
              return _G.show_more_info
            end,
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          {
            fileinfo,
            padding = { left = 1, right = 0 },
            separator = "",
          },
          function()
            return "%="
          end,
          {
            utils.get_words,
            padding = { left = 0, right = 0 },
            -- color = { fg = "#333333", bg = "#FFAFF3" },
            -- color = { fg = "#BEC6F1", bg = "#6B50FF" },
            color = "lualine_a_normal",
            separator = vim.env.TERM ~= "alacritty" and { left = "", right = "" },
            cond = function()
              return utils.get_words() ~= ""
            end,
          },
          {
            show_macro_recording,
            -- color = { fg = "#333333", bg = "#ff6666", gui = "bold" },
            color = "lualine_a_replace",
            separator = { left = "", right = "" },
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function()
              return require("lsp-progress").progress()
            end,
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
            cond = function()
              return _G.show_more_info
            end,
          },
          get_fileinfo_widget,
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
            fmt = function()
              local lines = vim.api.nvim_buf_line_count(0)
              return lines .. " " .. scrollbar()
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
