local M = {}

-- from https://github.com/NvChad/ui/blob/main/lua/nvchad_ui/icons.lua
M.nvchad_icons = {
  Array = "[]",
  Boolean = "",
  Calendar = "",
  Class = "",
  Codeium = "",
  Color = "󰏘",
  Constant = "",
  Constructor = "",
  Copilot = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰜢",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰊕",
  Interface = "",
  Keyword = "󰌋",
  Method = "󰊕",
  Module = "",
  Namespace = "󰌗",
  Null = "󰟢",
  Number = "",
  Object = "󰅩",
  Operator = "󰆕",
  Package = "",
  Property = "󰜢",
  Reference = "󰈇",
  Snippet = "",
  String = "󰉿",
  Struct = "󰙅",
  Table = "",
  TabNine = "",
  Tag = "",
  Text = "",
  TypeParameter = "",
  Unit = "󰑭",
  Value = "󰎠",
  Version = "",
  Variable = "",
  Watch = "󰥔",
}

M.lazyvim_icons = {
  Array = "",
  Boolean = "󰨙",
  Class = "",
  Codeium = "󰘦",
  Color = "",
  Control = "",
  Collapsed = "",
  Constant = "󰏿",
  Constructor = "",
  Copilot = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "󰊕",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "󰊕",
  Module = "",
  Namespace = "󰦮",
  Null = "",
  Number = "󰎠",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "󰆼",
  TabNine = "󰏚",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "󰀫",
}

M.git_icons = {
  added = " ",
  modified = " ",
  removed = " ",
}

M.diagnostic_icons = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = "󰌵 ",
}

M.devicons_override = {
  default_icon = {
    icon = "󰈚",
    name = "Default",
    color = "#E06C75",
  },
  toml = {
    icon = "",
    name = "toml",
    color = "#61AFEF",
  },
  tsx = {
    icon = "",
    name = "Tsx",
    color = "#20c2e3",
  },
  gleam = {
    icon = "",
    name = "Gleam",
    color = "#FFAFF3",
  },
  py = {
    icon = "",
    color = "#519ABA",
    cterm_color = "214",
    name = "Py",
  },
}

-- function used to retrieve buffers (source: heirline's cookbook.md)
function M.get_bufs()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

---@param cur_bufnr integer -- buffer number
---@param t table -- buffer number list
---@return boolean
function M.buf_in_buflist(t, cur_bufnr)
  local buf_name = function(bufnr)
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
  end
  for _, value in ipairs(t) do
    if buf_name(value) == buf_name(cur_bufnr) and value ~= cur_bufnr then
      return true
    end
  end
  return false
end

--- function to close all other buffers but the current one
---@param opts? {close_current:boolean} --default: { close_current = true }
function M.close_all_bufs(opts)
  opts = opts or { close_current = true }
  local bufs = M.get_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf or opts.close_current then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end

---@param str string
---@param min_width integer
---@return string
function M.calculate_padding(str, min_width)
  local str_width = #str
  if str_width >= min_width then
    return ""
  else
    return string.rep(" ", math.floor((min_width - str_width) / 2))
  end
end

--: Statuscolumn. Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/ui.lua
---@alias Sign {name:string, text:string, texthl:string, priority:number}
-- Returns a list of regular and extmark signs sorted by priority (low to high)
---@return Sign[]
---@param buf number
---@param lnum number
function M.get_signs(buf, lnum)
  -- Get regular signs
  ---@type Sign[]
  local signs = {}

  if vim.fn.has("nvim-0.10") == 0 then
    -- Only needed for Neovim <0.10
    -- Newer versions include legacy signs in nvim_buf_get_extmarks
    for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
      local ret = vim.fn.sign_getdefined(sign.name)[1] --[[@as Sign]]
      if ret then
        ret.priority = sign.priority
        signs[#signs + 1] = ret
      end
    end
  end

  -- Get extmark signs
  local extmarks = vim.api.nvim_buf_get_extmarks(
    buf,
    -1,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true, type = "sign" }
  )
  for _, extmark in pairs(extmarks) do
    signs[#signs + 1] = {
      name = extmark[4].sign_hl_group or "",
      text = extmark[4].sign_text,
      texthl = extmark[4].sign_hl_group,
      priority = extmark[4].priority,
    }
  end

  -- Sort by priority
  table.sort(signs, function(a, b)
    return (a.priority or 0) < (b.priority or 0)
  end)

  return signs
end

---@return Sign?
---@param buf number
---@param lnum number
function M.get_mark(buf, lnum)
  local marks = vim.fn.getmarklist(buf)
  vim.list_extend(marks, vim.fn.getmarklist())
  for _, mark in ipairs(marks) do
    if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
      return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
    end
  end
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
  sign = sign or {}
  len = len or 2
  local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
  text = text .. string.rep(" ", len - vim.fn.strchars(text))
  return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.statuscolumn()
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  local show_signs = vim.wo[win].signcolumn ~= "no"

  local components = { "", "", "" } -- left, middle, right

  local show_open_folds = false
  local use_githl = false

  if show_signs then
    local signs = M.get_signs(buf, vim.v.lnum)

    ---@type Sign?,Sign?,Sign?
    local left, right, fold, githl
    for _, s in ipairs(signs) do
      if s.name and (s.name:find("GitSign") or s.name:find("MiniDiffSign")) then
        right = s
        if use_githl then
          githl = s["texthl"]
        end
      else
        left = s
      end
    end

    vim.api.nvim_win_call(win, function()
      if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = githl or "Folded" }
      elseif show_open_folds and tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">" then -- fold start
        fold = { text = vim.opt.fillchars:get().foldopen or "", texthl = githl }
      end
    end)
    -- Left: mark or non-git sign
    components[1] = " " .. M.icon(M.get_mark(buf, vim.v.lnum) or left)
    -- Right: fold icon or git sign (only if file)
    components[3] = is_file and M.icon(fold or right) or ""
  end

  -- Numbers in Neovim are weird
  -- They show when either number or relativenumber is true
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber
  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.fn.has("nvim-0.11") == 1 then
      components[2] = "%l" -- 0.11 handles both the current and other lines with %l
    else
      if vim.v.relnum == 0 then
        components[2] = is_num and "%l" or "%r" -- the current line
      else
        components[2] = is_relnum and "%r" or "%l" -- other lines
      end
    end
    components[2] = "%=" .. components[2] .. " " -- right align
  end

  if vim.v.virtnum ~= 0 then
    components[2] = "%= "
  end

  return table.concat(components, "")
