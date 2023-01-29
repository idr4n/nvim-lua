return {
	"mattn/emmet-vim",
	event = "InsertEnter",
	config = function()
		vim.g.user_emmet_leader_key = "<C-W>"
	end,
}
