local M = {}

-- Helper function to format path for display
local function format_path_for_title(filepath, max_length)
  max_length = max_length or 50
  local cwd = vim.fn.getcwd()
  local full_path = vim.fn.fnamemodify(filepath, ":p")

  local display_path
  if vim.startswith(full_path, cwd) then
    display_path = vim.fn.fnamemodify(full_path, ":.")
  else
    display_path = vim.fn.fnamemodify(full_path, ":~")
  end

  if #display_path > max_length then
    display_path = vim.fn.pathshorten(display_path)
  end

  return display_path
end

-- Calculate dynamic z-index for proper stacking
local function calculate_zindex()
  local base_zindex = 1000
  local current_zindex = base_zindex

  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win_id) then
      local win_config = vim.api.nvim_win_get_config(win_id)
      if win_config.relative ~= "" and win_config.zindex and win_config.zindex >= current_zindex then
        current_zindex = win_config.zindex + 10
      end
    end
  end

  return current_zindex
end

-- Create and configure popup window
local function create_popup_window(bufnr, title, custom_opts)
  custom_opts = custom_opts or {}

  local default_opts = {
    style = "minimal",
    relative = "cursor",
    width = 80,
    height = 15,
    row = 1,
    col = 0,
    border = "rounded",
    title = title,
    title_pos = "center",
    zindex = calculate_zindex(),
  }

  -- Merge custom options with defaults
  local opts = vim.tbl_deep_extend("force", default_opts, custom_opts)

  local win = vim.api.nvim_open_win(bufnr, false, opts)
  vim.api.nvim_set_option_value("scrolloff", 0, { win = win })
  vim.api.nvim_set_option_value("wrap", false, { win = win })

  return win
end

-- Add highlighting to line with configurable duration
local function add_line_highlight(bufnr, line, duration, namespace_suffix)
  duration = duration or 2000
  namespace_suffix = namespace_suffix or "highlight"

  local ns_id = vim.api.nvim_create_namespace("peek_" .. namespace_suffix)
  local line_content = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1] or ""
  local line_length = #line_content

  vim.api.nvim_buf_set_extmark(bufnr, ns_id, line - 1, 0, {
    end_row = line - 1,
    end_col = line_length > 0 and line_length or 1,
    hl_group = "Visual",
    priority = 200,
  })

  -- Only set timeout if duration > 0 (permanent highlight if duration is 0 or nil)
  if duration > 0 then
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
      end
    end, duration)
  end

  return ns_id
end

-- Clear highlight namespace
local function clear_line_highlight(bufnr, namespace_suffix)
  if vim.api.nvim_buf_is_valid(bufnr) then
    local ns_id = vim.api.nvim_create_namespace("peek_" .. namespace_suffix)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  end
end

-- Create popup close function with optional cleanup
local function create_close_function(win, bufnr, ns_id, cleanup_fn)
  return function()
    if cleanup_fn then
      cleanup_fn()
    end
    if vim.api.nvim_win_is_valid(win) then
      if ns_id and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
      end
      vim.api.nvim_win_close(win, true)
    end
  end
end

-- Set up popup keymaps
local function setup_popup_keymaps(win, bufnr, original_buf, close_popup, copy_callback)
  vim.keymap.set("n", "q", close_popup, {
    buffer = bufnr,
    noremap = true,
    silent = true,
  })

  vim.keymap.set("n", "<C-w>p", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_current_win(win)
    end
  end, { buffer = original_buf, desc = "Peek - Focus popup" })

  -- Scroll keymaps for popup window
  vim.keymap.set("n", "<C-f>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_call(win, function()
        vim.cmd("normal! \5")
      end)
    end
  end, { buffer = original_buf })

  vim.keymap.set("n", "<C-b>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_call(win, function()
        vim.cmd("normal! \25")
      end)
    end
  end, { buffer = original_buf })

  -- Copy callback if provided (for diagnostics)
  if copy_callback then
    vim.keymap.set("n", "yp", copy_callback, {
      buffer = original_buf,
      noremap = true,
      silent = true,
      desc = "Copy to clipboard",
    })
  end
end

