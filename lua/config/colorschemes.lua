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

M.github = {
  setup = function()
    vim.cmd("colorscheme github_light")
    if vim.g.colors_name == "github_light" then
      -- local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      -- vim.api.nvim_set_hl(0, "Normal", vim.tbl_extend("force", normal_hl, { bg = "#FAFAFA" }))
      vim.api.nvim_set_hl(0, "Comment", { link = "Comment", fg = "#6A737D" })
      vim.api.nvim_set_hl(0, "Delimiter", { link = "Delimiter", fg = "#24292F" }) -- for punctuation ',' '.', etc
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#BFC0C1" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#F6F8FA" })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "#F1F3F5" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#24292F" })
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#F3F5F7" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#F3F5F7", bg = "#F3F5F7" })
      vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#EDEFF1" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#F3F5F7", bg = "#F3F5F7" })
      vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#F3F5F7", bg = "#18654B" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#F3F5F7", bg = "#F3F5F7" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#EDEFF1" })
      vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#F3F5F7", bg = "#DE2C2E" })
      vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#DE2C2E", bg = "#EDEFF1" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#EDEFF1", bg = "#EDEFF1" })

      -- -- if changing background to something else such as #FAFAFA
      -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#EFF0F2" })
      -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#E7EAF0" })
      -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#F3F4F6" })
      -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#F3F4F6" })
      -- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#E2E5EA" })
      -- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#F3F4F6" })
      -- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#F3F4F6", bg = "#F3F4F6" })
    end
  end,
}

return M
