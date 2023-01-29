-- -- Mapped snippets --
local function map_snippet(keys, snippet)
	vim.keymap.set("i", keys, function()
		require("luasnip").snip_expand(snippet)
	end)
end

return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	keys = {
		{
			"<c-j>",
			function()
				if require("luasnip").jumpable(1) then
					require("luasnip").jump(1)
				end
			end,
			mode = { "i", "s" },
			silent = true,
		},
		{
			"<c-k>",
			function()
				if require("luasnip").jumpable(-1) then
					require("luasnip").jump(-1)
				end
			end,
			mode = { "i", "s" },
			silent = true,
		},
		{
			"<c-l>",
			function()
				if require("luasnip").choice_active() then
					require("luasnip").change_choice(1)
				end
			end,
			mode = "i",
		},
		{
			"<c-h>",
			function()
				if require("luasnip").choice_active() then
					require("luasnip").change_choice(-1)
				end
			end,
			mode = "i",
		},
	},
	config = function()
		local ls = require("luasnip")
		local mappable = require("plugins.luasnip.snips")

		-- loads snippets from path/of/nvim/config/
		require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
		-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
		-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

		-- Settings --
		ls.filetype_extend("typescript", { "javascript" })
		ls.filetype_extend("javascriptreact", { "javascript" })
		ls.filetype_extend("typescriptreact", { "javascript" })

		ls.config.set_config({
			store_selection_keys = "<c-s>",
			history = true,
			enable_autosnippets = true,
		})

		-- surrounds with {|}
		map_snippet(";cc", mappable.sc)
		vim.api.nvim_set_keymap("v", ";cc", "<c-s>;cc", { noremap = false, silent = false })

		-- surrounds with callback function
		map_snippet(";cf", mappable.sf)
		vim.api.nvim_set_keymap("v", ";cf", "<c-s>;cf", { noremap = false, silent = false })
	end,
}
