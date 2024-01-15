local M = {}

function M.git_branch(self)
  -- local git_icon = "󰊢 "
  local git_icon = " "
  return git_icon .. self.status_dict.head
end

function M.mode(self)
  -- return " %2(" .. self.mode_names[self.mode] .. "%)"
  return " "
end

function M.mode_long(self)
  -- return " %-3(" .. self.mode_names[self.mode] .. "%) "
  return " " .. self.mode_names[self.mode] .. " "
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

---@param opts? {relative: "cwd"|"root", modified_hl: string?}
function M.pretty_dirpath(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "Constant",
  }, opts or {})

  return function()
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end
    local cwd = get_cwd()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
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

function M.scrollbar(self)
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
  return "%P " .. string.rep(self.sbar[i], 2)
end

function M.search_count()
  local ok, search = pcall(vim.fn.searchcount)
  if ok and search.total then
    return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
  end
end

function M.special(self)
  local function neotree()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  end
  local types = {
    ["lazy"] = "lazy 💤",
    ["lazyterm"] = "lazyterm 💤",
    ["lazygit"] = "Lazygit 💤",
    ["neo-tree"] = neotree(),
    -- ["neo-tree"] = "N",
    ["mason"] = "Mason",
    ["TelescopePrompt"] = "Telescope",
  }
  if string.match(self.filename, "lazygit") then
    return " " .. types["lazygit"] .. " "
  end
  return types[self.filetype] and (" " .. types[self.filetype] .. " ") or "  "
end

return M