-- Set up popup autocmds
local function setup_popup_autocmds(win, original_buf, original_win, close_popup)
  local close_autocmd = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = original_buf,
    callback = function()
      local current_buf = vim.api.nvim_get_current_buf()
      local current_win = vim.api.nvim_get_current_win()

      if current_buf == original_buf and current_win == original_win then
        close_popup()
        return true
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = original_buf,
    once = true,
    callback = function()
      vim.defer_fn(function()
        local current_win = vim.api.nvim_get_current_win()
        if current_win ~= win then
          close_popup()
        end
      end, 50)
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(win),
    once = true,
    callback = function()
      if close_autocmd then
        vim.api.nvim_del_autocmd(close_autocmd)
      end
    end,
  })
end

-- Generic peek function that works with any LSP method
local function peek_lsp_result(lsp_method, title_prefix, no_result_msg)
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP client attached")
    return
  end

  local client = clients[1]
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

  vim.lsp.buf_request(0, lsp_method, params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print(no_result_msg)
      return
    end

    local location = result[1] or result
    local uri = location.uri or location.targetUri
    local range = location.range or location.targetSelectionRange or location.targetRange

    local bufnr = vim.uri_to_bufnr(uri)
    vim.fn.bufload(bufnr)

    local filepath = vim.uri_to_fname(uri)
    local formatted_path = format_path_for_title(filepath)
    local title = " " .. title_prefix .. " @" .. formatted_path .. " "

    local win = create_popup_window(bufnr, title)

    local line = range.start.line + 1
    local col = range.start.character
    vim.api.nvim_win_set_cursor(win, { line, col })

    vim.api.nvim_win_call(win, function()
      vim.fn.winrestview({ topline = line, lnum = line, col = col })
    end)

    local ns_id = add_line_highlight(bufnr, line, 2000, "definition_highlight")

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()
    local close_popup = create_close_function(win, bufnr, ns_id)
    setup_popup_keymaps(win, bufnr, original_buf, close_popup, nil)
    setup_popup_autocmds(win, original_buf, original_win, close_popup)
  end)
end

-- Create a basic popup buffer with common settings
local function create_popup_buffer(initial_lines)
  local bufnr = vim.api.nvim_create_buf(false, true)
  if initial_lines then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, initial_lines)
  end
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
  vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
  return bufnr
end

-- Create diagnostics popup buffer with formatted content
local function create_diagnostics_buffer()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    return nil, "No diagnostics found"
  end

  local bufnr = create_popup_buffer()
  local lines = {}
  local diagnostic_data = {}

  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    local line_num = diagnostic.lnum + 1
    local col_num = diagnostic.col + 1
    local message = diagnostic.message:gsub("\n", " ")

    local formatted_line = string.format("[%s] Line %d:%d - %s", severity, line_num, col_num, message)
    table.insert(lines, formatted_line)
    table.insert(diagnostic_data, diagnostic)
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
  vim.api.nvim_set_option_value("filetype", "diagnostics", { buf = bufnr })

  return bufnr, nil, diagnostic_data
end

-- Create copy callback for diagnostics
local function create_diagnostics_copy_callback(diagnostic_data)
  return function()
    if not diagnostic_data then
      print("No diagnostic data available")
      return
    end

    local all_diagnostics = {}
    for _, diagnostic in ipairs(diagnostic_data) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      local line_num = diagnostic.lnum + 1
      local col_num = diagnostic.col + 1
      local message = diagnostic.message

      table.insert(
        all_diagnostics,
        string.format("[%s] %s:%d:%d - %s", severity, vim.fn.expand("%"), line_num, col_num, message)
      )
    end

    local content = table.concat(all_diagnostics, "\n")
    vim.fn.setreg("+", content)
    print("Diagnostics copied to clipboard")
  end
end

-- Add custom selection highlighting to popup buffer
local function add_selection_highlight(bufnr, line, namespace_suffix)
  namespace_suffix = namespace_suffix or "selection_highlight"
  local ns_id = vim.api.nvim_create_namespace("peek_" .. namespace_suffix)

  -- Get line content to determine proper end_col
  local line_content = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1] or ""
  local end_col = #line_content

  vim.api.nvim_buf_set_extmark(bufnr, ns_id, line - 1, 0, {
    end_row = line - 1,
    end_col = end_col,
    hl_group = "Visual",
    priority = 100,
  })

  return ns_id
