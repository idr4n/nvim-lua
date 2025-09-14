return {
  "voldikss/vim-floaterm",
  cmd = "FloatermNew",
  keys = {
    { ",b", "<cmd>Broot<cr>", desc = "Broot (CWD)" },
    { ",B", "<cmd>BrootCWD<cr>", desc = "Broot" },
    { ",r", "<cmd>BrootSearch<cr>", desc = "Broot (Sarch Content)" },
  },
  config = function()
    vim.g.floaterm_opener = "edit"
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

    local win_width = 0.7
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
