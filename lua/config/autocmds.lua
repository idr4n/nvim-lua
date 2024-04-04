-- Autocommands
local aucmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("idr4n/" .. name, { clear = true })
end

-- Autospelling and zen mode for tex and md files
aucmd("BufRead", {
  pattern = { "*.tex", "*.md", "*.typ", "*.qmd" },
  callback = function()
    vim.cmd("setlocal spell spelllang=en_us")
    -- vim.cmd("ZenMode")
  end,
  group = augroup("tex-md_group"),
})

-- Indent four spaces
-- aucmd("FileType", {
--   pattern = {
--     "sql",
--     "go",
--     "markdown",
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact",
--   },
--   command = "setlocal shiftwidth=4 tabstop=4",
--   group = augroup("indent_4"),
-- })

-- SQL
aucmd("FileType", {
  pattern = { "sql" },
  command = "set nowrap",
  group = augroup("no_wrap"),
})

-- Golang
aucmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tmpl", "*.gohtml" },
  command = "set filetype=html",
  group = augroup("golang"),
})

-- Typst
aucmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  command = "set filetype=typst",
  group = augroup("typst"),
})

-- SQL
aucmd("FileType", {
  pattern = { "sql" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", ",e", ":SqlsExecuteQuery<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "v", ",e", ":SqlsExecuteQuery<cr>", { noremap = true, silent = true })
  end,
  group = augroup("sql"),
})

-- Fix conceallevel for json files
aucmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Netrw
aucmd("FileType", {
  pattern = { "netrw" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "h", "-", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { silent = true })
  end,
  group = augroup("Netrw"),
})

-- format on save for specific files
aucmd("BufWritePre", {
  pattern = { "*.go", "*.lua" },
  callback = function()
    vim.lsp.buf.format()
  end,
  group = augroup("LspFormatting"),
})

-- -- Alpha
-- aucmd("FileType", {
--     pattern = { "alpha" },
--     command = "nnoremap <silent> <buffer> - :bwipe <Bar> Dirvish<CR>",
--     group = augroup("alpha"),
-- })

-- go to last loc when opening a buffer
aucmd("BufReadPost", {
  group = augroup("LastLocation"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
aucmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Redraw statusline on different events
aucmd("DiagnosticChanged", {
  group = augroup("Status_Diagnostics"),
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
    vim.cmd("redrawtabline")
  end),
})
aucmd("User", {
  group = augroup("Status_GitUpdate"),
  pattern = "GitSignsUpdate",
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
  end),
})

-- Wrap text for some markdown files and others
aucmd("FileType", {
  group = augroup("md-tex-aucmd"),
  pattern = { "markdown", "tex", "typst" },
  callback = function()
    vim.cmd("setlocal wrap")
  end,
})

-- Quickfix with trouble
aucmd("BufWinEnter", {
  group = augroup("quickfix"),
  pattern = "quickfix",
  callback = function()
    local ok, trouble = pcall(require, "trouble")
    if ok then
      vim.defer_fn(function()
        vim.cmd("cclose")
        trouble.open("quickfix")
      end, 0)
    end
  end,
})
