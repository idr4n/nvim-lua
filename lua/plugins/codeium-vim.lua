return {
  "Exafunction/codeium.vim",
  -- enabled = false,
  cmd = { "CodeiumEnable", "CodeiumDisable", "CodeiumToggle" },
  -- stylua: ignore
  keys = {
    {
      "<leader>cx",
      function()
        vim.cmd("CodeiumEnable")
        vim.cmd("redrawstatus!")
      end,
      silent = true,
      desc = "Codeium Enable",
    },
    {
      "<leader>cX",
      function()
        vim.cmd("CodeiumDisable")
        vim.cmd("redrawstatus!")
      end,
      silent = true,
      desc = "Codeium Disable",
    },
    { "<C-c>", function() return vim.fn["codeium#Accept"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Accept" },
    { "<C-n>", function() return vim.fn["codeium#CycleCompletions"](1) end, mode = "i", expr = true, silent = true, desc = "Codeium Next" },
    { "<C-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, mode = "i", expr = true, silent = true, desc = "Codeium Prev" },
    { "<C-]>", function() return vim.fn["codeium#Clear"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Clear" },
    { "<M-\\>", function() return vim.fn["codeium#Complete"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Complete" },
  },
  init = function()
    vim.g.codeium_disable_bindings = 1
    -- vim.g.codeium_manual = true
  end,
}
