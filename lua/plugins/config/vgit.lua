local M = {}

M.keys = {
  {
    "<leader>vp",
    function()
      require("vgit").buffer_hunk_preview()
    end,
    desc = "Hunk preview (vgit)",
  },
  {
    "<leader>vd",
    function()
      require("vgit").buffer_diff_preview()
    end,
    desc = "Buffer diff preview (vgit)",
  },
}

M.opts = {
  keymaps = {
    ["n <C-k>"] = function()
      require("vgit").hunk_up()
    end,
    ["n <C-j>"] = function()
      require("vgit").hunk_down()
    end,
    ["n [c"] = function()
      require("vgit").hunk_up()
    end,
    ["n ]c"] = function()
      require("vgit").hunk_down()
    end,
  },
  settings = {
    live_blame = { enabled = false },
    live_gutter = { enabled = false },
    authorship_code_lens = { enabled = false },
    scene = {
      diff_preference = "split",
      keymaps = {
        quit = "q",
      },
    },
    signs = {
      definitions = {
        GitSignsAdd = { text = "▎" },
        GitSignsDelete = { text = "󰍵" },
        GitSignsChange = { text = "▎" },
      },
    },
  },
}

return M
