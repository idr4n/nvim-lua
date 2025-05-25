return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- Build issue discussed here: https://github.com/iamcco/markdown-preview.nvim/issues/690
  build = ":call mkdp#util#install()",
  keys = {
    { "<leader>mp", ":MarkdownPreviewToggle<cr>", desc = "MarkdownPreview Toggle" },
  },
  config = function()
    -- vim.g.mkdp_browser = "Vivaldi"
    vim.g.mkdp_highlight_css = vim.fn.expand("~/md-preview.css")
  end,
}