end
-- Clear selection highlighting from popup buffer
local function clear_selection_highlight(bufnr, namespace_suffix)
  if vim.api.nvim_buf_is_valid(bufnr) then
    local ns_id = vim.api.nvim_create_namespace("peek_" .. namespace_suffix)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  end
end

-- Generic navigation setup for popup items (diagnostics, symbols, etc.)
local function setup_popup_navigation(popup_win, bufnr, item_data, original_win, get_position_fn, namespace_suffix)
  namespace_suffix = namespace_suffix or "popup_highlight"
  local current_highlighted_line = nil
  local original_bufnr = vim.api.nvim_win_get_buf(original_win)

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    callback = function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line_idx = cursor[1]
      if item_data[line_idx] and vim.api.nvim_win_is_valid(original_win) then
        local item = item_data[line_idx]
        local line, col = get_position_fn(item)

        -- Only update if we're highlighting a different line
        if current_highlighted_line ~= line then
          -- Clear previous highlight
          if current_highlighted_line then
            clear_line_highlight(original_bufnr, namespace_suffix)
          end

          -- Position line with offset from top (5 lines or scrolloff)
          local scrolloff = vim.api.nvim_get_option_value("scrolloff", { win = original_win })
          local offset = math.max(5, scrolloff)
          local topline = math.max(1, line - offset)

          vim.api.nvim_win_set_cursor(original_win, { line, col })
          vim.api.nvim_win_call(original_win, function()
            vim.fn.winrestview({ topline = topline, lnum = line, col = col })
          end)

          -- Apply permanent highlight to new line
          add_line_highlight(original_bufnr, line, 0, namespace_suffix)
          current_highlighted_line = line
        end
      end
    end,
  })

  vim.keymap.set("n", "<CR>", function()
    if not item_data then
      print("No data available")
      return
    end

    local cursor = vim.api.nvim_win_get_cursor(popup_win)
    local line_idx = cursor[1]
    if item_data[line_idx] then
      local item = item_data[line_idx]
      local line, col = get_position_fn(item)
      -- Clear highlight before closing
      clear_line_highlight(original_bufnr, namespace_suffix)
      vim.api.nvim_win_close(popup_win, true)
      if vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
        vim.api.nvim_win_set_cursor(original_win, { line, col })
      end
    end
  end, { buffer = bufnr, desc = "Jump to item" })
end

-- Create symbols buffer with aligned formatting
local function create_symbols_buffer(symbols)
  local bufnr = create_popup_buffer()
  local lines = {}
  local symbol_data = {}

  -- Calculate max line number width for alignment
  local max_line_num = 0
  for _, symbol in ipairs(symbols) do
    local line_num = symbol.location.range.start.line + 1
    if line_num > max_line_num then
      max_line_num = line_num
    end
  end
  local line_width = string.len(tostring(max_line_num))

  for i, symbol in ipairs(symbols) do
    local kind_name = vim.lsp.protocol.SymbolKind[symbol.kind] or "Unknown"
    local line_num = symbol.location.range.start.line + 1

    -- Right-align line numbers for better visual alignment
    local line_text = string.format("%" .. line_width .. "d: %s %s", line_num, kind_name, symbol.name)
    if symbol.containerName then
      line_text = line_text .. " (" .. symbol.containerName .. ")"
    end

    table.insert(lines, line_text)
    -- Transform symbol to look like diagnostic for reuse
    symbol_data[i] = {
      lnum = symbol.location.range.start.line,
      col = symbol.location.range.start.character,
      message = line_text,
      original_symbol = symbol,
    }
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })

  return bufnr, nil, symbol_data
end

-- Create search input buffer
local function create_search_input_buffer()
  local bufnr = create_popup_buffer({ "" })

  -- Disable completion and other intrusive features
  vim.api.nvim_set_option_value("completefunc", "", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "", { buf = bufnr })
  vim.api.nvim_set_option_value("complete", "", { buf = bufnr })
  vim.api.nvim_set_option_value("completeopt", "", { buf = bufnr })

  --  Disable completions
  vim.api.nvim_create_autocmd("BufEnter", {
    buffer = bufnr,
    callback = function()
      vim.b.completion = false
    end,
  })

  return bufnr
