return {
	"mattn/emmet-vim",
	event = "InsertEnter",
	init = function()
		vim.g.user_emmet_leader_key = "<C-W>"
	end,
}
