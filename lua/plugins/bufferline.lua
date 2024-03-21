return {
  "akinsho/bufferline.nvim",
  -- enabled = false,
  event = "BufReadPost",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = function()
    local bufferline = require("bufferline")
    return {
      highlights = {
        fill = { bg = { attribute = "bg", highlight = "StatusLine" } },
        background = { bg = { attribute = "bg", highlight = "StatusLine" } },
        close_button = { bg = { attribute = "bg", highlight = "StatusLine" } },
        offset_separator = { bg = { attribute = "bg", highlight = "StatusLine" } },
        trunc_marker = { bg = { attribute = "bg", highlight = "StatusLine" } },
        duplicate = { bg = { attribute = "bg", highlight = "StatusLine" } },
        close_button_selected = { fg = "#B55A67" },
        separator = { bg = { attribute = "bg", highlight = "StatusLine" } },
        modified = { fg = "#B55A67", bg = { attribute = "bg", highlight = "StatusLine" } },
        hint = { bg = { attribute = "bg", highlight = "StatusLine" } },
        hint_diagnostic = { bg = { attribute = "bg", highlight = "StatusLine" } },
        info = { bg = { attribute = "bg", highlight = "StatusLine" } },
        info_diagnostic = { bg = { attribute = "bg", highlight = "StatusLine" } },
        warning = { bg = { attribute = "bg", highlight = "StatusLine" } },
        warning_diagnostic = { bg = { attribute = "bg", highlight = "StatusLine" } },
        error = { bg = { attribute = "bg", highlight = "StatusLine" } },
        error_diagnostic = { bg = { attribute = "bg", highlight = "StatusLine" } },
      },
      options = {
        buffer_close_icon = "",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        indicator = {
          -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "none", -- "icon" | "underline" | "none",
        },
        diagnostics_indicator = function(_, _, diag)
          local icons = require("utils").diagnostic_icons
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning .. " " or "")
            .. (diag.info and icons.Info .. diag.info .. " " or "")
            .. (diag.hint and icons.Hint .. diag.hint or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "center",
          },
        },
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        -- separator_style = "slope", -- slant or slope is also nice
      },
    }
  end,
  -- config = function(_, opts)
  --   require("bufferline").setup(opts)
  --   -- Fix bufferline when restoring a session
  --   vim.api.nvim_create_autocmd("BufAdd", {
  --     callback = function()
  --       vim.schedule(function()
  --         pcall(nvim_bufferline)
  --       end)
  --     end,
  --   })
  -- end,
}
