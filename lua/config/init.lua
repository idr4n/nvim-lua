-- load options before lazy
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
require("config.options")

-- load statusline
require("config.statusline")

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.fn.argc(-1) == 0 then
    -- keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            require("config.mappings")
        end,
    })
else
    -- load them now so they affect the opened buffers
    require("config.mappings")
end

-- load commands and autocmds
require("config.commands")

-- load lazy.nvim
require("config.lazy")
