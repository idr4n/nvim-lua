return {
  "voldikss/vim-floaterm",
  cmd = "FloatermNew",
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        vim.cmd("FloatermNew --width=0.85 --height=0.9 --title=Broot broot")
        vim.defer_fn(function()
          vim.cmd("FloatermToggle")
        end, 50)
      end
    end
  end,
  keys = {
    { ",,", "<cmd>Broot<cr>", desc = "Broot (CWD)" },
    { ",b", "<cmd>BrootCWD<cr>", desc = "Broot" },
    { ",v", "<cmd>BrootSplit<cr>", desc = "Broot (Split)" },
    { ",r", "<cmd>BrootSearch<cr>", desc = "Broot (Sarch Content)" },
  },
  config = function()
    vim.g.floaterm_opener = "edit"
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

    local win_width = 0.85
    local win_height = 0.9

    -- Helper function to create broot command with current file
    local function get_broot_command(opts)
      opts = opts or { cwd = false }
      local current_file = vim.fn.expand("%:p")
      local current_file2 = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.") -- file name with relative path
      local broot_command = "broot -h"

      -- Only add the file path if we're in a valid buffer
      if current_file ~= "" then
        if not opts.cwd then
          broot_command = broot_command .. ' -c ":mode_input"'
        else
          -- broot_command = broot_command .. ' -c "' .. current_file2:gsub("/", "\\/") .. ':escape"'
          broot_command = broot_command .. ' -c "' .. current_file2:gsub("/", "\\/") .. '"'
        end
      end

      return broot_command
    end

    -- Floating window (current file)
    vim.api.nvim_create_user_command("Broot", function()
      vim.cmd(
        string.format("FloatermNew --width=%s --height=%s --title=Broot ", win_width, win_height) .. get_broot_command()
      )
    end, {})

    -- Split terminal version (cwd)
    vim.api.nvim_create_user_command("BrootSplit", function()
      vim.cmd(
        "FloatermNew --wintype=vsplit --width=0.32 --position=leftabove --title=Broot "
          .. get_broot_command({ cwd = true })
      )
    end, {})

    -- Floating window (cwd)
    vim.api.nvim_create_user_command("BrootCWD", function()
      vim.cmd(
        string.format("FloatermNew --width=%s --height=%s --title=Broot ", win_width, win_height)
          .. get_broot_command({ cwd = true })
      )
    end, {})

    -- Floating window (Search Content)
    vim.api.nvim_create_user_command("BrootSearch", function()
      vim.cmd(
        string.format(
          'FloatermNew --width=%s --height=%s --title=Broot broot -h -c ":mode_input;c/"',
          win_width,
          win_height
        )
      )
    end, {})
  end,
}
