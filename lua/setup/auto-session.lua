-- "rmagatti/auto-session"

vim.o.sessionoptions="buffers,curdir,folds,help,winsize,winpos"

require("auto-session").setup({
	-- pre_save_cmds = { "tabdo NvimTreeClose" },
	auto_session_suppress_dirs = { os.getenv("HOME") },
	auto_session_create_enabled = false,
	bypass_session_save_file_types = { "alpha", "NvimTree", "dirvish", "nnn", "man" },
	-- auto_save_enabled = false,
	-- auto_restore_enabled = false,
})
