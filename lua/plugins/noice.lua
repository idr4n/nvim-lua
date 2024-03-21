return {
  "folke/noice.nvim",
  enabled = false,
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true },
      signature = { enabled = true },
      progress = { enabled = true },
    },
    cmdline = {
      opts = {
        -- border = { style = "none", padding = { 0, 1 } },
        border = { style = "none", padding = { 0, 0 } },
      },
    },
    -- -- if want to position cmdline and search popup in the top instead
    views = {
      cmdline_popup = {
        -- position = { row = "99%", col = "50%" },
        -- size = { width = "100%" },
        position = { row = "100%", col = "0%" },
        size = { width = "40%" },
      },
    },
    popupmenu = { backend = "cmp" },
    presets = {
      -- bottom_search = true,
      command_palette = true,
      inc_rename = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
