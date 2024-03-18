return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
    -- stylua: ignore
    keys = {
        { "zR", function() require("ufo").openAllFolds() end, },
        { "zM", function() require("ufo").closeAllFolds() end, },
        { "z1", function() require("ufo").closeFoldsWith(1) end, },
        { "z2", function() require("ufo").closeFoldsWith(2) end, },
    },
  config = function()
    -- vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    local ftMap = {
      markdown = "",
      vue = "lsp",
    }
    require("ufo").setup({
      open_fold_hl_timeout = 0,
      -- close_fold_kinds = { "imports", "regions", "comments" },
      provider_selector = function(bufnr, filetype, buftype)
        -- return { "treesitter", "indent" }
        return ftMap[filetype] or { "treesitter", "indent" }
      end,
    })
  end,
}
