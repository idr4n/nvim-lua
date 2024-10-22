require("noirbuddy").setup({
  colors = {
    -- background = "#000000",
    primary = "#99AABB",
    diagnostic_error = "#bf616a",
    diagnostic_warning = "#b48ead",
    diagnostic_info = "#77aacc",
    diagnostic_hint = "#77aacc",
    diff_add = "#a3be8c",
    diff_change = "#56698a",
    diff_delete = "#ffaaaa",
  },
  styles = {
    italic = false,
    bold = false,
    underline = true,
    undercurl = true,
  },
  preset = "slate",
})

if vim.g.colors_name == "noirbuddy" then
  local colorbuddy = require("colorbuddy")

  local colors = colorbuddy.colors
  local Group = colorbuddy.Group
  local groups = colorbuddy.groups
  local styles = colorbuddy.styles

  Group.new("StatusLine", colors.noir_4, colors.none, nil)
  Group.new("StatusLineNC", colors.noir_7, colors.none)

  -- force transparent bg
  -- Group.new("Normal", colors.noir_4, colors.none, nil)
  -- Group.link("MsgArea", groups.Normal)
  -- Group.link("Gutter", groups.Normal)
  -- Group.new("LineNr", colors.noir_7, colors.none, nil)
  -- Group.link("SignColumn", groups.LineNr)
  -- Group.new("VertSplit", colors.noir_9, colors.none, nil)
  -- Group.new("BufferLineSeparator", colors.background, colors.noir_9, nil)

  -- other overrides
  Group.new("CurSearch", colors.noir_9, colors.primary)

  Group.new("identifier", colors.noir_3, nil, nil)

  Group.new("function", colors.noir_2, nil)
  Group.link("@function", groups["function"])
  Group.link("String", groups["@string"])
  Group.link("@lsp.type.function", groups["function"])

  -- Italic comments
  -- Group.new("comment", colors.noir_6, nil, styles.italic)
  -- Group.link("@comment", groups.comment)

  Group.new("keyword.return", colors.noir_4, nil, styles.bold)
  Group.link("@keyword.return", groups["keyword.return"])
  Group.link("type.qualifier", groups["keyword.return"])
  Group.link("@type.qualifier", groups["keyword.return"])

  Group.new("IblScope", colors.noir_8, colors.none)
  Group.new("IblIndent", colors.noir_9, colors.none)
  Group.new("NormalFloat", colors.noir_1, colors.none, nil)
  Group.new("NonText", colors.noir_9, nil, nil)
  -- Group.new("LineNr", colors.noir_7, colors.none, nil)
  Group.new("CursorLineNr", colors.noir_6, colors.none, nil)
  Group.new("WinSeparator", colors.noir_8, colors.none, nil)
  Group.new("NotifyBackground", colors.noir_4, colors.background, nil)
  Group.new("illuminatedWord", nil, colors.noir_9, nil)
  Group.new("illuminatedCurWord", nil, colors.noir_9, nil)
  Group.new("IlluminatedWordText", nil, colors.noir_9, nil)
  Group.new("IlluminatedWordRead", nil, colors.noir_9, nil)
  Group.new("IlluminatedWordWrite", nil, colors.noir_9, nil)
  Group.new("LspInlayHint", colors.noir_6, colors.noir_9, nil)
  Group.new("RenderMarkdownCode", nil, colors.noir_9, nil)

  -- swap undercurls and underlines
  for _, v in ipairs({ "Error", "Info", "Hint", "Warn" }) do
    local col_name = "diagnostic_" .. string.lower(v)
    if v == "Warn" then
      col_name = "diagnostic_warning"
    end

    Group.new("Diagnostic" .. v, colors[col_name], nil, styles.underline)
    Group.new("DiagnosticUnderline" .. v, colors[col_name], nil, styles.undercurl)
  end

  Group.new("DiagnosticWarn", colors.diagnostic_warning, nil, styles.none)
  Group.new("DiagnosticError", colors.diagnostic_error, nil, styles.none)
  Group.new("DiagnosticInfo", colors.diagnostic_info, nil, styles.none)
  Group.new("DiagnosticHint", colors.diagnostic_hint, nil, styles.none)
end
