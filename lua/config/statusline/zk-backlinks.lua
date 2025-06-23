local M = {}

-- Cache frequently used vim functions as locals for performance
local api = vim.api
local fn = vim.fn
local schedule = vim.schedule
local expand = fn.expand

-- Module-level variables
local zk
local zk_installed
local notebook_dir = ""
local zklsp_initialized = false

-- Initialize cache and pending at module level
M.cache = {}
M.pending = {}

-- Helper function to eliminate redundant file path checking
local function is_in_notebook(file_path)
  return notebook_dir ~= "" and file_path:sub(1, #notebook_dir) == notebook_dir
end

-- Helper function for early validation
local function should_process_markdown()
  return zk and zk_installed and zklsp_initialized and vim.bo.filetype == "markdown"
end

function M.initialize_backlinks()
  local group = api.nvim_create_augroup("ZkBacklinkCacheRefresh", { clear = true })

  -- Clear cache after writing a markdown file
  api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.md",
    callback = function()
      local file_path = expand("<afile>:p")

      if is_in_notebook(file_path) then
        M.clear_cache()
      end
    end,
  })

  -- Initialize backlinks when entering a markdown buffer
  api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.md",
    callback = function()
      schedule(function()
        local file_path = expand("%:p")

        if is_in_notebook(file_path) and not M.pending[file_path] then
          M.pending[file_path] = true
          M.update_count_for_file(file_path)
        end
      end)
    end,
  })
end

function M.update_count_for_file(file_path)
  -- Early return with validation
  if not zk or file_path == "" then
    M.pending[file_path] = nil
    return
  end

  zk.list(nil, {
    select = { "path" },
    linkTo = { file_path },
  }, function(err, backlinks)
    M.pending[file_path] = nil
    M.cache[file_path] = err and 0 or (backlinks and #backlinks or 0)

    schedule(function()
      vim.cmd("redrawstatus")
    end)
  end)
end

function M.clear_cache(file)
  if file then
    M.cache[file] = nil
  else
    -- More efficient table clearing
    for k in pairs(M.cache) do
      M.cache[k] = nil
    end
  end
end

function M.get_count()
  -- Early return with combined validation
  if not should_process_markdown() or notebook_dir == "" then
    return ""
  end

  local current_file = expand("%:p")

  if not is_in_notebook(current_file) then
    return ""
  end

  -- Check cache first
  local cached_count = M.cache[current_file]
  if cached_count ~= nil then
    return cached_count == 0 and "" or (" %d"):format(cached_count)
  end

  -- Initiate update if not pending
  if not M.pending[current_file] then
    M.pending[current_file] = true
    M.update_count_for_file(current_file)
  end

  return "..."
end

function M.setup(zk_api)
  zk = zk_api
  zk_installed = fn.executable("zk") == 1
  notebook_dir = vim.env.ZK_NOTEBOOK_DIR or ""

  local group = api.nvim_create_augroup("ZkBacklinksLspAttach", { clear = true })
  api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client.name == "zk" and not zklsp_initialized then
        zklsp_initialized = true
        M.initialize_backlinks()
      end
    end,
  })
end

return M
