return {
  "dnlhc/glance.nvim",
  -- "idr4n/glance.nvim",
  keys = {
    { "<leader>gg", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
    -- { "gr", "<CMD>Glance references<CR>", desc = "LSP references (Glance)" },
    { "<leader>gr", "<CMD>Glance references<CR>", desc = "Glance references" },
    { "<leader>lr", "<CMD>Glance references<CR>", desc = "LSP references" },
    { "<leader>gd", "<CMD>Glance type_definitions<CR>", desc = "Glance type definitions" },
    { "<leader>gm", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
  },
  opts = {
    border = { enable = true, top_char = "─", bottom_char = "─" },
  },
}
