return {
  "altermo/ultimate-autopair.nvim",
  enabled = false,
  -- event = { "InsertEnter", "CmdlineEnter" },
  event = "VeryLazy",
  branch = "v0.6", --recommended as each new version will have breaking changes
  opts = {
    --Config goes here
    tabout = { enable = true, map = "<C-\\>", cmap = "<C-\\>", hopout = true },
  },
}
