local colored_fts = {
  "cfg",
  "css",
  "html",
  "conf",
  "lua",
  "scss",
  "toml",
  "markdown",
}

return {
  "NvChad/nvim-colorizer.lua",
  -- enabled = false,
  -- event = "BufReadPost",
  -- event = "VeryLazy",
  ft = colored_fts,
  keys = {
    { ",c", "<cmd>ColorizerToggle<cr>", silent = true, desc = "Toggle colorizer" },
  },
  opts = {
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      tailwind = "lsp",
      -- Available modes: foreground, background
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      -- mode = "virtualtext", -- Set the display mode.
      virtualtext = "■",
    },
  },
}
