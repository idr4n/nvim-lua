local M = {}

--   פּ ﯟ   some other good icons
M.kind_icons = {
  Class = "󰌗 ",
  Color = "󰏘 ",
  Constant = "󰇽 ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = "󰈙 ",
  Folder = "󰉋 ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = "󰌋 ",
  Method = "m ",
  Module = " ",
  Operator = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  Struct = " ",
  Text = "󰉿 ",
  TypeParameter = "󰊄 ",
  Unit = " ",
  Value = "󰎠 ",
  Variable = "󰆧 ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- from https://github.com/NvChad/ui/blob/main/lua/nvchad_ui/icons.lua
M.nvchad_icons = {
  -- Class = "󰠱",
  -- Constant = "󰏿",
  -- EnumMember = "󰒻",
  -- Text = "󰉿",
  -- TypeParameter = "󰊄",
  -- Variable = "",
  -- Variable = "󰂡",
  Array = "[]",
  Boolean = "",
  Calendar = "",
  Class = "",
  Color = "󰏘",
  Constant = "",
  Constructor = "",
  -- Enum = "󰒻",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰜢",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰆧",
  Interface = "",
  Keyword = "󰌋",
  Method = "󰆧",
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
  Tag = "",
  Text = "",
  TypeParameter = "",
  Unit = "󰑭",
  Value = "󰎠",
  Variable = "",
  Watch = "󰥔",
}

M.nyoom_icons = {
  Class = "  ",
  Color = "  ",
  Constant = "  ",
  Constructor = "  ",
  Copilot = "  ",
  Enum = "  ",
  EnumMember = "  ",
  Event = "  ",
  Field = "  ",
  File = "  ",
  Folder = "  ",
  Function = "  ",
  Interface = "  ",
  Keyword = "  ",
  Method = "  ",
  Module = "  ",
  Operator = "  ",
  Property = "  ",
  Reference = "  ",
  Snippet = "  ",
  Struct = "  ",
  Text = "  ",
  TypeParameter = "  ",
  Unit = "  ",
  Value = "  ",
  Variable = "  ",
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
  Hint = " ",
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

  if show_signs then
    ---@type Sign?,Sign?,Sign?
    local left, right, fold
    for _, s in ipairs(M.get_signs(buf, vim.v.lnum)) do
      if s.name and s.name:find("GitSign") then
        right = s
      else
        left = s
      end
    end
    if vim.v.virtnum ~= 0 then
      left = nil
    end
    vim.api.nvim_win_call(win, function()
      if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
      end
    end)
    -- Left: mark or non-git sign
    components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
    -- Right: fold icon or git sign (only if file)
    components[3] = is_file and M.icon(fold or right) or ""
  end

  -- Numbers in Neovim are weird
  -- They show when either number or relativenumber is true
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber
  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      components[2] = is_num and "%l" or "%r" -- the current line
    else
      components[2] = is_relnum and "%r" or "%l" -- other lines
    end
    components[2] = "%=" .. components[2] .. " " -- right align
  end

  return table.concat(components, "")
end

function M.fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

-- source: NvChad config
M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand("%")
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load({ plugins = plugin })

            if plugin == "nvim-lspconfig" then
              vim.cmd("silent! do FileType")
            end
          end, 0)
        else
          require("lazy").load({ plugins = plugin })
        end
      end
    end,
  })
end

return M
