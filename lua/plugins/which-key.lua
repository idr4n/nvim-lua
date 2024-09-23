return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- keys = { "<leader>", "<c-r>", "<c-w>", "z", '"', "'", "`", "c", "v", "g", ",", ";" },
  opts = {
    -- preset = "modern",
    -- preset = "helix",
    notify = false,
    icons = {
      rules = false,
      separator = "",
    },
    win = {
      -- no_overlap = false,
      -- width = { max = 0.28 },
      height = { min = 4, max = 20 },
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup(opts)
    local keymaps_n = {
      ["gc"] = { name = "comment" },
      ["<leader>"] = {
        b = { name = "buffer" },
        c = { name = "coding" },
        d = { name = "debug" },
        f = { name = "file" },
        g = { name = "Git/Glance" },
        h = { name = "Gitsings/Harpoon" },
        j = { name = "AI" },
        l = { name = "LSP" },
        m = { name = "Markdown" },
        o = { name = "open" },
        n = { name = "N-Tree/Noice/Tdo" },
        ["nd"] = { name = "Tdo with offset" },
        q = { name = "Quit" },
        s = { name = "Search/Replace" },
        t = { name = "toggle" },
        v = { name = "vgit/diffview" },
        z = { name = "Trouble/Misc" },
        ["<tab>"] = { name = "Tabs" },
        ["tb"] = "Blame current line",
      },
    }
    local keymaps_v = {
      ["<leader>"] = {
        c = { name = "coding" },
        d = { name = "debug" },
        h = { name = "Gitsings" },
        j = { name = "AI" },
        l = { name = "LSP" },
        o = { name = "open" },
        s = { name = "Search/Replace" },
      },
    }
    wk.register(keymaps_n)
    wk.register(keymaps_v, { mode = "v" })
  end,
}
