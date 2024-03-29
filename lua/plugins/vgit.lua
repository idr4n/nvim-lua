return {
  "tanvirtin/vgit.nvim",
  -- enabled = false,
  -- dev = true,
  -- event = "BufReadPre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
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
  },
  opts = {
    keymaps = {
      ["n [c"] = "hunk_up",
      ["n ]c"] = "hunk_down",
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
          -- GitSignsAdd = { text = "│" },
          GitSignsDelete = { text = "󰍵" },
          GitSignsChange = { text = "▎" },
          -- GitSignsChange = { text = "│" },
        },
      },
    },
  },
}
