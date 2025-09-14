local M = {}
local zk_dir = vim.env.ZK_NOTEBOOK_DIR

function M.get_backlinks(path, callback)
  vim.system({ "zk", "list", "-q", "-f", "json", "-l", path }, {}, function(result)
    local paths = {}

    if result.code == 0 and result.stdout and result.stdout ~= "" then
      local ok, json_data = pcall(vim.json.decode, result.stdout)
      if ok and json_data and type(json_data) == "table" then
        for _, note in ipairs(json_data) do
          if note and note.path then
            table.insert(paths, note.path)
          end
        end
      end
    end

    callback(paths)
  end)
end

-- Check if current buffer is in ZK directory
function M.is_zk_note(bufnr)
  if not zk_dir then
    return false
  end

  local file_path = bufnr and vim.api.nvim_buf_get_name(bufnr) or vim.fn.expand("%:p")
  return vim.startswith(file_path, zk_dir)
end

-- Namespace for our virtual text
local ns_id = vim.api.nvim_create_namespace("zk_backlinks")

-- Store backlink data for navigation
local backlink_data = {}

-- Buffer utilities
local function get_current_buffer_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.fn.expand("%:p")
  return bufnr, file_path
end

local function get_zk_file_path(relative_path)
  return zk_dir and (zk_dir .. "/" .. relative_path) or relative_path
end

local function create_backlink_virtual_lines(backlinks)
  local virt_lines = {}

  -- empty line between title and backlinks
  table.insert(virt_lines, { { "", "Normal" } })

  -- Add header
  local header_text = string.format("🔗 Backlinks (%d) - Press <Enter> or number to navigate:", #backlinks)
  table.insert(virt_lines, { { header_text, "Comment" } })

  -- Add each backlink
  for i, link in ipairs(backlinks) do
    local display_text = string.format("  %d. %s", i, link)
    table.insert(virt_lines, { { display_text, "Directory" } })
  end

  -- Add separator after backlinks
  table.insert(virt_lines, { { "", "Normal" } })

  return virt_lines
end

local function setup_navigation_keymaps(bufnr)
  -- Enter key navigation
  vim.keymap.set("n", "<CR>", function()
    if M.is_in_backlinks_area() and M.navigate_to_backlink(1) then
      return
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end, { buffer = bufnr, silent = true, desc = "Navigate to first backlink or normal enter" })

  -- Number keys 1-9 for specific backlink navigation
  for i = 1, 9 do
    vim.keymap.set("n", tostring(i), function()
      local links = backlink_data[bufnr]
      if links and links[i] and M.is_in_backlinks_area() then
        M.navigate_to_backlink(i)
      else
        vim.api.nvim_feedkeys(tostring(i), "n", false)
      end
    end, { buffer = bufnr, silent = true, desc = "Navigate to backlink " .. i .. " or insert number" })
  end
end

-- Add backlinks as virtual text at top of buffer
function M.show_backlinks()
  local bufnr, current_file = get_current_buffer_info()
  if not M.is_zk_note(bufnr) then
    return
  end

  -- Clear existing backlinks first
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  M.get_backlinks(current_file, function(backlinks)
    vim.schedule(function()
      -- Check if buffer is still valid (user might have switched)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      -- Check if this is still the current buffer
      if vim.api.nvim_get_current_buf() ~= bufnr then
        return
      end

      if #backlinks == 0 then
        return
      end

      -- Store backlink data for this buffer
      backlink_data[bufnr] = backlinks

      -- Create and display virtual lines
      local virt_lines = create_backlink_virtual_lines(backlinks)
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, 0, 0, {
        virt_lines = virt_lines,
        virt_lines_above = false,
      })
    end)
  end)
end

-- Navigate to specific backlink by index
function M.navigate_to_backlink(index)
  local bufnr = vim.api.nvim_get_current_buf()
  local links = backlink_data[bufnr]
  if not links or #links == 0 then
    return false
  end

  index = index or 1
  local selected_link = links[index]
  if selected_link then
    local full_path = get_zk_file_path(selected_link)
    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
    return true
  end

  return false
end

-- Check if cursor is near backlinks area
function M.is_in_backlinks_area()
  local cursor_line = vim.fn.line(".")
  local bufnr = vim.api.nvim_get_current_buf()

  -- Check if we have backlinks for this buffer
  local links = backlink_data[bufnr]
  if not links or #links == 0 then
    return false
  end

  -- Virtual text appears after line 1 (title), so backlinks area is:
  -- Line 1: title (navigation works here)
  -- Line 2: where virtual backlinks appear (cursor can't actually be here)
  -- We allow navigation when cursor is on the title line
  return cursor_line == 1
end

-- Clear backlinks display
function M.hide_backlinks()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  backlink_data[bufnr] = nil
end

local function zk_completion(arg_lead)
  if not zk_dir then
    return {}
  end

  -- Build the search path
  local search_path = zk_dir
  if arg_lead ~= "" then
    search_path = zk_dir .. "/" .. arg_lead
  end

  -- Get completions
  local completions = {}
  local glob_pattern = search_path .. "*"
  local matches = vim.fn.glob(glob_pattern, false, true)

  for _, match in ipairs(matches) do
    -- Remove zk_dir prefix to get relative path
    local relative = match:sub(#zk_dir + 2) -- +2 to remove the trailing slash

    -- Add trailing slash for directories
    if vim.fn.isdirectory(match) == 1 then
      relative = relative .. "/"
    end

    table.insert(completions, relative)
  end

  return completions
end

-- Create new zk note with title prompt and smart path parsing
function M.new_note()
  -- Make completion function globally accessible with namespace
  _G.zk = _G.zk or {}
  _G.zk.completion = zk_completion

  local input = vim.fn.input({
    prompt = "Note title (with optional path): ",
    completion = "customlist,v:lua.zk.completion",
    default = "",
  })
  if input == "" then
    print("Note creation cancelled")
    return
  end

  local dir = nil
  local title = input

  -- Check if input contains a path separator
  local last_slash = input:match("^.*/()")
  if last_slash then
    dir = input:sub(1, last_slash - 2) -- Remove the trailing slash
    title = input:sub(last_slash)
  end

  -- Build zk command
  local cmd = "zk new"
  if dir then
    cmd = cmd .. " " .. vim.fn.shellescape(dir)
  end
  cmd = cmd .. " -t " .. vim.fn.shellescape(title) .. " -p"

  -- Execute command and capture output (file path)
  local result = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    local file_path = vim.trim(result)
    if file_path ~= "" then
      -- Open the newly created file
      vim.cmd("edit " .. vim.fn.fnameescape(file_path))
      print("Created note: " .. title .. (dir and " in " .. dir or ""))
    end
  else
    print("Error creating note: " .. result)
  end
end

-- Setup autocommands for automatic backlink display
function M.setup_auto_backlinks()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Create buffer-local autocmds
  local group = vim.api.nvim_create_augroup("ZKBacklinks_" .. bufnr, { clear = true })

  -- Refresh backlinks on buffer enter (not on save, since global handler does that)
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    buffer = bufnr,
    callback = function()
      if M.is_zk_note(bufnr) then
        M.show_backlinks()
      end
    end,
  })

  -- Hide backlinks when leaving buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    buffer = bufnr,
    callback = M.hide_backlinks,
  })

  -- Setup buffer-local keymaps
  setup_navigation_keymaps(bufnr)
end

return M
