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

-- Install your plugins here
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = { lazy = true },
    install = { colorscheme = { "tokyonight", "catppuccin", "github-theme" } },
    --
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
            -- disable_events = {},
        },
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
})