end -- Filter symbols based on search query
local function filter_symbols(symbols, query)
  if not query or query == "" then
    return symbols
  end

  local filtered = {}
  local lower_query = string.lower(query)

  for _, symbol in ipairs(symbols) do
    local symbol_text = string.lower(symbol.name)
    if symbol.containerName then
      symbol_text = symbol_text .. " " .. string.lower(symbol.containerName)
    end

    if string.find(symbol_text, lower_query, 1, true) then
      table.insert(filtered, symbol)
    end
  end

  return filtered
end

-- Update symbols buffer with filtered results
local function update_symbols_buffer(bufnr, symbols, symbol_data_ref)
  local lines = {}
  local symbol_data = {}

  -- Calculate max line number width for alignment
  local max_line_num = 0
  for _, symbol in ipairs(symbols) do
    local line_num = symbol.location.range.start.line + 1
    if line_num > max_line_num then
      max_line_num = line_num
    end
  end
  local line_width = string.len(tostring(max_line_num))

  for i, symbol in ipairs(symbols) do
    local kind_name = vim.lsp.protocol.SymbolKind[symbol.kind] or "Unknown"
    local line_num = symbol.location.range.start.line + 1

    -- Right-align line numbers for better visual alignment
    local line_text = string.format("%" .. line_width .. "d: %s %s", line_num, kind_name, symbol.name)
    if symbol.containerName then
      line_text = line_text .. " (" .. symbol.containerName .. ")"
    end

    table.insert(lines, line_text)
    -- Transform symbol to look like diagnostic for reuse
    symbol_data[i] = {
      lnum = symbol.location.range.start.line,
      col = symbol.location.range.start.character,
      message = line_text,
      original_symbol = symbol,
    }
  end

  vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })

  -- Update the reference to symbol_data
  for k in pairs(symbol_data_ref) do
    symbol_data_ref[k] = nil
  end
  for k, v in pairs(symbol_data) do
    symbol_data_ref[k] = v
  end
end

-- Create bottom-right popup window (DRY for diagnostics and symbols)
local function create_bottom_right_popup(bufnr, title, original_win, width_factor, height_factor)
  width_factor = width_factor or 0.4
  height_factor = height_factor or 0.3

  local win_height = vim.api.nvim_win_get_height(original_win)
  local win_width = vim.api.nvim_win_get_width(original_win)

  local popup_width = math.min(80, math.floor(win_width * width_factor))
  local popup_height = math.min(20, math.floor(win_height * height_factor))

  return create_popup_window(bufnr, title, {
    relative = "win",
    win = original_win,
    width = popup_width,
    height = popup_height,
    row = win_height - popup_height - 2,
    col = win_width - popup_width - 1,
  })
end

-- Common popup setup with navigation (DRY for diagnostics and symbols)
local function setup_peek_popup(popup_bufnr, popup_win, original_win, item_data, namespace_suffix, copy_callback)
  local ns_id = vim.api.nvim_create_namespace("peek_" .. namespace_suffix)

  -- Create close function with highlight cleanup
  local close_with_cleanup = function()
    clear_line_highlight(vim.api.nvim_win_get_buf(original_win), namespace_suffix)
    local close_popup = create_close_function(popup_win, popup_bufnr, ns_id)
    close_popup()
  end

  -- Setup popup management
  setup_popup_keymaps(popup_win, popup_bufnr, vim.api.nvim_get_current_buf(), close_with_cleanup, copy_callback)
  setup_popup_autocmds(popup_win, vim.api.nvim_get_current_buf(), original_win, close_with_cleanup)

  -- Setup navigation with highlighting
  local get_position = function(item)
    return item.lnum + 1, item.col
  end
  setup_popup_navigation(popup_win, popup_bufnr, item_data, original_win, get_position, namespace_suffix)
end

-- Setup for multi-window popup (search + symbols)
local function setup_multi_popup_autocmds(search_win, symbols_win, original_buf, original_win, close_all_popups)
  -- Only close if we move cursor in the original buffer/window
  local close_autocmd = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = original_buf,
    callback = function()
      local current_buf = vim.api.nvim_get_current_buf()
      local current_win = vim.api.nvim_get_current_win()

      if current_buf == original_buf and current_win == original_win then
        close_all_popups()
        return true
      end
    end,
  })

  -- Close if we leave the original buffer to go somewhere else (not our popups)
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = original_buf,
    once = true,
    callback = function()
      vim.defer_fn(function()
        local current_win = vim.api.nvim_get_current_win()
        if current_win ~= search_win and current_win ~= symbols_win then
          close_all_popups()
        end
      end, 50)
    end,
  })

  -- Clean up autocmd when windows are closed
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = { tostring(search_win), tostring(symbols_win) },
    callback = function()
      if close_autocmd and vim.api.nvim_get_autocmds({ id = close_autocmd })[1] then
        pcall(vim.api.nvim_del_autocmd, close_autocmd)
      end
    end,
  })
