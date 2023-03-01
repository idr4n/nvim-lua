return {
    --: clipboard-image {{{
    {
        "ekickx/clipboard-image.nvim",
        ft = "markdown",
        opts = {
            -- Default configuration for all filetype
            default = {
                img_dir = { "%:p:h", "assets" },
            },
            markdown = {
                img_dir_txt = "./assets",
            },
        },
        config = function(_, opts)
            require("clipboard-image").setup(opts)
        end,
    },
    --: }}}

    --: nvim-cmp {{{
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local nvchad_icons = require("util").nvchad_icons

            -- require("luasnip/loaders/from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
            end

            local function border(hl_name)
                return {
                    { "╭", hl_name },
                    { "─", hl_name },
                    { "╮", hl_name },
                    { "│", hl_name },
                    { "╯", hl_name },
                    { "─", hl_name },
                    { "╰", hl_name },
                    { "│", hl_name },
                }
            end

            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                preselect = cmp.PreselectMode.None,
                mapping = {
                    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
                    -- ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.config.disable,
                    ["<C-x>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-l>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                        -- if luasnip.jumpable(1) then
                        --   luasnip.jump(1)
                        -- elseif cmp.visible() then
                        --   cmp.select_next_item()
                        -- elseif check_backspace() then
                        --   fallback()
                        -- else
                        --   fallback()
                        -- end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                        -- if luasnip.jumpable(-1) then
                        --   luasnip.jump(-1)
                        -- elseif cmp.visible() then
                        --   cmp.select_prev_item()
                        -- else
                        --   fallback()
                        -- end
                    end, { "i", "s" }),
                },
                formatting = {
                    -- fields = { "kind", "abbr", "menu" },
                    -- fields = { "abbr", "kind" },
                    fields = { "abbr", "kind", "menu" },
                    format = function(entry, vim_item)
                        -- format = function(_, vim_item)
                        -- Kind icons
                        -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        vim_item.kind = string.format("%s %s", nvchad_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        vim_item.menu = ({
                            -- nvim_lsp = "[LSP]",
                            -- nvim_lua = "[NVIM_LUA]",
                            -- luasnip = "[Snippet]",
                            -- buffer = "[Buffer]",
                            -- path = "[Path]",
                            nvim_lsp = "",
                            nvim_lua = "",
                            luasnip = "",
                            buffer = "",
                            path = "",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    -- { name = "copilot" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = {
                        border = border("CmpBorder"),
                        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                    },
                    documentation = {
                        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        border = border("CmpDocBorder"),
                        winhighlight = "Normal:CmpPmenu",
                    },
                },
                experimental = {
                    ghost_text = false,
                    native_menu = false,
                },
            }
        end,
    },
    --: }}},

    --: mini.comment {{{
    {
        "echasnovski/mini.comment",
        -- event = "VeryLazy",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring({})
                end,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
    --: }}}

    --: mini.pairs {{{
    {
        "echasnovski/mini.pairs",
        -- event = "VeryLazy",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.pairs").setup({
                mappings = {
                    [" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" },
                    -- ["<"] = { action = "open", pair = "<>" },
                    -- [">"] = { action = "close", pair = "<>" },
                },
            })
        end,
    },
    --: }}},
}
