return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante", "codecompanion", "copilot-chat" },
  opts = {
    file_types = { "markdown", "Avante", "codecompanion", "copilot-chat" },
    bullet = {
      icons = { "•", "◦", "▪", "▫" },
      -- right_pad = 1,
    },
    latex = { enabled = false },
  },
  config = function(_, opts)
    local bg_color = vim.api.nvim_get_hl(0, { name = "RenderMarkdownH6Bg" }).bg or "#272538"
    local fg_color = vim.api.nvim_get_hl(0, { name = "RenderMarkdownH6Fg" }).fg or "#9D7CD8"

    -- Setup hashtag syntax highlighting specifically for markdown files
    local augroup = vim.api.nvim_create_augroup("MarkdownHashTag", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
      group = augroup,
      pattern = "*.md",
      callback = function()
        if vim.bo.filetype == "markdown" then
          pcall(function()
            vim.api.nvim_set_hl(0, "HashTag", { bg = bg_color, fg = fg_color, bold = true })
          end)

          -- Pattern that only matches standalone hashtags. This avoids things like variable#property
          vim.cmd([[syntax match HashTag /\(^\|\s\)\@<=#\w\+/ contains=@NoSpell containedin=ALL]])
        end
      end,
    })

    require("render-markdown").setup(opts)
  end,
}
