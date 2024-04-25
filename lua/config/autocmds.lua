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
  pattern = { "*.go", "*.lua", "*.rs" },
  callback = function()
    -- vim.lsp.buf.format()
    require("conform").format({ lsp_fallback = true })
  end,
  group = augroup("LspFormatting"),
})

-- Alpha
aucmd("FileType", {
  group = augroup("Alpha"),
  pattern = { "alpha" },
  -- command = "nnoremap <silent> <buffer> - :bwipe <Bar> Dirvish<CR>",
  callback = function()
    vim.opt_local.fillchars = { eob = " " }
  end,
})

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
  pattern = { "markdown", "tex", "typst", "quarto" },
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

-- Before saving session with Shatur/neovim-session-manager
aucmd("User", {
  pattern = "SessionSavePre",
  group = augroup("Session"),
  callback = function()
    -- remove buffers whose files are located outside of cwd
    local cwd = vim.fn.getcwd() .. "/"
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local bufpath = vim.api.nvim_buf_get_name(buf) .. "/"
      if not bufpath:match("^" .. vim.pesc(cwd)) then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end,
})

-- After loading zenbones, wind, etc. colorschemes
aucmd("ColorScheme", {
  group = augroup("ColorsCustomization"),
  pattern = { "zenbones", "wind", "seoul256" },
  callback = function()
    local ut = require("utils")
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    local line_nr = ut.lighten(string.format("#%06x", normal.bg), 0.8)
    local winsep = ut.lighten(string.format("#%06x", normal.bg), 0.7)
    local treeindent = ut.lighten(string.format("#%06x", normal.bg), 0.85)
    local darker_bg = ut.darken(string.format("#%06x", normal.bg), 0.95, "#000000")
    vim.api.nvim_set_hl(0, "FileExplorerHl", { fg = normal.fg, bg = darker_bg })

    if vim.g.colors_name == "seoul256" then
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#999872", bg = normal.bg })
      vim.api.nvim_set_hl(0, "NvimTreeLineNr", { bg = darker_bg })
    end

    if vim.g.colors_name ~= "seoul256" then
      vim.api.nvim_set_hl(0, "LineNr", { fg = line_nr })
    end

    vim.api.nvim_set_hl(0, "WinSeparator", { fg = winsep })
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = treeindent })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = normal.bg })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = normal.bg })
  end,
})
