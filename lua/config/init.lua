-- load options before lazy
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
require("config.options")

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    -- load mappings
    require("config.mappings")
    -- load statusline
    -- require("config.statusline")
  end,
})

--: load commands and autocmds
require("config.commands")

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
require("plugins")

--: load colorscheme
require("tokyonight").load()
-- vim.cmd("colorscheme kanagawa")
-- require("onedark").load()
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme monokai-pro")
-- vim.cmd("colorscheme catppuccin-frappe")
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme catppuccin-mocha")
-- require("plugins.config.colorschemes").darkplus.setup()
-- require("plugins.config.colorschemes").NvimDefault.setup()
