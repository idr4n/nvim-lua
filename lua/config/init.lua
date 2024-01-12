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
        require("config.statusline")
    end,
})

--: load commands and autocmds
require("config.commands")

--: load lazy.nvim
require("config.lazy")

--: load colorscheme
require("tokyonight").load()
-- vim.cmd("colorscheme kanagawa")
-- require("onedark").load()
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme monokai-pro")
-- vim.cmd("colorscheme catppuccin-frappe")
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme catppuccin-mocha")

-- stylua: ignore
if vim.g.colors_name == "default" or vim.g.colors_name == nil then
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    -- local diff_changed = vim.api.nvim_get_hl(0, { name = "DiffChange" })
    -- vim.api.nvim_set_hl(0, "NeoTreeNormal", vim.tbl_extend("force", normal_hl, { bg = "#181B20" }))
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
    vim.api.nvim_set_hl( 0, "Comment", vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = "Comment" }), { italic = true }))
end
