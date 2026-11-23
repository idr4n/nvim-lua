-- load options before lazy
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
require("config.options")
-- local Util = require("utils")

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- "\" is the default

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    -- load mappings
    require("config.mappings")
    -- load statusline
    require("config.statusline")
  end,
})

--: load commands and autocmds
require("config.commands")
require("config.autocmds")

--: load lazy.nvim and plugins
-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight", "dracula" } },
  --
  change_detection = { notify = false },
  dev = { path = "~/other_repos", patterns = { "idr4n" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    backdrop = 100,
  },
})

-- Load colorscheme
-- Match the colorscheme to the active Omarchy theme.
local state_home = vim.env.XDG_STATE_HOME
if not state_home or state_home == "" then
  state_home = vim.env.HOME .. "/.local/state"
end

local omarchy_current = state_home .. "/omarchy/current"

local file = io.open(omarchy_current .. "/theme.name", "r")
local omarchy_theme = file and file:read("*l") or nil
if file then
  file:close()
end

-- Light/dark mode of the Omarchy theme: `mode = "light"` in colors.toml,
-- or a legacy `light.mode` marker file. Defaults to dark.
local function omarchy_mode()
  local colors = io.open(omarchy_current .. "/theme/colors.toml", "r")
  if colors then
    for line in colors:lines() do
      local mode = line:match('^%s*mode%s*=%s*"(%a+)"') or line:match('^%s*theme_type%s*=%s*"(%a+)"')
      if mode then
        colors:close()
        return mode
      end
    end
    colors:close()
  end
  if vim.uv.fs_stat(omarchy_current .. "/theme/light.mode") then
    return "light"
  end
  return "dark"
end

local colorschemes = {
  snow = "github-monochrome-light",
  nord = "nord",
  ["tokyo-night"] = "tokyonight",
  lupine = "github-monochrome-light",
}
local colorscheme = colorschemes[omarchy_theme]
  or (omarchy_mode() == "light" and "github-monochrome-light" or "tokyonight")
vim.cmd.colorscheme(colorscheme)
