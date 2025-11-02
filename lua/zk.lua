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

function M.get_forwardlinks(path, callback)
  -- First, read the file to identify valid wiki-links and exclude anchor links
  local file_content = vim.fn.readfile(path)
  local valid_links = {}

  -- Find all wiki-links [[note]]
  for _, line in ipairs(file_content) do
    for link in line:gmatch("%[%[([^%]]+)%]%]") do
      valid_links[link] = true
    end
  end

  vim.system({ "zk", "list", "-q", "-f", "json", "-L", path }, {}, function(result)
    local paths = {}

    if result.code == 0 and result.stdout and result.stdout ~= "" then
      local ok, json_data = pcall(vim.json.decode, result.stdout)
      if ok and json_data and type(json_data) == "table" then
        for _, note in ipairs(json_data) do
          if note and note.path then
            -- Extract the note ID from the path (e.g., "qelc-enia-variable-mappings" from "qelc-enia-variable-mappings.md")
            local note_id = note.path:match("([^/]+)%.md$") or note.path
            note_id = note_id:gsub("%.md$", "")

            -- Only include this note if it's referenced via a wiki-link
            -- This excludes false matches from anchor links
            if valid_links[note_id] or valid_links[note.path] then
              table.insert(paths, note.path)
            end
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

-- Store link data for navigation
-- Structure: { [bufnr] = { backlinks = {...}, forwardlinks = {...} } }
local link_data = {}

-- Buffer utilities
local function get_current_buffer_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.fn.expand("%:p")
  return bufnr, file_path
end

local function get_zk_file_path(relative_path)
  return zk_dir and (zk_dir .. "/" .. relative_path) or relative_path
end

local function create_link_virtual_lines(backlinks, forwardlinks)
  local virt_lines = {}

  -- empty line between title and links
  table.insert(virt_lines, { { "", "Normal" } })

  -- Add backlinks section if any exist
  if #backlinks > 0 then
    local header_text = string.format("🔗 Backlinks (%d) - Press <Enter> or number to navigate:", #backlinks)
    table.insert(virt_lines, { { header_text, "Comment" } })

    -- Add each backlink
    for i, link in ipairs(backlinks) do
      local display_text = string.format("  %d. %s", i, link)
      table.insert(virt_lines, { { display_text, "Directory" } })
    end

    -- Add separator after backlinks
    table.insert(virt_lines, { { "", "Normal" } })
  end

  -- Add forward links section if any exist
  if #forwardlinks > 0 then
    local header_text = string.format("→ Forward Links (%d) - Press <Enter> or number to navigate:", #forwardlinks)
    table.insert(virt_lines, { { header_text, "Special" } })

    -- Add each forward link
    for i, link in ipairs(forwardlinks) do
      local display_text = string.format("  %d. %s", i, link)
      table.insert(virt_lines, { { display_text, "String" } })
    end

    -- Add separator after forward links
    table.insert(virt_lines, { { "", "Normal" } })
  end

  return virt_lines
end

local function setup_navigation_keymaps(bufnr)
  -- Enter key navigation - navigates to first link of active section
  vim.keymap.set("n", "<CR>", function()
    local section = M.get_active_link_section()
    if section == "backlinks" then
      if M.navigate_to_backlink(1) then
        return
      end
    elseif section == "forwardlinks" then
      if M.navigate_to_forwardlink(1) then
        return
      end
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end, { buffer = bufnr, silent = true, desc = "Navigate to first link or normal enter" })

  -- Number keys 1-9 for navigation (section depends on cursor position)
  for i = 1, 9 do
    vim.keymap.set("n", tostring(i), function()
      local section = M.get_active_link_section()
      local links = link_data[bufnr]

      if section == "backlinks" and links and links.backlinks and links.backlinks[i] then
        M.navigate_to_backlink(i)
      elseif section == "forwardlinks" and links and links.forwardlinks and links.forwardlinks[i] then
        M.navigate_to_forwardlink(i)
      else
        vim.api.nvim_feedkeys(tostring(i), "n", false)
      end
    end, { buffer = bufnr, silent = true, desc = "Navigate to link " .. i .. " or insert number" })
  end
end

-- Add links as virtual text at top of buffer
function M.show_backlinks()
  local bufnr, current_file = get_current_buffer_info()
  if not M.is_zk_note(bufnr) then
    return
  end

  -- Clear existing links first
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  -- We need to fetch both backlinks and forwardlinks
  local backlinks_done = false
  local forwardlinks_done = false
  local backlinks_result = {}
  local forwardlinks_result = {}

  local function maybe_display()
    if not backlinks_done or not forwardlinks_done then
      return
    end

    vim.schedule(function()
      -- Check if buffer is still valid (user might have switched)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      -- Check if this is still the current buffer
      if vim.api.nvim_get_current_buf() ~= bufnr then
        return
      end

      -- Only display if we have at least one type of link
      if #backlinks_result == 0 and #forwardlinks_result == 0 then
        return
      end

      -- Store link data for this buffer
      link_data[bufnr] = {
        backlinks = backlinks_result,
        forwardlinks = forwardlinks_result,
      }

      -- Create and display virtual lines
      local virt_lines = create_link_virtual_lines(backlinks_result, forwardlinks_result)
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, 0, 0, {
        virt_lines = virt_lines,
        virt_lines_above = false,
      })
    end)
  end

  M.get_backlinks(current_file, function(backlinks)
    backlinks_result = backlinks
    backlinks_done = true
    maybe_display()
  end)

  M.get_forwardlinks(current_file, function(forwardlinks)
    forwardlinks_result = forwardlinks
    forwardlinks_done = true
    maybe_display()
  end)
end

-- Navigate to specific backlink by index
function M.navigate_to_backlink(index)
  local bufnr = vim.api.nvim_get_current_buf()
  local links = link_data[bufnr]
  if not links or not links.backlinks or #links.backlinks == 0 then
    return false
  end

  index = index or 1
  local selected_link = links.backlinks[index]
  if selected_link then
    local full_path = get_zk_file_path(selected_link)
    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
    return true
  end

  return false
end

-- Navigate to specific forward link by index
function M.navigate_to_forwardlink(index)
  local bufnr = vim.api.nvim_get_current_buf()
  local links = link_data[bufnr]
  if not links or not links.forwardlinks or #links.forwardlinks == 0 then
    return false
  end

  index = index or 1
  local selected_link = links.forwardlinks[index]
  if selected_link then
    local full_path = get_zk_file_path(selected_link)
    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
    return true
  end

  return false
end

-- Check which link section the cursor is in
-- Returns: "backlinks", "forwardlinks", or nil
function M.get_active_link_section()
  local cursor_line = vim.fn.line(".")
  local bufnr = vim.api.nvim_get_current_buf()

  -- Check if we have any links for this buffer
  local links = link_data[bufnr]
  if not links then
    return nil
  end

  local has_backlinks = links.backlinks and #links.backlinks > 0
  local has_forwardlinks = links.forwardlinks and #links.forwardlinks > 0

  if not has_backlinks and not has_forwardlinks then
    return nil
  end

  -- Line 1: Backlinks navigation zone
  if cursor_line == 1 then
    return has_backlinks and "backlinks" or (has_forwardlinks and "forwardlinks" or nil)
  end

  -- Lines 2-4: Forward links navigation zone
  if cursor_line >= 2 and cursor_line <= 4 then
    return has_forwardlinks and "forwardlinks" or nil
  end

  return nil
end

-- Check if cursor is in any link area (for backward compatibility)
function M.is_in_links_area()
  return M.get_active_link_section() ~= nil
end

-- Clear links display
function M.hide_backlinks()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  link_data[bufnr] = nil
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
