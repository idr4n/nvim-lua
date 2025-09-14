local M = {}

--- Replace the home directory path with tilde for shorter display
---@param path string The file path to process
---@return string The path with home directory replaced by ~
local function replace_home_with_tilde(path)
  local home = vim.fn.expand("~")
  if path:sub(1, #home) == home then
    return "~" .. path:sub(#home + 1)
  end
  return path
end

--- Create a URL-safe slug from a file path by replacing special characters
---@param path string The file path to convert to a slug
---@return string A slug suitable for use as a filename
local function create_path_slug(path)
  -- Replace some characters with underscores
  local slug = path:gsub('[/\\:*?"<>|%.%s]', "_")

  -- Remove leading/trailing underscores and collapse multiple underscores
  slug = slug:gsub("^_+", ""):gsub("_+$", ""):gsub("_+", "_")

  return slug
end

--- Save the current session
---@param name string|nil Optional session name, defaults to current directory slug
---@param notify boolean Whether to print a notification message
function M.save_session(name, notify)
  local cwd = replace_home_with_tilde(vim.fn.getcwd())
  if not name then
    name = create_path_slug(cwd)
  end

  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  vim.fn.mkdir(session_dir, "p")
  local session_file = session_dir .. "/" .. name .. ".vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
  if notify then
    print("Session saved for " .. cwd)
  end
end

--- Load a session
---@param name string|nil Optional session name, defaults to current directory slug
function M.load_session(name)
  local cwd = replace_home_with_tilde(vim.fn.getcwd())
  if not name then
    name = create_path_slug(cwd)
  end

  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  local session_file = session_dir .. "/" .. name .. ".vim"
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
    print("Session loaded for " .. cwd)
  else
    print("Session not found for " .. cwd)
  end
end

return M
