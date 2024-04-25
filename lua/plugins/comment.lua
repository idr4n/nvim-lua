return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    pre_hook = function()
      return vim.bo.commentstring
    end,
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
