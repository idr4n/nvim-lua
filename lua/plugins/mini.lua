return {
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
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
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
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
}
