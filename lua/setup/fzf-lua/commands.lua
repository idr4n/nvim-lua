local res, fzf_lua = pcall(require, "fzf-lua")
if not res then
	return
end

local M = {}

local function set_cwd(pwd, new_tab)
	if not pwd then
		local parent = vim.fn.expand("%:h")
		pwd = M.git_root(parent, true) or parent
	end

	if vim.loop.fs_stat(pwd) then
		if new_tab then
			vim.cmd("tabnew")
		end
		vim.cmd("lcd " .. pwd)
		-- require("telescope.builtin").find_files({
      -- previewer = false,
		-- 	on_complete = {
		-- 		function()
		-- 			vim.cmd("startinsert")
		-- 		end,
		-- 	},
		-- })
		-- require("fzf-lua").files()
		vim.cmd("Files")
		require("fzf-lua.actions").ensure_insert_mode()
		print(("Workingdir set to %s"):format(vim.fn.shellescape(pwd)))
	else
		print(("Unable to set wd to %s, directory is not accessible"):format(vim.fn.shellescape(pwd)))
	end
end

function M.workdirs(new_tab)
	if not new_tab then
		new_tab = false
	end

	-- workdirs.lua returns a table of workdirs
	local ok, dirs = pcall(require, "workdirs")
	if not ok then
		dirs = {}
	end
	-- local dirs = {}
	-- -- Get _G.paths defined in lua/commands.lua
	-- if _G.paths ~= nil then
	-- 	dirs = _G.paths
	-- end

	local iconify = function(path, color, icon)
		icon = fzf_lua.utils.ansi_codes[color](icon)
		path = fzf_lua.path.relative(path, vim.fn.expand("$HOME"))
		return ("%s  %s"):format(icon, path)
	end

	local dedup = {}
	local entries = {}
	local add_entry = function(path, color, icon)
		if not path then
			return
		end
		path = vim.fn.expand(path)
		if not vim.loop.fs_stat(path) then
			return
		end
		if dedup[path] ~= nil then
			return
		end
		entries[#entries + 1] = iconify(path, color or "blue", icon or "")
		dedup[path] = true
	end

	add_entry(vim.loop.cwd(), "magenta", "")
	add_entry(_previous_cwd, "yellow")
	for _, path in ipairs(dirs) do
		add_entry(path)
	end

	local fzf_fn = function(cb)
		for _, entry in ipairs(entries) do
			cb(entry)
		end
		cb(nil)
	end

	local opts = {}

	opts.winopts = {
		height = 0.4,
		width = 0.70,
		row = 0.40,
	}

	opts.fzf_opts = {
		["--no-multi"] = "",
		["--prompt"] = "Workdirs❯ ",
		["--preview-window"] = "hidden:right:0",
		["--header-lines"] = "1",
		["--layout"] = "reverse",
	}

	fzf_lua.fzf_wrap(opts, fzf_fn, function(selected)
		if not selected then
			return
		end
		_previous_cwd = vim.loop.cwd()
		local newcwd = selected[1]:match("[^ ]*$")
		newcwd = fzf_lua.path.starts_with_separator(newcwd) and newcwd
			or fzf_lua.path.join({ vim.fn.expand("$HOME"), newcwd })
		set_cwd(newcwd, new_tab)
	end)()
end

return M
