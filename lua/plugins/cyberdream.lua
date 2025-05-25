return {
  "scottmckendry/cyberdream.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    -- variant = "auto",
    -- cache = true,
    terminal_colors = false,

    colors = {
      bg = "#000000",
    },

    overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
      local bg_light = "#2B2F34"
      return {
        Substitute = { bg = colors.magenta },
        IlluminatedWordText = { bg = bg_light },
        IlluminatedWordRead = { bg = bg_light },
        IlluminatedWordWrite = { bg = bg_light },
        NonText = { fg = colors.bg_alt },
        WhichKeyNormal = { bg = "#111314" },
        ["@keyword.type"] = { fg = colors.orange, italic = false },
      }
    end,
  },
}
