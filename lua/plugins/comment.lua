return {
  "numToStr/Comment.nvim",
  -- event = { "BufReadPost", "BufNewFile" },
  event = "VeryLazy",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  -- opts = {
  --     pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  -- },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