end

function M.peek_diagnostics()
  local diagnostics_bufnr, err, diagnostic_data = create_diagnostics_buffer()
  if not diagnostics_bufnr then
    print(err)
    return
  end

  local original_win = vim.api.nvim_get_current_win()
  local current_file = vim.fn.expand("%:t")
  local title = " Diagnostics @" .. current_file .. " "

  local win = create_bottom_right_popup(diagnostics_bufnr, title, original_win, 0.7)
  local copy_callback = create_diagnostics_copy_callback(diagnostic_data)

  setup_peek_popup(diagnostics_bufnr, win, original_win, diagnostic_data, "diagnostic_highlight", copy_callback)
end

-- Create symbol kind lookup for filtering
local function create_symbol_kind_map(symbol_kinds)
  local symbol_kind_map = {}
  if type(symbol_kinds) == "string" then
    symbol_kinds = { symbol_kinds }
  end

  if #symbol_kinds > 0 then
    for _, kind_name in ipairs(symbol_kinds) do
      for kind_num, lsp_kind_name in pairs(vim.lsp.protocol.SymbolKind) do
        if lsp_kind_name == kind_name then
          symbol_kind_map[kind_num] = true
          break
        end
      end
    end
  end

  return symbol_kind_map, symbol_kinds
end

-- Flatten and filter symbols recursively
local function flatten_symbols(symbols, container_name, symbol_kind_map, symbol_kinds)
  local flattened = {}
  for _, symbol in ipairs(symbols) do
    -- Filter by kind if specified
    if #symbol_kinds == 0 or symbol_kind_map[symbol.kind] then
      local flat_symbol = {
        name = symbol.name,
        kind = symbol.kind,
        containerName = container_name,
        location = symbol.location or { range = symbol.range or symbol.selectionRange },
      }
      table.insert(flattened, flat_symbol)
    end

    -- Recursively flatten children
    if symbol.children then
      local children = flatten_symbols(symbol.children, symbol.name, symbol_kind_map, symbol_kinds)
      for _, child in ipairs(children) do
        table.insert(flattened, child)
      end
    end
  end
  return flattened
end

-- Create and setup search functionality for symbols
local function setup_symbols_search(symbols_bufnr, symbols_win, all_symbols, symbol_data, original_win)
  local current_selection = 0 -- Start with no selection
  local current_highlighted_line = nil
  local current_popup_highlight = nil
  local original_bufnr = vim.api.nvim_win_get_buf(original_win)

  -- Update preview based on current selection
  local function update_preview_selection()
    if current_selection > 0 and symbol_data[current_selection] and vim.api.nvim_win_is_valid(original_win) then
      local item = symbol_data[current_selection]
      local line, col = item.lnum + 1, item.col

      -- Clear previous highlights
      if current_highlighted_line then
        clear_line_highlight(original_bufnr, "symbol_highlight")
      end
      if current_popup_highlight then
        clear_selection_highlight(symbols_bufnr, "symbol_selection")
      end

      -- Position line with offset from top
      local scrolloff = vim.api.nvim_get_option_value("scrolloff", { win = original_win })
      local offset = math.max(5, scrolloff)
      local topline = math.max(1, line - offset)

      vim.api.nvim_win_set_cursor(original_win, { line, col })
      vim.api.nvim_win_call(original_win, function()
        vim.fn.winrestview({ topline = topline, lnum = line, col = col })
      end)

      -- Apply permanent highlight to new line
      add_line_highlight(original_bufnr, line, 0, "symbol_highlight")
      current_highlighted_line = line

      -- Add selection highlight to popup
      current_popup_highlight = add_selection_highlight(symbols_bufnr, current_selection, "symbol_selection")

      -- Update symbols window cursor
      if vim.api.nvim_win_is_valid(symbols_win) then
        vim.api.nvim_win_set_cursor(symbols_win, { current_selection, 0 })
      end
    end
  end

  -- Set up search functionality with selection tracking
  local function update_search_results(query)
    local filtered_symbols = filter_symbols(all_symbols, query)
    update_symbols_buffer(symbols_bufnr, filtered_symbols, symbol_data)

    -- Only auto-select first item if user has typed something
    if query and query ~= "" then
      current_selection = 1
      if vim.api.nvim_win_is_valid(symbols_win) then
        vim.api.nvim_win_set_cursor(symbols_win, { 1, 0 })
      end
      update_preview_selection()
    else
      -- Clear selection if query is empty
      current_selection = 0
      if current_highlighted_line then
        clear_line_highlight(original_bufnr, "symbol_highlight")
        current_highlighted_line = nil
      end
      if current_popup_highlight then
        clear_selection_highlight(symbols_bufnr, "symbol_selection")
        current_popup_highlight = nil
      end
    end
  end

  -- Navigate selection up/down
  local function navigate_selection(direction)
    local max_items = vim.tbl_count(symbol_data)
    if max_items == 0 then
      return
    end

    -- Initialize selection if not set
    if current_selection == 0 then
      current_selection = 1
    else
      if direction == "down" then
        current_selection = current_selection < max_items and current_selection + 1 or 1
      else
        current_selection = current_selection > 1 and current_selection - 1 or max_items
      end
    end

    update_preview_selection()
  end

  return {
    update_search_results = update_search_results,
    navigate_selection = navigate_selection,
    current_selection = function()
      return current_selection
    end,
    current_highlighted_line = function()
      return current_highlighted_line
    end,
    current_popup_highlight = function()
      return current_popup_highlight
    end,
    original_bufnr = original_bufnr,
  }
