-- Statusline components

local utils = require("utils")

local M = {}

function _G.get_lang_version(language)
  local script_path = "get_lang_version" -- Adjust the path to the Bash script if needed
  local cmd = script_path .. " " .. language
  local result = vim.fn.system(cmd)
  return result:gsub("^%s*(.-)%s*$", "%1")
end

_G.lang_versions = {}

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = {
    "*.py",
    "*.lua",
    "*.go",
    "*.rs",
    "*.js",
    "*.ts",
    "*.jsx",
    "*.tsx",
    -- "*.cpp",
    "*.java",
    "*.vue",
    "*ex",
    "*exs",
  },
  callback = function()
    local filetype = vim.bo.filetype
    local lang_v = _G.lang_versions[filetype]
    if not lang_v then
      _G.lang_versions[filetype] = _G.get_lang_version(filetype)
    end
  end,
  group = vim.api.nvim_create_augroup("idr4n/lang_version", { clear = true }),
})

local mode_color = {
  ["n"] = { "N", "%#StatusNormal#" },
  ["i"] = { "I", "%#StatusInsert#" },
  ["ic"] = { "I", "%#StatusInsert#" },
  ["v"] = { "V", "%#StatusVisual#" },
  ["V"] = { "V-L", "%#StatusVisual#" },
  ["\22"] = { "^V", "%#StatusVisual#" },
  ["\22s"] = { "^V", "%#StatusVisual#" },
  ["R"] = { "R", "%#StatusReplace#" },
  ["c"] = { "C", "%#StatusCommand#" },
  ["t"] = { "T", "%#StatusCommand#" },
  ["nt"] = { "T", "%#StatusCommand#" },
}

---@return string
---@param opts? {name:string, align:string}
function M.decorator(opts)
  opts = vim.tbl_extend("force", { name = " ", align = "left" }, opts)
  local align = vim.tbl_contains({ "left", "right" }, opts.align) and opts.align or "left"
  local name = opts.name
  return (align == "right" and "%=" or "") .. "%#SLDecorator# " .. name .. " %#SLNormal#"
end

function M.mode()
  local mode_hl = mode_color[vim.fn.mode()] or nil
  if mode_hl then
    return mode_hl[2] .. " " .. mode_hl[1] .. " %#SLNormal#"
  else
    return mode_color["n"][2] .. " " .. mode_color["n"][1] .. " %#SLNormal#"
  end
end

-- source: modified from https://github.com/MariaSolOs/dotfiles/blob/fedora/.config/nvim/lua/statusline.lua
--- Keeps track of the highlight groups already created.
---@type table<string, boolean>
local statusline_hls = {}

---@param hl_bg? string
---@param hl_fg string
---@return string
function M.get_or_create_hl(hl_fg, hl_bg)
  hl_bg = hl_bg or "Normal"
  local hl_name = "SL" .. hl_fg .. hl_bg

  if not statusline_hls[hl_name] then
    -- If not in the cache, create the highlight group
    local bg_hl = vim.api.nvim_get_hl(0, { name = hl_bg })
    local fg_hl = vim.api.nvim_get_hl(0, { name = hl_fg })

    if not bg_hl.bg then
      bg_hl = vim.api.nvim_get_hl(0, { name = "Statusline" })
    end
    if not fg_hl.fg then
      fg_hl = vim.api.nvim_get_hl(0, { name = "Statusline" })
    end

    vim.api.nvim_set_hl(
      0,
      hl_name,
      { bg = bg_hl.bg and ("#%06x"):format(bg_hl.bg) or "none", fg = ("#%06x"):format(fg_hl.fg) }
    )
    statusline_hls[hl_name] = true
  end

  return "%#" .. hl_name .. "#"
end

function M.clear_hl_cache()
  statusline_hls = {}
end

---@return string
---@param opts? {mono:boolean}
local function file_icon(opts)
  opts = opts or { mono = true }
  local devicons = require("nvim-web-devicons")
  local icon, icon_highlight_group = devicons.get_icon(vim.fn.expand("%:t"))
  if icon == nil then
    icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
  end

  if icon == nil and icon_highlight_group == nil then
    icon = ""
    icon_highlight_group = "DevIconDefault"
  end

  local hl_icon = "%#SLBgLightenLess#"

  if not opts.mono then
    hl_icon = M.get_or_create_hl(icon_highlight_group, "SLBgLightenLess")
  end

  if not vim.bo.modifiable then
    icon = ""
    icon_highlight_group = "SLNotModifiable"
    return "  %#SLNotModifiable#" .. icon
  end

  return hl_icon .. " " .. icon
