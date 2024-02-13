local M = {}

local utils = require("heirline.utils")
local ut = require("utils")

--- Statusline colors
M.colors = {
  black = utils.get_highlight("StatusLine").bg,
  dark_black = "#191B28",
  green = "#4fd6be",
  orange = "#ff966c",
  yellow = "#E2B86B",
  -- yellow = "#BC9A5C",
  red = "#DE6E7C",
  -- red = "#B55A67",
  blue = utils.get_highlight("Function").fg or "#82AAFF",
  -- blue = "#687CAD",
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  gray = utils.get_highlight("NonText").fg,

  -- stealth = "#4E546B",
  stealth = ut.darken(string.format("#%06x", utils.get_highlight("Normal").bg), 0.8),

  -- insert = "#C3E88D",
  -- insert = "#C882E7",
  insert = utils.get_highlight("Statement").fg or "#C882E7",
  -- insert = "#718107",
  select = "#FCA7EA",
  -- select = "#966B8D",
  terminal = utils.get_highlight("Keyword").fg or utils.get_highlight("StatusLine").fg,
  -- terminal = "#538797",
  active_tab_bg = "#1B1C2A",
  -- active_tab_bg = "#181925",
  normal_fg = utils.get_highlight("Normal").fg,
  normal_bg = utils.get_highlight("Normal").bg,
  status_bg = utils.get_highlight("StatusLine").bg,
  status_fg = utils.get_highlight("StatusLine").fg,

  fg_darken = ut.darken(string.format("#%06x", utils.get_highlight("Normal").bg), 0.55),
  bg_lighten = ut.lighten(string.format("#%06x", utils.get_highlight("Normal").bg), 0.96),
  bg_lighten_less = ut.lighten(string.format("#%06x", utils.get_highlight("Normal").bg), 0.98),

  bright_bg = utils.get_highlight("Folded").bg,
  string = utils.get_highlight("String").fg,
  constant = utils.get_highlight("Constant").fg or utils.get_highlight("StatusLine").fg,
  keyword = utils.get_highlight("Keyword").fg or utils.get_highlight("StatusLine").fg,
  comment = utils.get_highlight("Comment").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("GitSignsDelete").fg or utils.get_highlight("DiffDelete").fg,
  git_add = utils.get_highlight("GitSignsAdd").fg or utils.get_highlight("DiffAdded").fg,
  git_change = utils.get_highlight("GitSignsChange").fg or utils.get_highlight("DiffChange").fg,
}

--- Statusline mode names and colors
M.mode = {
  names = { -- change the strings if you like it vvvvverbose!
    n = "N",
    no = "N?",
    nov = "N?",
    noV = "N?",
    ["no\22"] = "N?",
    niI = "Ni",
    niR = "Nr",
    niV = "Nv",
    nt = "Nt",
    v = "V",
    vs = "Vs",
    V = "V",
    Vs = "Vs",
    ["\22"] = "^V",
    ["\22s"] = "^V",
    s = "S",
    S = "S_",
    ["\19"] = "^S",
    i = "I",
    ic = "Ic",
    ix = "Ix",
    R = "R",
    Rc = "Rc",
    Rx = "Rx",
    Rv = "Rv",
    Rvc = "Rv",
    Rvx = "Rv",
    c = "C",
    cv = "Ex",
    r = "...",
    rm = "M",
    ["r?"] = "?",
    ["!"] = "!",
    t = "T",
  },
  colors = {
    n = "blue",
    i = "insert",
    v = "select",
    V = "select",
    ["\22"] = "select",
    c = "yellow",
    s = "purple",
    S = "purple",
    ["\19"] = "purple",
    R = "red",
    r = "red",
    ["!"] = "orange",
    t = "terminal",
  },
}

--- A function that adds specific space padding to a string
---@param s string
---@param opts? {padding_left:integer, padding_right:integer}
---@return string
function M.add_padding(s, opts)
  opts = opts or {}
  opts.padding_left = opts.padding_left or 1
  opts.padding_right = opts.padding_right or 1
  local left_padding = string.rep(" ", opts.padding_left)
  local right_padding = string.rep(" ", opts.padding_right)
  return string.format("%s%s%s", left_padding, s, right_padding)
end

---@param opts? {color:SimpleColor}
---@param mode_fg? boolean If true, mode color is used for the text fg color
---@return Component # heirline component
function M.mode_setup(opts, mode_fg)
  opts = vim.tbl_deep_extend("force", {
    color = { fg = "black", bg = "none", bold = false },
  }, opts or {}) --[[@as {color:SimpleColor}]]
  return {
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
      fg_color = opts.color.fg,
      bg_color = opts.color.bg,
      bold_text = opts.color.bold,
      mode_names = M.mode.names,
      mode_colors = M.mode.colors,
    },
    hl = function(self)
      local cur_mode = self.mode:sub(1, 1) -- get only the first mode character
      if mode_fg then
        return { fg = self.mode_colors[cur_mode], bg = self.bg_color, bold = self.bold_text }
      end
      return { fg = self.fg_color, bg = self.mode_colors[cur_mode], bold = self.bold_text }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
end

return M