end

-- Setup keymaps and autocmds for symbols search
local function setup_symbols_keymaps(
  search_bufnr,
  symbols_bufnr,
  search_win,
  symbols_win,
  original_win,
  cursor_pos,
  search_state,
  symbol_data
)
  local original_bufnr = search_state.original_bufnr

  -- Create close function for both popups with proper cleanup
  local close_all_popups = function(restore_cursor)
    restore_cursor = restore_cursor == nil and true or restore_cursor -- default to true
    -- Clear all highlights
    if search_state.current_highlighted_line() then
      clear_line_highlight(original_bufnr, "symbol_highlight")
    end
    if search_state.current_popup_highlight() then
      clear_selection_highlight(symbols_bufnr, "symbol_selection")
    end
    -- Close windows
    if vim.api.nvim_win_is_valid(search_win) then
      vim.api.nvim_win_close(search_win, true)
    end
    if vim.api.nvim_win_is_valid(symbols_win) then
      vim.api.nvim_win_close(symbols_win, true)
    end
    -- Only restore cursor position if requested
    if restore_cursor then
      vim.schedule(function()
        local line, col = unpack(cursor_pos)
        pcall(vim.api.nvim_win_set_cursor, 0, { line, col + 1 })
        vim.cmd("stopinsert")
      end)
    else
      vim.schedule(function()
        vim.cmd("stopinsert")
      end)
    end
  end

  -- Set up search input keymaps and autocmds
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    buffer = search_bufnr,
    callback = function()
      local query = vim.api.nvim_buf_get_lines(search_bufnr, 0, 1, false)[1] or ""
      search_state.update_search_results(query)
    end,
  })
  -- Enhanced keymaps for search window - navigate without leaving search box
  vim.keymap.set({ "n", "i" }, "<C-j>", function()
    search_state.navigate_selection("down")
  end, { buffer = search_bufnr, desc = "Next symbol" })

  vim.keymap.set({ "n", "i" }, "<C-k>", function()
    search_state.navigate_selection("up")
  end, { buffer = search_bufnr, desc = "Previous symbol" })

  -- Enter to jump to selected symbol
  vim.keymap.set({ "n", "i" }, "<CR>", function()
    local current_selection = search_state.current_selection()
    if current_selection > 0 and symbol_data[current_selection] then
      local item = symbol_data[current_selection]
      local line, col = item.lnum + 1, item.col
      close_all_popups(false) -- Don't restore cursor position
      if vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
        vim.api.nvim_win_set_cursor(original_win, { line, col })
        vim.schedule(function()
          vim.cmd("stopinsert")
        end)
      end
    end
  end, { buffer = search_bufnr, desc = "Jump to symbol" })

  -- Vertical split to jump to selected symbol
  vim.keymap.set("i", "<c-v>", function()
    local current_selection = search_state.current_selection()
    if current_selection > 0 and symbol_data[current_selection] then
      close_all_popups()
      if vim.api.nvim_win_is_valid(original_win) then
        vim.cmd("vsplit")
        local new_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(original_win)
        vim.schedule(function()
          vim.api.nvim_set_current_win(new_win)
        end)
      end
    end
  end, { buffer = search_bufnr, desc = "Jump to symbol in vertical split" })

  -- Set up Esc keymaps for both buffers
  for _, buf in ipairs({ search_bufnr, symbols_bufnr }) do
    vim.keymap.set({ "n", "i" }, "<Esc>", close_all_popups, { buffer = buf, desc = "Close search" })
  end

  return close_all_popups
