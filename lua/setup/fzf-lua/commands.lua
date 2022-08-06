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
		vim.cmd("tcd " .. pwd)
		-- require("telescope.builtin").find_files({
		-- 	-- previewer = false,
		-- 	on_complete = {
		-- 		function()
		-- 			vim.cmd("startinsert")
		-- 		end,
		-- 	},
		-- })
		-- require("fzf-lua").files()
		-- vim.cmd("Files")
		-- require("fzf-lua.actions").ensure_insert_mode()
		print(("Working dir set to %s"):format(vim.fn.shellescape(pwd)))
	else
		print(("Unable to set wd to %s, directory is not accessible"):format(vim.fn.shellescape(pwd)))
	end
end

-- @args - table that takes into consideration two possible fields:
-- new_tab: bool - if changing working directory in a new tab
-- nvim_tmux: bool - if changing working directory in a new tab
function M.workdirs(args)
	args = args or {}

	-- workdirs.lua returns a table of workdirs
	local ok, dirs = pcall(require, "workdirs")
	if not ok then
		dirs = {}
	end

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
		local newcwd = selected[1]:match("%s%s(.*)")
		newcwd = fzf_lua.path.starts_with_separator(newcwd) and newcwd
			or fzf_lua.path.join({ vim.fn.expand("$HOME"), newcwd })

		if os.getenv("TERM_PROGRAM") == "tmux" and args.nvim_tmux then
			vim.cmd(string.format("execute 'silent !tmux new-window -c %s nvim'", newcwd))
			return
		elseif args.nvim_terminal or args.nvim_tmux then
			local cmd = {
				alacritty = "open -na alacritty --args --working-directory %s -e fish -ic nvim'",
				wezterm = "wezterm start --always-new-process --cwd %s nvim'",
				["xterm-kitty"] = "open -na kitty --args -d %s nvim'",
			}
			vim.cmd(string.format("execute 'silent !" .. cmd[vim.env.TERM], newcwd))
			return
		elseif args.nvim_alacritty then
			vim.cmd(
				string.format(
					"execute 'silent !open -na alacritty --args --working-directory %s -e fish -ic nvim'",
					newcwd
				)
			)
			return
		end

		set_cwd(newcwd, args.new_tab)
	end)()
end

return M
