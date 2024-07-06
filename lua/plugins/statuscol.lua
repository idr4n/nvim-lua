return {
  "luukvbaal/statuscol.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      -- relculright = true,
      ft_ignore = { "toggleterm", "neogitstatus", "NvimTree" },
      bt_ignore = { "terminal" },
      segments = {
        { sign = { namespace = { "diagnostic/signs" }, name = { "Dap*" } }, click = "v:lua.ScSa" },
        {
          text = { "", builtin.lnumfunc, "" },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        { text = { builtin.foldfunc, auto = false }, click = "v:lua.ScFa" },
        { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)
  end,
}