end

-- Enhanced symbols popup with search functionality
function M.peek_symbols(symbol_kinds)
  symbol_kinds = symbol_kinds or {} -- Default to all symbols

  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP client attached")
    return
  end

  local params = { textDocument = vim.lsp.util.make_text_document_params(0) }

  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("No symbols found")
      return
    end

    -- Create symbol kind lookup and flatten symbols
    local symbol_kind_map, processed_symbol_kinds = create_symbol_kind_map(symbol_kinds)
    local all_symbols = flatten_symbols(result, nil, symbol_kind_map, processed_symbol_kinds)

    if #all_symbols == 0 then
      local filter_text = #processed_symbol_kinds > 0 and table.concat(processed_symbol_kinds, "/") or "symbols"
      print("No " .. filter_text .. " found")
      return
    end

    -- Setup UI components
    local original_win = vim.api.nvim_get_current_win()
    local current_file = vim.fn.expand("%:t")
    local filter_text = #processed_symbol_kinds > 0 and table.concat(processed_symbol_kinds, "/") or "Symbols"

    -- Create search input buffer and window
    local search_bufnr = create_search_input_buffer()
    local search_title = " Search " .. filter_text .. " "

    -- Create search window with fixed height of 1 line
    local win_height = vim.api.nvim_win_get_height(original_win)
    local win_width = vim.api.nvim_win_get_width(original_win)
    local search_width = math.min(80, math.floor(win_width * 0.35))
    local search_height = 1 -- Fixed height for single line input

    local search_win = create_popup_window(search_bufnr, search_title, {
      relative = "win",
      win = original_win,
      width = search_width,
      height = search_height,
      row = win_height - search_height - 2,
      col = win_width - search_width - 1,
    })

    -- Create symbols buffer and window
    local symbols_bufnr, _, symbol_data = create_symbols_buffer(all_symbols)
    local symbols_title = " " .. filter_text .. " @" .. current_file .. " "

    local symbols_height = math.min(20, math.floor(win_height * 0.75))

    local symbols_win = create_popup_window(symbols_bufnr, symbols_title, {
      relative = "win",
      win = original_win,
      width = search_width,
      height = symbols_height,
      row = win_height - symbols_height - search_height - 4, -- Leave space for search box + borders
      col = win_width - search_width - 1,
    })
    -- Setup search functionality
    local search_state = setup_symbols_search(symbols_bufnr, symbols_win, all_symbols, symbol_data, original_win)

    local cursor = vim.api.nvim_win_get_cursor(0)
    -- Setup keymaps and autocmds
    local close_all_popups = setup_symbols_keymaps(
      search_bufnr,
      symbols_bufnr,
      search_win,
      symbols_win,
      original_win,
      cursor,
      search_state,
      symbol_data
    )

    -- Set up multi-popup autocmds (handles both windows)
    local original_buf = vim.api.nvim_get_current_buf()
    -- Save cursor position
    setup_multi_popup_autocmds(search_win, symbols_win, original_buf, original_win, close_all_popups)

    -- Focus search input initially
    vim.api.nvim_set_current_win(search_win)
    vim.cmd("startinsert!")
  end)
end

function M.peek_definition()
  peek_lsp_result("textDocument/definition", "Definition", "No definition found")
end

function M.peek_implementation()
  peek_lsp_result("textDocument/implementation", "Implementation", "No implementation found")
end

return M
