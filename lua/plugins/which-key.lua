return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- keys = { "<leader>", "<c-r>", "<c-w>", "z", '"', "'", "`", "c", "v", "g", ",", ";" },
  opts = {
    -- preset = "modern",
    -- preset = "helix",
    notify = false,
    -- icons = {
    --   rules = false,
    --   separator = "",
    -- },
    icons = {
      rules = false,
      breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
      separator = "󱦰  ", -- symbol used between a key and it's label
      group = "󰹍 ", -- symbol prepended to a group
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
        f = { name = "file/fold" },
        g = { name = "Git/Glance" },
        h = { name = "Gitsings/Harpoon" },
        j = { name = "AI" },
        l = { name = "LSP" },
        m = { name = "Markdown/Typst" },
        o = { name = "open" },
        n = { name = "N-Tree/Noice/Notes" },
        p = { name = "Misc" },
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
