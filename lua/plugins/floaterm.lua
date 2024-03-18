return {
  "voldikss/vim-floaterm",
  keys = {
    { ",l", ":FloatermNew --title=LF --titleposition=center lf<cr>", desc = "Open LF" },
    { ",j", ":FloatermNew --title=Joshuto --titleposition=center joshuto<cr>", desc = "Open Joshuto" },
    { "<leader>j", ":FloatermNew --title=Joshuto --titleposition=center joshuto<cr>", desc = "Open Joshuto" },
  },
  config = function()
    local function calcFloatSize()
      return {
        width = math.min(math.ceil(vim.fn.winwidth(0) * 0.93), 200),
        height = math.min(math.ceil(vim.fn.winheight(0) * 0.85), 40),
      }
    end

    local function recalcFloatermSize()
      vim.g.floaterm_width = calcFloatSize().width
      vim.g.floaterm_height = calcFloatSize().height
    end

    vim.api.nvim_create_augroup("floaterm", { clear = true })
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = { "*" },
      callback = recalcFloatermSize,
      group = "floaterm",
    })

    vim.g.floaterm_width = calcFloatSize().width
    vim.g.floaterm_height = calcFloatSize().height
    vim.g.floaterm_opener = "edit"
  end,
}