end

function M.get_fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

M.CursorMoveAround = function()
  local win_height = vim.api.nvim_win_get_height(0)
  local cursor_winline = vim.fn.winline()
  local middle_line = math.floor(win_height / 2)

  -- if cursor_winline < middle_line then
  --   vim.cmd("normal! zz")
  -- else
  --   vim.cmd("normal! zt")
  -- end
  local current_mode = vim.api.nvim_get_mode().mode
  if cursor_winline <= middle_line + 1 and cursor_winline >= middle_line - 1 then
    if current_mode == "i" then
      local current_cursor_pos = vim.api.nvim_win_get_cursor(0)
      local current_row = current_cursor_pos[1]
      local current_col = current_cursor_pos[2]

      -- Center the screen without leaving insert mode
      vim.cmd("keepjumps normal! zt")
      -- Adjust the cursor position back to the original position
      vim.api.nvim_win_set_cursor(0, { current_row, current_col })
    else
      vim.cmd("normal! zt")
    end
  else
    if current_mode == "i" then
      local current_cursor_pos = vim.api.nvim_win_get_cursor(0)
      local current_row = current_cursor_pos[1]
      local current_col = current_cursor_pos[2]

      -- Center the screen without leaving insert mode
      vim.cmd("keepjumps normal! zz")
      -- Adjust the cursor position back to the original position
      vim.api.nvim_win_set_cursor(0, { current_row, current_col })
    else
      vim.cmd("normal! zz")
    end
  end
end

M.bg = "#000000"
M.fg = "#ffffff"

---@param c string
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
  if vim.o.background == "dark" then
    -- if the background is dark, lighten instead
    return blend(hex, bg or M.fg, amount)
  end
  return blend(hex, bg or M.bg, amount)
end

function M.lighten(hex, amount, fg)
  if vim.o.background == "light" then
    -- if the background is light, darken instead
    return blend(hex, fg or M.bg, amount)
  end
  return blend(hex, fg or M.fg, amount)
end

local function get_cwd()
  local function realpath(path)
    if path == "" or path == nil then
      return nil
    end
    return vim.loop.fs_realpath(path) or path
  end

  return realpath(vim.loop.cwd()) or ""
end

---@return fun():string
function M.pretty_dirpath()
  return function()
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end
    local cwd = get_cwd()

    if path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    table.remove(parts)
    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    return #parts > 0 and (table.concat(parts, sep) .. "/") or ""
  end
end

---Get number of words in the current markdown or text buffer
---@return string
function M.get_words()
  if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == nil then
      return " " .. " " .. tostring(vim.fn.wordcount().words) .. " "
    end
    return " " .. " " .. tostring(vim.fn.wordcount().visual_words) .. " "
  else
    return ""
  end
end

return M
