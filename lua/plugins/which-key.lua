return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- keys = { "<leader>", "<c-r>", "<c-w>", "z", '"', "'", "`", "c", "v", "g", ",", ";" },
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
        l = { name = "LSP" },
        o = { name = "open" },
        n = { name = "Neotree/Tdo" },
        ["nd"] = { name = "Tdo with offset" },
        q = { name = "Quit" },
        s = { name = "Search/Spectre" },
        t = { name = "toggle" },
        v = { name = "vgit/diffview" },
        z = { name = "Trouble/Misc" },
        ["<tab>"] = { name = "Tabs" },
        ["tb"] = "Blame current line",
      },
    }
    local keymaps_v = {
      ["<leader>"] = {
        d = { name = "debug" },
        h = { name = "Gitsings" },
        l = { name = "LSP" },
        s = { name = "Search/Spectre" },
      },
    }
    wk.register(keymaps_n)
    wk.register(keymaps_v, { mode = "v" })
  end,
}