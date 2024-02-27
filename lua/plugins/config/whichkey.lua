return {
  keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", ",", ";" },
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
        n = { name = "Neotree/Noice" },
        q = { name = "Quit" },
        s = { name = "Search" },
        t = { name = "toggle" },
        v = { name = "vgit/diffview" },
        z = { name = "Trouble/Misc" },
        ["<tab>"] = { name = "Tabs" },
        ["tb"] = "Blame current line",
      },
    }
    local keymaps_v = {
      ["<leader>"] = {
        h = { name = "Gitsings" },
        l = { name = "LSP" },
        o = { name = "open" },
      },
    }
    wk.register(keymaps_n)
    wk.register(keymaps_v, { mode = "v" })
  end,
}
