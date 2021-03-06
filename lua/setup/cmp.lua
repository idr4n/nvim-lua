local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

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

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = " ",
	Method = "m ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- from https://github.com/NvChad/ui/blob/main/lua/nvchad_ui/icons.lua
local nvchad_icons = {
	Namespace = "",
	-- Text = "",
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	-- Variable = "",
	-- Variable = "",
	Variable = "",
	-- Class = "ﴯ",
	Class = " ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "了",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	-- EnumMember = "了",
	EnumMember = "",
	-- Constant = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	-- TypeParameter = "",
	TypeParameter = "",
	Table = "",
	Object = "",
	Tag = "",
	Array = "[]",
	Boolean = "",
	Number = "",
	Null = "ﳠ",
	String = "",
	Calendar = "",
	Watch = "",
	Package = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
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
})