end

function M.get_fileinfo()
  local filename = ""

  if vim.fn.expand("%") == "" then
    return " nvim "
  end

  local icon = file_icon({ mono = false }) .. " "
  filename = icon
    .. "%#StatusDir#"
    .. (vim.fn.expand("%:p:h:t"))
    .. "/"
    .. "%#SLFileName#"
    .. vim.fn.expand("%:t")
    .. "%#SLNormal# "

  if vim.bo.modified then
    filename = (vim.fn.expand("%:p:h:t")) .. "/" .. vim.fn.expand("%:t")
    return icon .. "%#SLModified#" .. filename .. "  " .. "%#SLNormal# "
  end

  return filename
end

---@return string
---@param opts? {add_icon:boolean}
function M.fileinfo(opts)
  opts = opts or { add_icon = true }
  local icon = opts.add_icon and "󰈚 " or ""
  local dir = utils.pretty_dirpath()()
  local path = vim.fn.expand("%:t")
  local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

  if name ~= "Empty " and opts.add_icon then
    local devicons_present, icons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = icons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end

  return (opts.add_icon and " " .. icon .. " " or " ") .. dir .. name .. " %m%r%h%w "
end

function M.progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  if cur == 1 then
    return "Top"
  elseif cur == total then
    return "Bot"
  else
    return string.format("%2d", math.floor(cur / total * 100)) .. "%%"
  end
end

function M.get_position()
  return " %3l:%-2c %-2L "
end

function M.search_count()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local ok, count = pcall(vim.fn.searchcount, { recompute = true, maxcount = 500 })
  if (not ok or (count.current == nil)) or (count.total == 0) then
    return ""
  end

  -- local hl_match = _G.show_more_info and "%#SLNormal#" or "%#SLStealth#"
  -- local hl_match = "%#SLStealth#"
  local hl_match = "%#SLBgLightenLess#"

  if count.incomplete == 1 then
    return "%#SLMatches# ?/? " .. hl_match
  end

  local too_many = (">%d"):format(count.maxcount)
  local total = (((count.total > count.maxcount) and too_many) or count.total)

  return ("  %#SLMatches#" .. (" %s/%s "):format(count.current, total) .. hl_match)
end

function M.get_bufnr()
  return "%#SLBufNr#" .. vim.api.nvim_get_current_buf() .. "%#SLNormal#"
end

function M.maximized_status()
  return vim.t.maximized and "  %#SLModified# %#SLNormal#" or ""
end

function M.lsp_running()
  if not vim.bo.modifiable then
    return ""
  end

  if #vim.lsp.get_clients() > 0 then
    return " " .. "%#SLBufNr#󱓞 " .. "%#SLNormal#" .. " "
  else
    return ""
  end
end

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

function M.LSP()
  if rawget(vim, "lsp") then
    local padding = 1
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
        return (vim.o.columns > 100 and " 󰄭  " .. client.name .. string.rep(" ", padding))
          or (" 󰄭  LSP" .. string.rep(" ", padding))
      end
    end
  end

  return ""
end

M.get_words = utils.get_words

function M.charcode()
  return _G.charcode and " %#SLBufNr#Ux%04B%#SLNormal# " or ""
end

function M.colemak()
  return _G.colemak and " %#SLBufNr#󰯳 󰌌 %#SLNormal#  " or ""
end

function M.status_command()
  local command = require("noice").api.status.command.get()
  local mode = require("noice").api.status.mode.get()
  local command_str = command and " %#SLBufNr#" .. string.format("%-3s", command) .. "%#SLNormal#" or ""
  local mode_str = mode and "  %#SLBufNr#" .. mode .. "%#SLNormal#" or ""
  return command_str .. mode_str
end

function M.status_noice()
  local mode = require("noice").api.status.mode.get()
  local mode_str = mode and M.get_or_create_hl("SLBgNoneHl") .. "[" .. mode .. "]%#SLNormal# " or ""
  return mode_str
end

---@return string
---@param opts? {mono:boolean}
function M.git_hunks(opts)
  opts = opts or { mono = true }
  local hunks = require("gitsigns").get_hunks()
  local nhunks = hunks and #hunks or 0
  local status = ""
  local hunk_icon = " "
  if nhunks > 0 then
    status = opts.mono and "%#SLBgLightenLess#" .. " " .. hunk_icon .. nhunks
      or "%#SLGitHunks#" .. " " .. hunk_icon .. nhunks
  end
  return nhunks > 0 and status .. " " or ""
