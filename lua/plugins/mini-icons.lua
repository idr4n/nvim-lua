return {
  "echasnovski/mini.icons",
  -- enabled = false,
  lazy = true,
  opts = function()
    vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#28A2D4" })
    return {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        README = { glyph = "󱗖", hl = "MiniIconsYellow" },
        ["README.md"] = { glyph = "󱗖", hl = "MiniIconsYellow" },
        ["README.txt"] = { glyph = "󱗖", hl = "MiniIconsYellow" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
      -- extension = {
      --   lua = { glyph = "󰢱", hl = "MiniIconsCyan" },
      -- },
    }
  end,
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
