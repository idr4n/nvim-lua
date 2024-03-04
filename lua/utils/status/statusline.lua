local M = {}

local component = require("utils.status.component")
local provider = require("utils.status.provider")
local conditions = require("heirline.conditions")

-- local M.HiddenStatusline = {
--   condition = function()
--     return conditions.buffer_matches({
--       filetype = { "dashboard", "alpha" },
--     })
--   end,
--   component.Hidden,
-- }

---@param opts? {with_delimiter:boolean, aligned_right:boolean}
M.SpecialStatusline = function(opts)
  opts = opts or {}
  return {
    condition = function()
      return conditions.buffer_matches({
        -- filetype = { "neo%-tree", "^lazy$", "TelescopePrompt", "mason" },
        filetype = { "neo%-tree", "^lazy$", "mason" },
      })
    end,
    hl = { bg = "normal_bg" },
    opts.aligned_right and component.Align or {},
    component.Special({ margin = { left = 0, right = 0 } }),
    opts.with_delimiter and component.Delimeter({
      char = "",
      color = { fg = "blue", bg = "status_bg" },
    }) or {},
  }
end

M.DefaultStatusline = {
  -- dividers    
  hl = { fg = "status_fg", bg = "status_bg" },
  component.SectionModeBg({
    margin = { left = 0, right = 0 },
    color = { bold = true },
    children = {
      { provider = provider.mode_long },
    },
  }),
  {
    condition = conditions.is_git_repo,
    component.Delimeter({
      char = "",
      color = { fg = "mode", bg = "bright_bg" },
    }),
  },
  {
    condition = conditions.is_git_repo,
    component.SectionModeFg({
      margin = { left = 0, right = 0 },
      color = { bg = "bright_bg" },
      children = {
        component.GitBranch(),
      },
      -- upate = { "GitSignsUpdate" },
    }),
    component.Delimeter({
      char = "",
      color = { fg = "bright_bg" },
      margin = { right = 1 },
    }),
  },
  {
    condition = function()
      return not conditions.is_git_repo()
    end,
    component.Delimeter({
      char = "",
      color = { fg = "mode" },
      margin = { right = 1 },
    }),
  },
  component.Diagnostics({ sep = { right = "" }, margin = { left = 0 } }),
  component.FileNameBlock({ margin = { left = 0 } }),
  component.Align,
  component.SearchCount(),
  component.Align,
  component.StatusCmd(),
  {
    { provider = " " },
    component.LSPActive({ margin = { left = 0 } }),
    component.Updates({ margin = { left = 0 } }),
    condition = function()
      return require("lazy.status").has_updates() or conditions.lsp_attached()
    end,
  },
  component.StatusMode({ sep = { left = " " }, margin = { left = 0 } }),
  component.GitDiff({ sep = { left = " " }, margin = { left = 0, right = 0 } }),
  component.Delimeter({
    char = "",
    color = { fg = "bright_bg" },
  }),
  component.SectionModeFg({
    margin = { left = 0, right = 0 },
    color = { bg = "bright_bg" },
    children = { component.Scrollbar() },
  }),
  component.Delimeter({
    char = "",
    color = { fg = "mode", bg = "bright_bg" },
  }),
  component.SectionModeBg({
    margin = { right = 0, left = 0 },
    children = {
      component.Location(),
    },
  }),
}

--- Status line inspired by https://github.com/leath-dub/stat.nvim
---@param opts? {show_more_info:boolean}
function M.SimpleStatusline(opts)
  opts = opts or { show_more_info = false }
  _G.show_more_info = opts.show_more_info
  -- vim.g.show_more_info = opts.show_more_info

  return {
    init = function(self)
      self.show_more_info = _G.show_more_info
      -- self.show_more_info = vim.g.show_more_info
    end,
    -- hl = { fg = "status_fg", bg = "normal_bg" },
    hl = { fg = "fg_darken", bg = "normal_bg" },
    component.Section({
      hl = { fg = "stealth", force = true },
      children = {
        component.FileNameBlock(),
        component.GitBranch(),
      },
      condition = function(self)
        return self.show_more_info
      end,
    }),
    component.Align,
    component.SearchCount(),
    component.Align,
    component.Section({
      hl = { fg = "stealth" },
      children = {
        component.CharCode(),
        component.Location({ margin = { left = 0 } }),
      },
      condition = function(self)
        return self.show_more_info
      end,
    }),
    component.StatusMode({ sep = { left = " " } }),
    component.SectionModeBg({
      margin = { left = 0, right = 0 },
      color = { bold = true },
      children = {
        { provider = provider.mode_long },
      },
    }),
    {
      provider = function()
        return " " .. string.upper(vim.bo.filetype)
      end,
      hl = function()
        -- return conditions.lsp_attached() and { bg = "#272E33" } or { bg = "#272E33", fg = "stealth" }
        return conditions.lsp_attached() and { bg = "bg_lighten" } or { bg = "bg_lighten", fg = "stealth" }
      end,
      -- stylua: ignore
      -- component.LSPActive({ icon = "", clients_total = false, hl = { fg = "stealth" }, margin = { left = 0, right = 0 }, }),
      { provider = " " },
    },
    component.GitDiffSimple({
      margin = { left = 0, right = 0 },
      -- hl = { bg = "#232A2E", fg = "comment", force = false },
      hl = { bg = "bg_lighten_less", fg = "comment", force = false },
    }),
    component.Section({
      padding = { left = 1 },
      children = { component.Diagnostics({ margin = { left = 0, right = 0 } }) },
      -- hl = { bg = "#232A2E", fg = "comment", force = true },
      hl = { bg = "bg_lighten_less", fg = "comment", force = true },
      condition = conditions.has_diagnostics,
    }),
    component.Updates(),
  }
end

return M
