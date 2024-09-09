return {
  "lukas-reineke/virt-column.nvim",
  event = "BufReadPost",
  opts = {
    char = { "│" },
    virtcolumn = "80",
    exclude = { filetypes = { "markdown" } },
  },
}
