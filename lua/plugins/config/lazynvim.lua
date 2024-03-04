return {
  -- spec = {
  --     { import = "plugins" },
  -- },
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight" } },
  --
  change_detection = {
    enabled = true,
    notify = false,
  },
  -- dev = { path = "~/other_repos", patterns = { "idr4n" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
}
