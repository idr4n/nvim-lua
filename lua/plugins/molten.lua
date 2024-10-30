return {
  {
    "benlubas/molten-nvim",
    -- dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    keys = { { "<localleader>mi", ":MoltenInit<cr>", desc = "Molten - init kernel" } },
    config = function()
      vim.g.molten_use_border_highlights = true
      -- add a few new things
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_image_provider = "none"
      -- vim.g.molten_virt_text_output = true
      vim.g.molten_virt_text_max_lines = 50
      vim.g.molten_use_border_highlights = true

      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<localleader>me", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>")
      vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<localleader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<localleader>mo", ":noautocmd MoltenEnterOutput<CR>")
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>")
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
    end,
  },

  {
    "3rd/image.nvim",
    -- enabled = false,
    ft = { "quarto", "markdown" },
    init = function()
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
    end,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
        },
      },
      max_width = 100,
      max_height = 20,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      kitty_method = "normal",
      window_overlap_clear_enabled = false,
      editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
