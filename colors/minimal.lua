-- Minimal colorscheme
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "minimal"

local settings = {
  comments = { italic = false },
  functions = { bold = true },
  conditional = { bold = false },
  loops = { bold = false },
  keywords = { bold = false },
}

-- Color palette
local colors = {
  bg = "#282828",
  fg = "#A89983",
  fg_hl = "#B48004",
  comment = "#7D7160",
  string = "#89B482",
  float = "#2C2E33",
  -- number = '#FB4934',
  number = "#9D7CD8",
  highlight = "#323232",
  illuminate = "#353535",
  statusline_bg = "#303030",
  statusline_fg = "#D4BE98",
  statusline_nc = "#A89983",
  grey = "#505257",
  red = "#EA6962",
  yellow = "#D8A658",
  blue = "#7CAEA3",
  purple = "#9D7CD8",
  green = "#A8B765",
  cyan = "#B3F6C0",
  magenta = "#FF87D7",
  -- Diff colors
  diff_add = "#89B482",
  diff_delete = "#CC241D", -- red for deletions
  diff_change = "#D4BE98", -- yellow for changes
}

-- Helper function to set highlights
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Basic UI
hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("StatusLine", { fg = colors.statusline_fg, bg = colors.statusline_bg })
hl("StatusLineNC", { fg = colors.statusline_nc, bg = colors.statusline_bg })

-- Define the syntax groups we want colored differently
hl("Comment", { fg = colors.comment, italic = settings.comments.italic or false })
hl("String", { fg = colors.string })
hl("Number", { fg = colors.number })

-- Reset all other syntax groups to Normal to prevent default color bleeding
hl("Keyword", { fg = colors.fg, bold = settings.keywords.bold or false })
hl("Function", { fg = colors.fg, bold = settings.functions.bold or false })
hl("Type", { fg = colors.fg })
hl("Constant", { fg = colors.fg })
hl("Boolean", { fg = colors.fg })
hl("Operator", { fg = colors.fg })
hl("Identifier", { fg = colors.fg })
hl("Special", { fg = colors.fg })
hl("PreProc", { fg = colors.fg })
hl("Statement", { fg = colors.fg })
hl("Conditional", { fg = colors.fg_hl, bold = settings.conditional.bold or false })
hl("Repeat", { fg = colors.fg_hl, bold = settings.loops.bold or false })
hl("Label", { fg = colors.fg })
hl("Exception", { fg = colors.fg })
hl("Include", { fg = colors.fg })
hl("Define", { fg = colors.fg })
hl("Macro", { fg = colors.fg })
hl("PreCondit", { fg = colors.fg })
hl("StorageClass", { fg = colors.fg })
hl("Structure", { fg = colors.fg })
hl("Typedef", { fg = colors.fg })

-- Additional standard vim syntax groups
hl("Character", { fg = colors.fg })
hl("Float", { fg = colors.number })
hl("Underlined", { fg = colors.fg })
hl("Ignore", { fg = colors.fg })
hl("Error", { fg = colors.fg })
hl("Todo", { fg = colors.fg })
hl("Added", { fg = colors.fg })
hl("Changed", { fg = colors.fg })
hl("Removed", { fg = colors.fg })
hl("SpecialChar", { fg = colors.fg })
hl("Tag", { fg = colors.fg })
hl("SpecialComment", { fg = colors.fg })
hl("Debug", { fg = colors.fg })
hl("htmlBold", { fg = colors.fg })
hl("htmlItalic", { fg = colors.fg })
hl("htmlUnderline", { fg = colors.fg })
hl("Title", { fg = colors.fg })
hl("ErrorMsg", { fg = colors.fg })
hl("WarningMsg", { fg = colors.fg })
hl("ModeMsg", { fg = colors.fg })
hl("MoreMsg", { fg = colors.fg })
hl("Question", { fg = colors.fg })
hl("Delimiter", { fg = colors.fg })

