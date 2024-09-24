return {
  "echasnovski/mini.files",
  keys = {
    -- { "-", ":lua require('mini.files').open()<cr>", silent = true, desc = "Mini Files" },
    -- {
    --   "-",
    --   function()
    --     local bufname = vim.api.nvim_buf_get_name(0)
    --     local path = vim.fn.fnamemodify(bufname, ":p")
    --     if path and vim.uv.fs_stat(path) then
    --       require("mini.files").open(bufname, false)
    --     end
    --   end,
    --   silent = true,
    --   desc = "Mini Files",
    -- },
    {
      -- "<C-Q>",
      -- "s",
      "<leader>-",
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.fnamemodify(bufname, ":p")
        if path and vim.uv.fs_stat(path) then
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(bufname, false)
          end
        end
      end,
      silent = true,
      desc = "Mini Files",
    },
    {
      ",,",
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.fnamemodify(bufname, ":p")
        if path and vim.uv.fs_stat(path) then
          require("mini.files").open(bufname, false)
        end
      end,
      silent = true,
      desc = "Mini Files",
    },
  },
  -- init = function()
  --   if vim.fn.argc(-1) == 1 then
  --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
  --     if stat and stat.type == "directory" then
  --       require("mini.files").open()
  --     end
  --   end
  -- end,
  opts = function()
    local copy_path = function()
      local cur_entry_path = require("mini.files").get_fs_entry().path
      vim.fn.setreg("+", cur_entry_path)
      print("Path copied to clipboard!")
    end
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("idr4n/mini-files", { clear = true }),
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "Y", copy_path, { buffer = args.data.buf_id })
      end,
    })
    return {
      mappings = {
        close = "q",
        show_help = "?",
        go_in_plus = "l",
        go_out_plus = "<tab>",
      },
      windows = { width_nofocus = 25 },
    }
  end,
}
