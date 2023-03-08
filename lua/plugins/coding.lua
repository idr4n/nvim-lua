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
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local handlers = require("nvim-autopairs.completion.handlers")

            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    filetypes = {
                        -- "*" is a alias to all filetypes
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"],
                            },
                        },
                    },
                })
            )
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
        enabled = false,
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

    --: windwp/nvim-autopairs {{{
    {
        "windwp/nvim-autopairs",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup()

            local Rule = require("nvim-autopairs.rule")

            local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
            npairs.add_rules({
                Rule(" ", " "):with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                        brackets[2][1] .. brackets[2][2],
                        brackets[3][1] .. brackets[3][2],
                    }, pair)
                end),
            })
            for _, bracket in pairs(brackets) do
                npairs.add_rules({
                    Rule(bracket[1] .. " ", " " .. bracket[2])
                        :with_pair(function()
                            return false
                        end)
                        :with_move(function(opts)
                            return opts.prev_char:match(".%" .. bracket[2]) ~= nil
                        end)
                        :use_key(bracket[2]),
                })
            end
        end,
    },
    --: }}}

    --: yanky {{{
    {
        "gbprod/yanky.nvim",
        -- enabled = false,
        event = "BufReadPost",
        cmd = { "YankyRingHistory", "YankyClearHistory" },
        keys = {
            -- { ",r", "<cmd>YankyRingHistory<cr>", noremap = true, silent = true },
            -- { ",r", "<cmd>Telescope yank_history<cr>", noremap = true, silent = true },
            {
                ",r",
                "<cmd>lua require('telescope').extensions.yank_history.yank_history({ initial_mode = 'normal' })<cr>",
                noremap = true,
                silent = true,
            },
        },
        opts = function()
            require("telescope").load_extension("yank_history")
            local utils = require("yanky.utils")
            local mapping = require("yanky.telescope.mapping")

            return {
                ring = {
                    history_length = 50,
                },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 70,
                },
                picker = {
                    telescope = {
                        mappings = {
                            default = mapping.put("p"),
                            i = {
                                ["<c-p>"] = mapping.put("P"),
                                ["<c-k>"] = nil,
                                ["<c-x>"] = mapping.delete(),
                                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
                            },
                            n = {
                                p = mapping.put("p"),
                                P = mapping.put("P"),
                                d = mapping.delete(),
                                r = mapping.set_register(utils.get_default_register()),
                            },
                        },
                    },
                },
            }
        end,
    },
    --: }}}
}
