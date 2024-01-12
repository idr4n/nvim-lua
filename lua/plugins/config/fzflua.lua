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
local function workdirs(args)
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
        width = math.min(math.ceil(vim.fn.winwidth(0) * 0.7), 110),
        height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 23),
        row = 0.40,
    }

    opts.fzf_opts = {
        ["--no-multi"] = "",
        ["--prompt"] = "Workdirs❯ ",
        ["--preview-window"] = "hidden:right:0",
        ["--header-lines"] = "1",
        ["--layout"] = "reverse",
    }

    opts.actions = {
        ["default"] = function(selected)
            _previous_cwd = vim.loop.cwd()
            local newcwd = selected[1]:match("[^ ]*$")
            newcwd = fzf_lua.path.starts_with_separator(newcwd) and newcwd
                or fzf_lua.path.join({ vim.env.HOME, newcwd })

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
        end,
    }

    fzf_lua.fzf_exec(fzf_fn, opts)
end

M.opts = {
    winopts = {
        height = 0.45,
        width = 1,
        row = 1,
        border = { "─", "─", "─", " ", "", "", "", " " },
        preview = {
            vertical = "up:40%",
            horizontal = "right:54%",
            flip_columns = 120,
            delay = 60,
            scrollbar = false,
            hidden = "hidden",
        },
    },
    -- winopts_fn = function()
    --     -- smaller width if neovim win has over 80 columns
    --     local max_width = 140 / vim.o.columns
    --     local max_height = 30 / vim.o.lines
    --     -- return { width = vim.o.columns > 140 and max_width or 1 }
    --     return {
    --         width = math.min(max_width, 1),
    --         height = math.min(max_height, 1),
    --     }
    -- end,
    fzf_opts = {
        -- ["--layout"] = "default",
        ["--layout"] = "reverse",
    },
    fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Comment" },
        -- ["fg+"] = { "fg", "ModeMsg" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["border"] = { "fg", "FZFLuaBorder" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bg", "Normal" },
    },
    files = {
        cmd = "rg --files --hidden --follow --no-ignore -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'",
        prompt = "  ",
    },
    grep = {
        rg_opts = "--hidden --column --follow --line-number --no-heading "
            .. "--color=always --smart-case -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'",
        prompt = "  ",
    },
    blines = { prompt = "  " },
    keymap = {
        builtin = {
            ["<C-L>"] = "toggle-preview",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"] = "preview-page-up",
        },
        fzf = {
            ["ctrl-l"] = "toggle-preview",
            ["ctrl-q"] = "select-all+accept", -- send all to quick list
        },
    },
    -- needed for kitty for better icon rendering
    file_icon_padding = " ",
    nbsp = "\xc2\xa0",
}

return M
