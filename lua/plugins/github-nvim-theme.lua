return {
  "projekt0n/github-nvim-theme",
  lazy = true,
  config = function()
    require("github-theme").setup({
      options = {
        darken = {
          floats = false,
          sidebars = {
            enabled = true,
            list = { "qf", "netrw", "neotree" }, -- default is {}
          },
        },
      },
    })
  end,
}
