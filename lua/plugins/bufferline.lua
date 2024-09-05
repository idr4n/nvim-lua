return {
  "akinsho/bufferline.nvim",
  -- enabled = false,
  -- event = { "BufReadPost", "BufNewFile" },
  event = "VimEnter",
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
    local fill_hl = "CursorLine"
    return {
      highlights = {
        fill = { bg = { attribute = "bg", highlight = fill_hl } },
        background = { bg = { attribute = "bg", highlight = fill_hl } },
        close_button = { bg = { attribute = "bg", highlight = fill_hl } },
        offset_separator = { bg = { attribute = "bg", highlight = fill_hl } },
        trunc_marker = { bg = { attribute = "bg", highlight = fill_hl } },
        duplicate = { bg = { attribute = "bg", highlight = fill_hl } },
        close_button_selected = { fg = "#B55A67" },
        separator = { bg = { attribute = "bg", highlight = fill_hl } },
        modified = { fg = "#B55A67", bg = { attribute = "bg", highlight = fill_hl } },
        hint = { bg = { attribute = "bg", highlight = fill_hl } },
        hint_diagnostic = { bg = { attribute = "bg", highlight = fill_hl } },
        info = { bg = { attribute = "bg", highlight = fill_hl } },
        info_diagnostic = { bg = { attribute = "bg", highlight = fill_hl } },
        warning = { bg = { attribute = "bg", highlight = fill_hl } },
        warning_diagnostic = { bg = { attribute = "bg", highlight = fill_hl } },
        error = { bg = { attribute = "bg", highlight = fill_hl } },
        error_diagnostic = { bg = { attribute = "bg", highlight = fill_hl } },
      },
      options = {
        -- show_buffer_close_icons = false,
        buffer_close_icon = "",
        modified_icon = "",
        -- diagnostics = "nvim_lsp",
        diagnostics = false,
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
          {
            filetype = "NvimTree",
            -- text = "Nvim-tree",
            -- highlight = "FileExplorerHl",
            highlight = "NvimTreeNormal",
            -- text_align = "center",
            separator = false,
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
