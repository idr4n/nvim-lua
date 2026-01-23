local get_hl_hex = require("utils").get_hl_hex

-- Autocommands
local aucmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("idr4n/" .. name, { clear = true })
end

-- Autospelling and zen mode for tex and md files
aucmd("BufRead", {
  pattern = { "*.tex", "*.typ", "*.qmd" },
  callback = function()
    vim.cmd("setlocal spell spelllang=en_us")
    -- vim.cmd("ZenMode")
  end,
  group = augroup("tex-md_group"),
})

-- Indent four spaces
aucmd("FileType", {
  pattern = {
    -- "sql",
    "markdown",
    "quarto",
  },
  command = "setlocal shiftwidth=4 tabstop=4",
  group = augroup("indent_4"),
})

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

-- format on save for specific files (set in conform config instead)
-- aucmd("BufWritePre", {
--   pattern = { "*.go", "*.lua", "*.rs" },
--   callback = function()
--     -- vim.lsp.buf.format()
--     require("conform").format({ lsp_fallback = true })
--   end,
--   group = augroup("LspFormatting"),
-- })

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

--: Netwr mappings {{{
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("NetwrMappings"),
--   pattern = "netrw",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { silent = true })
--   end,
-- })
--: }}}

-- netrw-preview open if directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("netrw-preview").reveal()
      end
    end
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

-- Reset cursor shape on exit (needed in Fish within Tmux somehow)
aucmd("VimLeave", {
  group = augroup("CursorShape"),
  pattern = "*",
  callback = function()
    vim.cmd("set guicursor=a:ver100")
  end,
})

-- Setup ZK backlinks for markdown files
aucmd("FileType", {
  group = augroup("ZK_Setup"),
  pattern = "markdown",
  callback = function()
    local zk = require("zk")
    if zk.is_zk_note() then
      zk.setup_auto_backlinks()
    end
  end,
})

-- Auto-save session on exit
aucmd("VimLeavePre", {
  group = augroup("SessionManagement"),
  callback = function()
    if vim.fn.argc() == 0 then -- Only if no file arguments were passed
      -- Helper function to check if buffer should be included in session
      local function is_valid_session_buffer(buf)
        if not vim.api.nvim_buf_is_loaded(buf) or not vim.bo[buf].buflisted then
          return false
        end

        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buftype = vim.bo[buf].buftype
        local modifiable = vim.bo[buf].modifiable
        local readonly = vim.bo[buf].readonly
        local filetype = vim.bo[buf].filetype

        -- Exclude special buffer types and non-modifiable/readonly buffers
        if buftype ~= "" then
          return false
        end
        if not modifiable or readonly then
          return false
        end

        -- Exclude specific filetypes that shouldn't be in sessions
        if filetype == "netrw" or filetype == "help" or filetype == "qf" then
          return false
        end

        -- Exclude startup buffer and other named special buffers
        if buf_name == "" or buf_name:match("%[.*%]$") then
          return false
        end

        return true
      end

      -- Get all valid file buffers
      local valid_buffers = vim.tbl_filter(is_valid_session_buffer, vim.api.nvim_list_bufs())

      if #valid_buffers > 0 then
        local cwd = vim.fn.getcwd()

        -- Close buffers that are not part of the current working directory
        for _, buf in ipairs(valid_buffers) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          local buf_dir = vim.fn.fnamemodify(buf_name, ":h")
          if not buf_dir:match("^" .. vim.pesc(cwd)) then
            pcall(vim.api.nvim_buf_delete, buf, { force = false })
          end
        end

        -- Check if there are still valid buffers after CWD filtering
        local remaining_buffers = vim.tbl_filter(is_valid_session_buffer, vim.api.nvim_list_bufs())
        if #remaining_buffers > 0 then
          require("sessions").save_session(nil, false)
        end
      end
    end
  end,
})

-- Convert JSON filetype to JSON with comments (jsonc)
vim.cmd([[
  augroup jsonFtdetect
  autocmd!
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup END
]])