end

---@return string
---@param opts? {mono:boolean}
function M.git_status(opts)
  opts = opts or { mono = true }
  local gitsigns = vim.b.gitsigns_status_dict

  local diff_icons = {
    added = " ",
    modified = " ",
    removed = " ",
  }

  local total_changes = 0
  local git_status = ""

  if gitsigns then
    total_changes = (gitsigns.added or 0) + (gitsigns.changed or 0) + (gitsigns.removed or 0)
    local added = ""
    local changed = ""
    local removed = ""

    if opts.mono then
      added = (gitsigns.added or 0) > 0 and " " .. diff_icons.added .. gitsigns.added or ""
      changed = (gitsigns.changed or 0) > 0 and " " .. diff_icons.modified .. gitsigns.changed or ""
      removed = (gitsigns.removed or 0) > 0 and " " .. diff_icons.removed .. gitsigns.removed or ""

      return total_changes > 0 and "%#SLBgLightenLess#" .. added .. changed .. removed .. " " or ""
    else
      if gitsigns.added and gitsigns.added > 0 then
        added = M.get_or_create_hl("GitSignsAdd", "SLBgLightenLess") .. " " .. diff_icons.added .. gitsigns.added
      end
      -- stylua: ignore
      if gitsigns.changed and gitsigns.changed > 0 then
        changed = M.get_or_create_hl("GitSignsChange", "SLBgLightenLess") .. " " .. diff_icons.modified .. gitsigns.changed
      end
      -- stylua: ignore
      if gitsigns.removed and gitsigns.removed > 0 then
        removed = M.get_or_create_hl("GitSignsDelete", "SLBgLightenLess") .. " " .. diff_icons.removed .. gitsigns.removed
      end
    end

    git_status = total_changes > 0 and added .. changed .. removed or ""
  end

  return git_status
end

---@return string
function M.git_status_simple()
  local gitsigns = vim.b.gitsigns_status_dict

  -- local diff_icon = "◦"
  local diff_icon = "•"
  local total_changes = 0
  local git_status = ""

  if gitsigns then
    total_changes = (gitsigns.added or 0) + (gitsigns.changed or 0) + (gitsigns.removed or 0)
    local added = ""
    local changed = ""
    local removed = ""

    if gitsigns.added and gitsigns.added > 0 then
      added = "%#GitSignsAdd#" .. diff_icon
    end
    -- stylua: ignore
    if gitsigns.changed and gitsigns.changed > 0 then
      changed = "%#GitSignsChange#" .. diff_icon
    end
    -- stylua: ignore
    if gitsigns.removed and gitsigns.removed > 0 then
      removed = "%#GitSignsDelete#" .. diff_icon
    end

    git_status = total_changes > 0 and added .. changed .. removed .. " " or ""
  end

  return git_status
end

---@return string
function M.git_boring()
  local gitsigns = vim.b.gitsigns_status_dict

  -- local icon = "󰓎"
  local icon = "*"
  local total_changes = 0

  if gitsigns then
    total_changes = (gitsigns.added or 0) + (gitsigns.changed or 0) + (gitsigns.removed or 0)
  end

  return total_changes > 0 and (vim.bo.modified and " " or "") .. "%#SLBgNoneHl#" .. icon .. "%#SLBgNone#" or ""
end

function M.git_branch()
  local branch = vim.b.gitsigns_status_dict or { head = "" }
  local git_icon = " "
  local is_head_empty = (branch.head ~= "")
  return is_head_empty and string.format(" %s%s ", git_icon, (branch.head or "")) or ""
end

function M.lang_version()
  local filetype = vim.bo.filetype
  local lang_v = _G.lang_versions[filetype]
  return lang_v and " (" .. filetype .. " " .. lang_v .. ") " or ""
end

function M.cwd()
  local hl = "%#SLBgLighten#"
  local name = hl .. "  " .. vim.loop.cwd():match("([^/\\]+)[/\\]*$") .. " "
  return (vim.o.columns > 85 and name) or ""
end

function M.filetype()
  local filetype = vim.bo.filetype
  return "%#SLBgLighten# " .. filetype:upper() .. " "
end

---@return string
function M.diagnostics_boring()
  local function get_severity(s)
    return #vim.diagnostic.get(0, { severity = s })
  end

  local result = {
    errors = get_severity(vim.diagnostic.severity.ERROR),
    warnings = get_severity(vim.diagnostic.severity.WARN),
    info = get_severity(vim.diagnostic.severity.INFO),
    hints = get_severity(vim.diagnostic.severity.HINT),
  }

  -- local icon = "󱈸"
  local icon = "!"
  local total = result.errors + result.warnings + result.hints + result.info

  return total > 0 and "%#SLBgNoneHl#" .. icon .. "%#SLBgNone#" or ""
