return {
  "voldikss/vim-floaterm",
  -- stylua: ignore
  keys = {
    { ",l", ":FloatermNew --title=LF --titleposition=center lf<cr>", silent = true, desc = "Open LF" },
    { ",j", ":FloatermNew --title=Joshuto --titleposition=center joshuto<cr>", silent = true, desc = "Open Joshuto" },
    { ",y", ":FloatermNew --title=Yazi --titleposition=center yazi --cwd-file ~/.cache/yazi/last_dir '%'<cr>", silent = true, desc = "Open Yazi" },
    { "<leader>ff", ":FloatermNew --title=Yazi --titleposition=center yazi --cwd-file ~/.cache/yazi/last_dir '%'<cr>", silent = true, desc = "Open Yazi" },
    { "<leader>j", ":FloatermNew --title=Joshuto --titleposition=center joshuto<cr>", silent = true, desc = "Open Joshuto", },
  },
  config = function()
    local function calcFloatSize()
      return {
        width = math.min(math.ceil(vim.fn.winwidth(0) * 0.97), 180),
        height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 45),
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
