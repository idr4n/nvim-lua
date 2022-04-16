-- "nvim-lualine/lualine.nvim"

local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

-- local lineNum = vim.api.nvim_win_get_cursor(0)[1]
local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
  local val = vim.api.nvim_win_get_cursor(0)[2]
  -- pad value to 3 units to stop geometry shift
  return string.format("%03d", val)
end

local function getDir()
  local dir = tostring(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
  if #dir > 13 then
    dir = dir:sub(1, 11) .. ".."
  end
  return " " .. dir
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- get zeobones lualine
local function getZenbones()
  local t = os.date("*t").hour
  -- local term = os.getenv("TERM_PROGRAM")
  -- if (t >= 7 and t < 18) and (term == 'iTerm.app' or term == 'tmux') then
  if (t >= 7 and t < 18) then
    return "zenbones"
  end
  -- return night theme instead
  -- return "zenbones"
  return "nordbones"
  -- return "tokyonight"
end

-- get colors from Nightfox to use in the words count
-- local nfColors = require("nightfox.colors").init("nordfox")

-- print(vim.inspect(nfColors))
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = getZenbones(),
    -- component_separators = { left = ' ', right = ' '},
    -- section_separators = { left = '', right = ''},
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = " " },
    -- section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source, color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      function()
        return "%="
      end,
      "filename",
      {
        getWords,
        -- color = { fg = nfColors["bg_alt"] or "#333333", bg = nfColors["fg"] or "#eeeeee" },
        -- color = { fg = "#333333", bg = "#eeeeee" },
        -- separator = { left = "", right = "" },
        separator = { left = "", right = "" },
      },
    },
    lualine_x = { "filetype" },
    lualine_y = {},
    lualine_z = {
      { getDir },
      { getColumn, padding = { left = 1, right = 0 } },
      { getLines, icon = "", padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})

