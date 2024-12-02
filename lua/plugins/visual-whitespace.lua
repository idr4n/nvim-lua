return {
  "mcauley-penney/visual-whitespace.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ws_bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Visual" }).bg)
    local ws_fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Comment" }).fg)

    require("visual-whitespace").setup({
      highlight = { bg = ws_bg, fg = ws_fg },
      nl_char = "¬",
      excluded = {
        filetypes = { "aerial" },
        buftypes = { "help" },
      },
    })

    vim.keymap.set("n", "<leader>vw", require("visual-whitespace").toggle, {})
  end,
}
