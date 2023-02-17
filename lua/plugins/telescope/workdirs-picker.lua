local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local Path = require("plenary.path")

local M = {}

local entries = {}

function M.set_cwd(pwd, new_tab)
    if not pwd then
        local parent = vim.fn.expand("%:h")
        pwd = M.git_root(parent, true) or parent
    end

    if vim.loop.fs_stat(pwd) then
        if new_tab then
            vim.cmd("tabnew")
        end
        vim.cmd("tcd " .. pwd)
        print(("Working dir set to %s"):format(vim.fn.shellescape(pwd)))
    else
        print(("Unable to set wd to %s, directory is not accessible"):format(vim.fn.shellescape(pwd)))
    end
end

local add_entry = function(path)
    if not path then
        return
    end
    path = vim.fn.expand(path)
    if not vim.loop.fs_stat(path) or path == _Previous_cwd or path == vim.loop.cwd() then
        return
    end
    entries[#entries + 1] = { path, Path:new(path):make_relative(vim.fn.expand("$HOME")) }
end

local displayer = entry_display.create({
    separator = " ",
    items = {
        { remaining = true },
    },
})

local make_display = function(entry)
    if entry.value == _Previous_cwd then
        return displayer({
            { entry.relative_path, "Number" },
        })
    end

    return displayer({
        entry.relative_path,
    })
end

local function workdirs(args)
    args = args or {}
    entries = {}

    local ok, dirs = pcall(require, "workdirs")
    if not ok then
        dirs = {}
    end

    if _Previous_cwd then
        entries[1] = { _Previous_cwd, Path:new(_Previous_cwd):make_relative(vim.fn.expand("$HOME")) }
    end
    for _, path in ipairs(dirs) do
        add_entry(path)
    end

    return entries
end

-- our picker function: colors
M.set_workdir = function(opts)
    opts = opts or require("telescope.themes").get_dropdown({})
    pickers
        .new(opts, {
            prompt_title = "Workdirs",
            finder = finders.new_table({
                results = workdirs(),
                entry_maker = function(entry)
                    return {
                        value = entry[1],
                        relative_path = entry[2],
                        display = make_display,
                        ordinal = entry[2],
                    }
                end,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    -- print(vim.inspect(selection))
                    _Previous_cwd = vim.loop.cwd()
                    M.set_cwd(selection.value)
                end)
                return true
            end,
        })
        :find()
end

return M
