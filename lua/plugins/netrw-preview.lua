return {
  "idr4n/netrw-preview.nvim",
  -- dev = false,
  -- cond = false,
  ft = "netrw",
  cmd = { "NetrwReveal", "NetrwRevealFile" },
  keys = {
    { "-", "<cmd>NetrwRevealToggle<cr>", desc = "Toggle Netrw - Reveal" },
    -- { ",,", "<cmd>NetrwRevealToggle<cr>", desc = "Toggle Netrw - Reveal" },
    -- { ",l", "<cmd>NetrwRevealLexToggle<cr>", desc = "Toggle Netrw (Lex) - Reveal" },
  },
  opts = {
    preview_width = 65,
    -- preview_enabled = true,
    -- preview_side = "above",
    -- preview_height = 40,
    -- preview_layout = "horizontal",
    mappings = {
      close_netrw = { "q", "gq", "<c-q>" },
      toggle_preview = { "p", "<Tab>" },
      directory_mappings = {
        { key = "~", path = "~", desc = "Home directory" },
        { key = "gd", path = "~/Downloads", desc = "Downloads directory" },
        { key = "gc", path = "~/.config/nvim", desc = "Nvim config directory" },
        -- { key = "gs", path = "../../src", desc = "Source directory" },
        {
          key = "gw",
          path = function()
            return vim.fn.getcwd()
          end,
          desc = "Current working directory",
        },
      },
    },
  },
}
