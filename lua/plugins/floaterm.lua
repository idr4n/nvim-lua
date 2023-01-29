return {
	"ptzz/lf.vim",
	dependencies = "voldikss/vim-floaterm",
	keys = {
		{ ",l", ":Lf<cr>", noremap = true, silent = true },
	},
	config = function()
		local function calcFloatSize()
			return {
				width = math.min(math.ceil(vim.fn.winwidth(0) * 0.9), 140),
				height = math.min(math.ceil(vim.fn.winheight(0) * 0.9), 35),
			}
		end

		local function recalcFloatermSize()
			vim.g.floaterm_width = calcFloatSize().width
			vim.g.floaterm_height = calcFloatSize().height
		end

		vim.api.nvim_create_augroup("floaterm", { clear = true })
		vim.api.nvim_create_autocmd("VimResized", {
			pattern = { "*" },
			callback = recalcFloatermSize,
			group = "floaterm",
		})

		vim.g.floaterm_width = calcFloatSize().width
		vim.g.floaterm_height = calcFloatSize().height
	end,
}
