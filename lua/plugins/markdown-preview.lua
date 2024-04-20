return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    -- vim.g.mkdp_browser = "Vivaldi"
    vim.g.mkdp_highlight_css = vim.fn.expand("~/md-preview.css")
  end,
}