-- Treesitter highlight groups
hl("@variable", { fg = colors.fg })
hl("@keyword.conditional", { fg = colors.fg_hl, bold = settings.conditional.bold or false })
hl("@keyword.repeat", { fg = colors.fg_hl, bold = settings.loops.bold or false })
hl("@function.call", { fg = colors.fg, bold = settings.functions.bold or false })
hl("@keyword.function", { fg = colors.fg, bold = settings.functions.bold or false })

-- -- UI highlight groups
-- hl("Visual", { fg = colors.fg, bg = colors.statusline_bg })
hl("Search", { fg = colors.bg, bg = colors.green })
hl("IncSearch", { fg = colors.bg, bg = colors.red })
hl("CurSearch", { fg = colors.bg, bg = colors.red })
-- hl("CursorLine", { bg = colors.statusline_bg })
-- hl("CursorLineNr", { fg = colors.fg })
-- hl("CursorColumn", { bg = colors.statusline_bg })
-- hl("ColorColumn", { bg = colors.statusline_bg })
-- hl("Pmenu", { fg = colors.fg, bg = colors.statusline_bg })
-- hl("PmenuSel", { fg = colors.statusline_fg, bg = colors.statusline_bg })
-- hl("PmenuSbar", { bg = colors.statusline_bg })
-- hl("PmenuThumb", { bg = colors.fg })
-- hl("TabLine", { fg = colors.statusline_nc, bg = colors.statusline_bg })
-- hl("TabLineFill", { bg = colors.statusline_bg })
-- hl("TabLineSel", { fg = colors.statusline_fg, bg = colors.statusline_bg })
-- hl("SignColumn", { fg = colors.fg, bg = colors.bg })
-- hl("MatchParen", { fg = colors.fg, bg = colors.statusline_bg })
-- hl("LineNr", { fg = colors.statusline_nc })
hl("NonText", { fg = colors.highlight })
-- hl("VertSplit", { fg = colors.statusline_bg })
hl("WinSeparator", { fg = colors.statusline_bg })
hl("Folded", { fg = colors.comment, bg = colors.statusline_bg })
-- hl("FoldColumn", { fg = colors.comment, bg = colors.bg })
-- hl("SpellBad", { fg = colors.fg })
-- hl("SpellCap", { fg = colors.fg })
-- hl("SpellLocal", { fg = colors.fg })
-- hl("SpellRare", { fg = colors.fg })
-- hl("Conceal", { fg = colors.statusline_nc })
hl("Directory", { fg = colors.green })
-- hl("EndOfBuffer", { fg = colors.statusline_nc })
-- hl("Substitute", { fg = colors.fg, bg = colors.statusline_bg })
-- hl("TermCursor", { fg = colors.fg })
-- hl("TermCursorNC", { fg = colors.fg })
-- hl("WildMenu", { fg = colors.statusline_fg, bg = colors.statusline_bg })
hl("QuickFixLine", { fg = colors.magenta })
hl("NormalFloat", { link = "Pmenu" })
hl("WhiteSpace", { fg = colors.grey })

-- Diff
hl("DiffAdd", { fg = colors.diff_add, bg = "#293A2A" })
hl("DiffChange", { fg = colors.diff_change, bg = "#3A3A29" })
hl("DiffDelete", { fg = colors.diff_delete, bg = "#3A292A" })
hl("DiffText", { fg = colors.diff_change, bg = "#4A4A29" })

