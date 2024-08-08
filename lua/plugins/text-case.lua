return {
  "johmsalas/text-case.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({
      prefix = "gi",
    })
    require("telescope").load_extension("textcase")
  end,
  keys = {
    "gi", -- Default invocation prefix
    { "gi.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
}
