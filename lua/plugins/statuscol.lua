return {
  "luukvbaal/statuscol.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  -- branch = "0.10",
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      -- relculright = true,
      ft_ignore = { "toggleterm", "neogitstatus" },
      bt_ignore = { "terminal" },
      segments = {
        -- { text = { builtin.foldfunc, "" }, click = "v:lua.ScFa" },
        -- { text = { "%s" }, click = "v:lua.ScSa" },
        { sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
        { sign = { name = { "Dap*" }, auto = true }, click = "v:lua.ScSa" },
        {
          -- text = { "", builtin.lnumfunc, "   " },
          text = { "", builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        -- { text = { "%s" }, click = "v:lua.ScSa" },
        -- { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
        { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)
  end,
}
