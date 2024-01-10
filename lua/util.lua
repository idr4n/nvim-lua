local M = {}

--   פּ ﯟ   some other good icons
M.kind_icons = {
    Class = "󰌗 ",
    Color = "󰏘 ",
    Constant = "󰇽 ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "󰈙 ",
    Folder = "󰉋 ",
    Function = "󰊕 ",
    Interface = " ",
    Keyword = "󰌋 ",
    Method = "m ",
    Module = " ",
    Operator = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = "󰉿 ",
    TypeParameter = "󰊄 ",
    Unit = " ",
    Value = "󰎠 ",
    Variable = "󰆧 ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- from https://github.com/NvChad/ui/blob/main/lua/nvchad_ui/icons.lua
M.nvchad_icons = {
    -- Class = "󰠱",
    -- Constant = "󰏿",
    -- EnumMember = "󰒻",
    -- Text = "󰉿",
    -- TypeParameter = "󰊄",
    -- Variable = "",
    -- Variable = "󰂡",
    Array = "[]",
    Boolean = "",
    Calendar = "",
    Class = "",
    Color = "󰏘",
    Constant = "",
    Constructor = "",
    -- Enum = "󰒻",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰜢",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰆧",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Namespace = "󰌗",
    Null = "󰟢",
    Number = "",
    Object = "󰅩",
    Operator = "󰆕",
    Package = "",
    Property = "󰜢",
    Reference = "󰈇",
    Snippet = "",
    String = "󰉿",
    Struct = "󰙅",
    Table = "",
    Tag = "",
    Text = "",
    TypeParameter = "",
    Unit = "󰑭",
    Value = "󰎠",
    Variable = "",
    Watch = "󰥔",
}

M.nyoom_icons = {
    Class = "  ",
    Color = "  ",
    Constant = "  ",
    Constructor = "  ",
    Copilot = "  ",
    Enum = "  ",
    EnumMember = "  ",
    Event = "  ",
    Field = "  ",
    File = "  ",
    Folder = "  ",
    Function = "  ",
    Interface = "  ",
    Keyword = "  ",
    Method = "  ",
    Module = "  ",
    Operator = "  ",
    Property = "  ",
    Reference = "  ",
    Snippet = "  ",
    Struct = "  ",
    Text = "  ",
    TypeParameter = "  ",
    Unit = "  ",
    Value = "  ",
    Variable = "  ",
}

-- source: NvChad config
M.lazy_load = function(plugin)
    vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
        callback = function()
            local file = vim.fn.expand("%")
            local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

            if condition then
                vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

                -- dont defer for treesitter as it will show slow highlighting
                -- This deferring only happens only when we do "nvim filename"
                if plugin ~= "nvim-treesitter" then
                    vim.schedule(function()
                        require("lazy").load({ plugins = plugin })

                        if plugin == "nvim-lspconfig" then
                            vim.cmd("silent! do FileType")
                        end
                    end, 0)
                else
                    require("lazy").load({ plugins = plugin })
                end
            end
        end,
    })
end
return M
