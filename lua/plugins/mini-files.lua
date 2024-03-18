return {
  "echasnovski/mini.files",
  keys = {
    { "-", ":lua require('mini.files').open()<cr>", desc = "Mini Files" },
    {
      "<C-Q>",
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.fnamemodify(bufname, ":p")
        -- Noop if the buffer isn't valid.
        if path and vim.uv.fs_stat(path) then
          require("mini.files").open(bufname, false)
        end
      end,
      desc = "Mini Files",
    },
    -- { "<leader>m", ":lua require('mini.files').open()<cr>", desc = "Mini Files" },
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("mini.files").open()
      end
    end
  end,
  opts = {
    mappings = {
      show_help = "?",
      go_in_plus = "<cr>",
      go_out_plus = "<tab>",
    },
    windows = { width_nofocus = 25 },
  },
}