-- -- LSP and diagnostic groups
hl("DiagnosticError", { fg = colors.red })
hl("DiagnosticWarn", { fg = colors.yellow })
hl("DiagnosticInfo", { fg = colors.blue })
hl("DiagnosticHint", { fg = colors.green })
hl("DiagnosticOk", { fg = colors.cyan })
-- hl("DiagnosticVirtualTextError", { fg = colors.fg })
-- hl("DiagnosticVirtualTextWarn", { fg = colors.fg })
-- hl("DiagnosticVirtualTextInfo", { fg = colors.fg })
-- hl("DiagnosticVirtualTextHint", { fg = colors.fg })
-- hl("DiagnosticVirtualTextOk", { fg = colors.fg })
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.green })
hl("DiagnosticUnderlineOk", { undercurl = true, sp = colors.cyan })
-- hl("DiagnosticFloatingError", { fg = colors.fg })
-- hl("DiagnosticFloatingWarn", { fg = colors.fg })
-- hl("DiagnosticFloatingInfo", { fg = colors.fg })
-- hl("DiagnosticFloatingHint", { fg = colors.fg })
-- hl("DiagnosticFloatingOk", { fg = colors.fg })
-- hl("DiagnosticSignError", { fg = colors.fg })
-- hl("DiagnosticSignWarn", { fg = colors.fg })
-- hl("DiagnosticSignInfo", { fg = colors.fg })
-- hl("DiagnosticSignHint", { fg = colors.fg })
-- hl("DiagnosticSignOk", { fg = colors.fg })

-- Markdown
hl("@markup.heading.1.markdown", { fg = colors.magenta })
hl("@markup.heading.2.markdown", { fg = colors.blue })
hl("@markup.heading.3.markdown", { fg = colors.yellow })
hl("@markup.heading.4.markdown", { fg = colors.green })
hl("@markup.heading.5.markdown", { fg = colors.green })
hl("@markup.heading.6.markdown", { fg = colors.green })
hl("@markup.link.url.markdown_inline", { fg = colors.green })
hl("@markup.link.label.markdown_inline", { fg = colors.magenta })
hl("@markup.raw.markdown_inline", { fg = colors.magenta })

-- Plugins

-- mini.pick
hl("MiniPickNormal", { bg = colors.bg })
hl("MiniPickBorder", { bg = colors.bg })
hl("MiniPickBorder", { bg = colors.bg })
hl("MiniPickMatchRanges", { fg = colors.magenta })

-- mini.diff
hl("MiniDiffSignAdd", { fg = colors.diff_add })
hl("MiniDiffSignChange", { fg = colors.diff_change })
hl("MiniDiffSignDelete", { fg = colors.diff_delete })

-- Gitsigns
hl("GitSignsAdd", { fg = colors.diff_add })
hl("GitSignsChange", { fg = colors.diff_change })
hl("GitSignsDelete", { fg = colors.diff_delete })

-- Illuminate
hl("IlluminatedWordText", { bg = colors.illuminate })
hl("IlluminatedWordRead", { bg = colors.illuminate })
hl("IlluminatedWordWrite", { bg = colors.illuminate })

-- NvimTree
hl("NvimTreeIndentMarker", { fg = colors.highlight })
hl("NvimTreeFolderIcon", { fg = colors.purple })
hl("NvimTreeFolderArrowOpen", { fg = colors.purple })
hl("NvimTreeFolderArrowClosed", { fg = colors.purple })
hl("NvimTreeCursorLine", { bg = colors.illuminate })

-- MiniIndent
hl("MiniIndentscopeSymbol", { fg = colors.grey })

-- Snacks Picker
hl("SnacksPickerBoxTitle", { fg = colors.red, bg = colors.float })
hl("SnacksPickerPreviewTitle", { fg = colors.red, bg = colors.float })
hl("SnacksPickerListCursorLine", { bg = colors.bg_highlight })
hl("SnacksPickerSelected", { fg = colors.magenta })
hl("SnacksPickerDir", { fg = colors.comment })
hl("SnacksPickerFile", { fg = colors.fg })
hl("SnacksPickerMatch", { fg = colors.magenta })
hl("SnacksPickerTotals", { fg = colors.grey })

-- render-markdown.nvim
hl("RenderMarkdownCode", { bg = colors.illuminate })
