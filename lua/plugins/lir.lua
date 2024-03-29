return {
  "tamago324/lir.nvim",
  enabled = false,
    -- stylua: ignore
    keys = {
      -- { "-", "<Cmd>execute 'e ' .. expand('%:p:h')<CR>", desc = "Open file explorer" },
      { "<C-Q>", function() require('lir.float').toggle() end, desc = "Toggle file explorer" },
    },
  dependencies = {
    {
      "tamago324/lir-git-status.nvim",
      config = function()
        require("lir.git_status").setup({
          show_ignored = true,
        })
      end,
    },
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("lir.float")
      end
    end
  end,
  opts = function()
    local actions = require("lir.actions")
    local mark_actions = require("lir.mark.actions")
    local clipboard_actions = require("lir.clipboard.actions")

    return {
      show_hidden_files = true,
      ignore = {}, -- { ".DS_Store", "node_modules" } etc.
      devicons = {
        enable = true,
        highlight_dirname = false,
      },
      mappings = {
        ["l"] = actions.edit,
        ["<C-s>"] = actions.split,
        ["<C-v>"] = actions.vsplit,
        ["<C-t>"] = actions.tabedit,

        ["-"] = actions.up,
        ["h"] = actions.up,
        ["q"] = actions.quit,

        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["@"] = actions.cd,
        ["Y"] = actions.yank_path,
        ["."] = actions.toggle_show_hidden,
        ["D"] = actions.delete,

        ["J"] = function()
          mark_actions.toggle_mark()
          vim.cmd("normal! j")
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste,
      },
      float = {
        winblend = 0,
        curdir_window = {
          enable = false,
          highlight_dirname = false,
        },
        -- -- You can define a function that returns a table to be passed as the third
        -- -- argument of nvim_open_win().
        win_opts = function()
            -- local width = math.floor(vim.o.columns * 0.8)
            -- local height = math.floor(vim.o.lines * 0.8)
            -- stylua: ignore
            return {
              border = {
                "╭", "─", "╮", "│", "╯", "─", "╰", "│"
              },
              -- width = width,
              -- height = height,
              -- row = 1,
              -- col = math.floor((vim.o.columns - width) / 2),
            }
        end,
      },
      hide_cursor = false,
    }
  end,
}
