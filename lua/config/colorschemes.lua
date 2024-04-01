local M = {}

M.darkplus = {
  setup = function()
    vim.cmd("colorscheme darkplus")
    if vim.g.colors_name == "darkplus" then
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#323539" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#41454D" })
    end
  end,
}

M.NvimDefault = {
  setup = function()
  -- stylua: ignore
  if vim.g.colors_name == "default" or vim.g.colors_name == nil then
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    -- local diff_changed = vim.api.nvim_get_hl(0, { name = "DiffChange" })
    -- vim.api.nvim_set_hl(0, "NeoTreeNormal", vim.tbl_extend("force", normal_hl, { bg = "#181B20" }))
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "DiffAdded", { fg = "#627259" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = "#3B4261" })
    -- vim.api.nvim_set_hl(0, "DiffAdded", { fg = "#005523" })
    -- vim.api.nvim_set_hl(0, "DiffChange", { fg = "#4F5258" })
    vim.api.nvim_set_hl(0, "DiffRemoved", { fg = "#B55A67" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#111420" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#111420" })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#4F5258" })
    -- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { default = true })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = normal_hl.bg })
    -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4F5258" })
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#323539" })
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#51555B" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212226" })
    vim.api.nvim_set_hl(0, "StatusLine", vim.tbl_extend("force", normal_hl, { bg = "#000000" }))
    vim.api.nvim_set_hl( 0, "Comment", vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = "Comment" }), { italic = true }))
  end
  end,
}

M.rosepine = {
  setup = function(background)
    vim.o.background = background or "light"
    vim.cmd("colorscheme rose-pine")
  end,
}

M.wind = {
  setup = function()
    vim.cmd("colorscheme wind")
    if vim.g.colors_name == "wind" then
      -- local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      local float_hl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#002E40" })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "#00354A" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#536B76" })
      vim.api.nvim_set_hl(0, "WhichKeyFloat", { fg = float_hl.fg, bg = float_hl.bg })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#12ADE0" })
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#00445E" })
    end
  end,
}

return M
