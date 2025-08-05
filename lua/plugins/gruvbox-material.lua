return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_enable_bold = 1
    -- vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_enable_italic = false
    vim.g.gruvbox_material_disable_italic_comment = true
    vim.g.netrw_special_syntax = true
  end,
}
