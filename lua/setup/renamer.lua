--  'filipdutescu/renamer.nvim'

local renamer = require("renamer")
renamer.setup()

-- required fix for now based on Issue #117 https://github.com/filipdutescu/renamer.nvim/issues/117
renamer._apply_workspace_edit = function(resp)
	local params = vim.lsp.util.make_position_params()
	local results_lsp, _ = vim.lsp.buf_request_sync(0, require("renamer.constants").strings.lsp_req_rename, params)
	local client_id = results_lsp and next(results_lsp) or nil
	local client = vim.lsp.get_client_by_id(client_id)
	require("vim.lsp.util").apply_workspace_edit(resp, client.offset_encoding)
end

-- Mappings
vim.api.nvim_set_keymap("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F2>", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F2>", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
