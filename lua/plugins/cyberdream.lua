return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- variant = "auto",
    -- cache = true,

    overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
      return {
        Substitute = { bg = colors.magenta },
        IlluminatedWordText = { bg = colors.bg_highlight },
        IlluminatedWordRead = { bg = colors.bg_highlight },
        IlluminatedWordWrite = { bg = colors.bg_highlight },
        Visual = { bg = "#511E4C" },
        NonText = { fg = colors.bg_alt },
        WhichKeyNormal = { bg = "#111314" },
        -- Visual = { bg = "#1D4162" },
        -- IlluminatedWordRead = { underline = true, sp = colors.green },
        -- IlluminatedWordWrite = { underline = true, sp = colors.magenta },
      }
    end,
  },
}
