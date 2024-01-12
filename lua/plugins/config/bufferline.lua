return {
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
        local hl_separator_bg = { bg = { attribute = "bg", highlight = "StatusLine" } }
        local hl_separator_fg = { fg = { attribute = "bg", highlight = "StatusLine" } }
        -- local hl_separator_fg = { fg = "#1E2030" }
        -- local hl_separator_bg = { bg = "#1E2030" }
        return {
            highlights = {
                separator = hl_separator_fg,
                tab_separator = hl_separator_fg,
                tab_separator_selected = hl_separator_fg,
                separator_selected = hl_separator_fg,
                separator_visible = hl_separator_fg,
                fill = hl_separator_bg,
            },
            options = {
                buffer_close_icon = "",
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    -- local ret = diag.error and (" " .. diag.error)
                    --     or (diag.warning and (" " .. diag.warning))
                    --     or diag.hint and (" " .. diag.hint)
                    local icons = require("util").diagnostic_icons
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
                separator_style = "slant", -- slope is also nice
            },
        }
    end,
    config = function(_, opts)
        require("bufferline").setup(opts)
    end,
}