end

---@return string
---@param opts? {mono:boolean}
function M.lsp_diagnostics(opts)
  opts = opts or { mono = true }
  local icons = require("utils").diagnostic_icons
  local function get_severity(s)
    return #vim.diagnostic.get(0, { severity = s })
  end

  local result = {
    errors = get_severity(vim.diagnostic.severity.ERROR),
    warnings = get_severity(vim.diagnostic.severity.WARN),
    info = get_severity(vim.diagnostic.severity.INFO),
    hints = get_severity(vim.diagnostic.severity.HINT),
  }

  local total = result.errors + result.warnings + result.hints + result.info
  local errors = ""
  local warnings = ""
  local info = ""
  local hints = ""

  if opts.mono then
    errors = result.errors > 0 and " " .. icons.Error .. result.errors or ""
    warnings = result.warnings > 0 and " " .. icons.Warn .. result.warnings or ""
    info = result.info > 0 and " " .. icons.Info .. result.info or ""
    hints = result.hints > 0 and " " .. icons.Hint .. result.hints or ""

    return vim.bo.modifiable and total > 0 and "%#SLBgLightenLess#" .. errors .. warnings .. info .. hints .. " " or ""
  else
    if result.errors > 0 then
      errors = M.get_or_create_hl("DiagnosticError", "SLBgLightenLess") .. " " .. icons.Error .. result.errors
    end
    if result.warnings > 0 then
      warnings = M.get_or_create_hl("DiagnosticWarn", "SLBgLightenLess") .. " " .. icons.Warn .. result.warnings
    end
    if result.info > 0 then
      info = M.get_or_create_hl("DiagnosticInfo", "SLBgLightenLess") .. " " .. icons.Info .. result.info
    end
    if result.hints > 0 then
      hints = M.get_or_create_hl("DiagnosticHint", "SLBgLightenLess") .. " " .. icons.Hint .. result.hints
    end

    if vim.bo.modifiable and total > 0 then
      return warnings .. errors .. info .. hints .. " "
    end
  end

  return ""
end

---@return string
function M.lsp_diagnostics_simple()
  local icons = require("utils").diagnostic_icons
  local function get_severity(s)
    return #vim.diagnostic.get(0, { severity = s })
  end

  local result = {
    errors = get_severity(vim.diagnostic.severity.ERROR),
    warnings = get_severity(vim.diagnostic.severity.WARN),
    info = get_severity(vim.diagnostic.severity.INFO),
    hints = get_severity(vim.diagnostic.severity.HINT),
  }

  local total = result.errors + result.warnings + result.hints + result.info
  local errors = ""
  local warnings = ""
  local info = ""
  local hints = ""

  -- local icon = "•"
  local icon = "◦"

  if result.errors > 0 then
    errors = M.get_or_create_hl("DiagnosticError") .. icon
  end
  if result.warnings > 0 then
    warnings = M.get_or_create_hl("DiagnosticWarn") .. icon
  end
  if result.info > 0 then
    info = M.get_or_create_hl("DiagnosticInfo") .. icon
  end
  if result.hints > 0 then
    hints = M.get_or_create_hl("DiagnosticHint") .. icon
  end

  if vim.bo.modifiable and total > 0 then
    return warnings .. errors .. info .. hints .. " "
  end

  return ""
end

function M.scrollbar()
  local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((curr_line - 1) / lines * #sbar) + 1
  if sbar[i] then
    return "%#StatusCommand#" .. string.rep(sbar[i], 2) .. "%#SLNormal# "
  end
end

-- codeium status in the statusline
function M.codeium_status()
  if vim.g.codeium_enabled then
    local status = vim.api.nvim_call_function("codeium#GetStatusString", {})
    return "%#SLBgNoneHl# [ " .. status .. "]" .. "%#SLBgNone# "
  end

  return ""
end

function M.terminal_status()
  local is_terminal_open = false
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buffer].buftype == "terminal" then
      is_terminal_open = true
    end
  end
  -- return is_terminal_open and "%#SLBgNoneHl# []" .. "%#SLBgNone# " or ""
  return is_terminal_open and M.get_or_create_hl("SLBgNoneHl") .. " []" .. "%#SLNormal# " or ""
end

function M.lsp_progress()
  return require("lsp-progress").progress() .. " "
end

return M
