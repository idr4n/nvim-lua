return {
  "bassamsdata/namu.nvim",
  keys = {
    {
      "gs",
      function()
        require("namu.namu_symbols").show()
      end,
    },
  },
  config = function()
    require("namu").setup({
      namu_symbols = {
        enable = true,
        options = {
          AllowKinds = {
            python = { "Function", "Class", "Method", "Constant", "Variable" },
            lua = { "Function", "Method", "Table", "Module", "Object" },
          },
        },
      },
    })
  end,
}
