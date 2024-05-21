return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </
    },
  },
}
