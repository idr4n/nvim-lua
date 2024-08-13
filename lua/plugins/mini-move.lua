-- Moving selections.
return {
  {
    "echasnovski/mini.move",
    -- event = "VeryLazy",
    keys = {
      { "<M-down>", mode = { "n", "v" } },
      { "<M-up>", mode = { "n", "v" } },
      { "<M-left>", mode = { "n", "v" } },
      { "<M-right>", mode = { "n", "v" } },
    },
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-left>",
        right = "<M-right>",
        down = "<M-down>",
        up = "<M-up>",

        -- Move current line in Normal mode
        line_left = "<M-left>",
        line_right = "<M-right>",
        line_down = "<M-down>",
        line_up = "<M-up>",
      },
    },
    config = true,
  },
}
