return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    -- redefine gitsigns colors
    -- local linenr_hl = vim.api.nvim_get_hl(0, { name = "LineNr" })
    -- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#73DACA", bg = linenr_hl.background })
    -- vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FF9E64", bg = linenr_hl.background })
    -- vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F7768E", bg = linenr_hl.background })
    -- vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#BD73EC", bg = linenr_hl.background })

    return {
      signcolumn = true,
      -- _extmark_signs = false,
      numhl = false,
      signs = { change = { text = "┋" } },
      signs_staged = { change = { text = "┋" } },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "Diff this (~ last commit)" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    }
  end,
}
