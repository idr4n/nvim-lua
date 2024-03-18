return {
  "gbprod/yanky.nvim",
  -- enabled = false,
  cmd = { "YankyRingHistory", "YankyClearHistory" },
  keys = {
    -- { ",r", "<cmd>YankyRingHistory<cr>", noremap = true, silent = true },
    -- { ",r", "<cmd>Telescope yank_history<cr>", noremap = true, silent = true },
    {
      ",y",
      "<cmd>lua require('telescope').extensions.yank_history.yank_history({ initial_mode = 'normal' })<cr>",
      noremap = true,
      silent = true,
      desc = "Yank history",
    },
  },
  opts = function()
    require("telescope").load_extension("yank_history")
    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")

    return {
      ring = {
        history_length = 50,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 70,
      },
      system_clipboard = {
        sync_with_ring = false,
      },
      picker = {
        telescope = {
          mappings = {
            -- default = mapping.put("p"),
            default = mapping.special_put("YankyPutIndentAfter"),
            i = {
              ["<c-p>"] = mapping.special_put("YankyPutIndentBefore"),
              ["<c-k>"] = nil,
              ["<c-x>"] = mapping.delete(),
              ["<c-r>"] = mapping.set_register(utils.get_default_register()),
            },
            n = {
              p = mapping.special_put("YankyPutIndentAfter"),
              P = mapping.special_put("YankyPutIndentBefore"),
              d = mapping.delete(),
              r = mapping.set_register(utils.get_default_register()),
            },
          },
        },
      },
    }
  end,
}