-- After loading zenbones, wind, etc. colorschemes
aucmd("ColorScheme", {
  group = augroup("ColorsCustomization"),
  pattern = { "zenbones", "wind", "seoul256", "gruvbox-material", "gruvbox", "gruvbox-dark-hard" },
  callback = function()
    local ut = require("utils")
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    local line_nr = ut.lighten(string.format("#%06x", normal.bg), 0.8)
    -- local winsep = ut.lighten(string.format("#%06x", normal.bg), 0.7)
    local treeindent = ut.lighten(string.format("#%06x", normal.bg), 0.85)
    local lighter_bg = ut.lighten(string.format("#%06x", normal.bg), 0.95)
    local darker_bg = ut.darken(string.format("#%06x", normal.bg), 0.95, "#000000")
    vim.api.nvim_set_hl(0, "FileExplorerHl", { fg = normal.fg, bg = darker_bg })
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = normal.bg })

    if vim.g.colors_name == "seoul256" then
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#999872", bg = normal.bg })
      vim.api.nvim_set_hl(0, "NvimTreeLineNr", { bg = darker_bg })
    end

    if vim.g.colors_name ~= "seoul256" then
      vim.api.nvim_set_hl(0, "LineNr", { fg = line_nr })
    end

    if vim.g.colors_name == "zenbones" then
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopUp", { bg = "#2E2927" })
    end

    if vim.g.colors_name == "gruvbox" then
      local gruvbox_bg0 = get_hl_hex("GruvboxBg0").fg
      local gruvbox_red = get_hl_hex("GruvboxRed").fg
      local gruvbox_aqua = get_hl_hex("GruvboxAqua").fg
      local gruvbox_yellow = get_hl_hex("GruvboxYellow").fg
      local gruvbox_blue = get_hl_hex("GruvboxBlue").fg
      local gruvbox_purple = get_hl_hex("GruvboxPurple").fg
      local illuminate = { bg = get_hl_hex("GruvboxBg1").fg }

      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = gruvbox_purple, bg = gruvbox_bg0 })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = get_hl_hex("GruvboxFg2").fg, bg = gruvbox_bg0 })
      vim.api.nvim_set_hl(0, "Substitute", { bg = get_hl_hex("GruvboxRed").fg })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NonText", { link = "GruvboxBg1" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#e26a75" })
      vim.api.nvim_set_hl(0, "CurSearch", { fg = gruvbox_bg0, bg = gruvbox_red })
      vim.api.nvim_set_hl(0, "@variable", { link = "GruvboxFg1" })
      vim.api.nvim_set_hl(0, "@variable.member", { link = "GruvboxFg1" })
      vim.api.nvim_set_hl(0, "@variable.parameter", { link = "GruvboxBlue" })
      vim.api.nvim_set_hl(0, "@constant.builtin", { link = "GruvboxPurple" })
      vim.api.nvim_set_hl(0, "@function", { link = "GruvboxAqua" })
      vim.api.nvim_set_hl(0, "@function.call", { link = "GruvboxAqua" })
      vim.api.nvim_set_hl(0, "@function.method.call", { link = "GruvboxAqua" })
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "GruvboxPurple" })
      vim.api.nvim_set_hl(0, "@constructor", { link = "GruvboxYellow" })
      vim.api.nvim_set_hl(0, "@operator", { link = "GruvboxAqua" })
      vim.api.nvim_set_hl(0, "Delimiter", { link = "GruvboxFg4" })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = gruvbox_purple, underline = true })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "GruvboxGray" })
      vim.api.nvim_set_hl(0, "VBufferListBorder", { link = "GruvboxGray" })
      -- vim.api.nvim_set_hl(0, "VBufferListBackground", { bg = "#000000" })
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "GruvboxGray" })
      vim.api.nvim_set_hl(0, "SnacksPickerMatch", { link = "GruvboxPurple" })
      vim.api.nvim_set_hl(0, "SnacksPickerDir", { link = "GruvboxGray" })
      vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "MiniTablineHidden", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = get_hl_hex("GruvboxFg1").fg, bg = gruvbox_bg0 })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = gruvbox_red, bg = gruvbox_bg0 })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = gruvbox_red, bg = "#282828" })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { fg = gruvbox_red, bg = "#282828" })
      vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = gruvbox_purple, bg = "#282828" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", illuminate)
      vim.api.nvim_set_hl(0, "IlluminatedWordText", illuminate)
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", illuminate)
      vim.api.nvim_set_hl(0, "illuminatedCurWord", illuminate)
      vim.api.nvim_set_hl(0, "illuminatedWord", illuminate)
      vim.api.nvim_set_hl(0, "NvimInternalError", { link = "GruvboxRed" })
      vim.api.nvim_set_hl(0, "ErrorMsg", { link = "GruvboxRed" })
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = gruvbox_red })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = gruvbox_yellow })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = gruvbox_blue })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = gruvbox_aqua })
      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "GruvboxPurple" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = gruvbox_red })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = get_hl_hex("GruvboxYellow").fg })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = get_hl_hex("GruvboxBlue").fg })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = gruvbox_aqua })
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = get_hl_hex("GruvboxGreen").fg })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = gruvbox_aqua })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = gruvbox_red })
      vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "#282828" })
    end

    if vim.g.colors_name == "gruvbox-dark-hard" then
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#b8bb26", bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#83a598", bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#fb4934", bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterAdd", { fg = "#b8bb26", bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterChange", { fg = "#83a598", bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterDelete", { fg = "#fb4934", bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#b8bb26", bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#83a598", bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = "#fb4934", bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#bdae93", bg = "NONE" })
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "illuminatedCurWord", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "illuminatedWord", { bg = "#3c3836" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3c3836" })
    end

    if vim.g.colors_name == "gruvbox-material" then
      local config = vim.fn["gruvbox_material#get_configuration"]()
      local palette =
        vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
      local set_hl = vim.fn["gruvbox_material#highlight"]

      set_hl("FloatBorder", { "#e26a75", "NONE" }, palette.bg0)
      set_hl("FloatTitle", palette.none, palette.bg0)
      set_hl("NormalFloat", palette.none, { darker_bg, "NONE" })
      set_hl("NonText", palette.bg3, palette.none)
      set_hl("IblIndent", palette.bg3, palette.none)
      -- set_hl("StatusLine", palette.none, palette.bg_dim)
      set_hl("MiniFilesTitleFocused", palette.none, palette.bg0)
      set_hl("WhichKeyNormal", palette.none, palette.bg3)
      set_hl("NoiceCmdlinePopUp", palette.none, palette.bg1)
      set_hl("GitSignsAdd", palette.green, palette.none)
      set_hl("GitSignsChange", palette.blue, palette.none)
      set_hl("GitSignsDelete", palette.red, palette.none)
      set_hl("TreesitterContext", palette.none, palette.bg0)
      -- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = palette.red[1] })
      -- set_hl("TreesitterContextBottom", palette.none, palette.none, "underline", palette.red)
      set_hl("TreesitterContextBottom", palette.none, palette.none, "underline", { "#e26a75" })
      set_hl("MiniTablineCurrent", palette.none, palette.bg0)
      set_hl("MiniTablineHidden", palette.grey0, palette.bg1)
      set_hl("MiniTablineVisible", palette.purple, palette.bg1)
      set_hl("MiniTablineModifiedCurrent", palette.yellow, palette.bg_visual_red)
      set_hl("MiniTablineModifiedHidden", palette.grey0, palette.bg_visual_red)
      set_hl("MiniTablineModifiedVisible", palette.purple, palette.bg_visual_red)
      set_hl("RenderMarkdownCode", palette.none, palette.bg_dim)
      set_hl("BufferLineIndicatorSelected", palette.bg0, palette.bg0)
      set_hl("insertcursor", palette.fg0, { "#F34B00", "NONE" })
      set_hl("WinSeparator", { "#e26a75", "NONE" }, palette.bg0)
      set_hl("NvimTreeCursorLine", palette.none, { lighter_bg, "NONE" })
    end

    -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = winsep })
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = treeindent })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = normal.bg })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = darker_bg })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = normal.bg })
    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = lighter_bg })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#FF87D7" })
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#FF87D7" })
  end,
})

-- - Base16 colors.
-- local gui00 = "#1d2021"
-- local gui01 = "#3c3836"
-- local gui02 = "#504945"
-- local gui03 = "#665c54"
-- local gui04 = "#bdae93"
-- local gui05 = "#d5c4a1"
-- local gui06 = "#ebdbb2"
-- local gui07 = "#fbf1c7"
-- local gui08 = "#fb4934"
-- local gui09 = "#fe8019"
-- local gui0A = "#fabd2f"
-- local gui0B = "#b8bb26"
-- local gui0C = "#8ec07c"
-- local gui0D = "#83a598"
-- local gui0E = "#d3869b"
-- local gui0F = "#d65d0e"
--
-- -- Base24 colors.
-- local gui10 = "#1d2021"
-- local gui11 = "#1d2021"
-- local gui12 = "#fb4934"
-- local gui13 = "#fabd2f"
-- local gui14 = "#b8bb26"
-- local gui15 = "#8ec07c"
-- local gui16 = "#83a598"
-- local gui17 = "#d3869b"
