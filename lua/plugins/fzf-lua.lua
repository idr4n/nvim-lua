return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = function()
    _G.fzflua_theme = function(opts)
      opts = vim.tbl_deep_extend("force", {
        winopts = {
          row = 0.5,
          preview = {
            layout = "horizontal",
            horizontal = "right:50%",
            scrollbar = false,
          },
          width = math.min(126 / vim.o.columns, 0.82),
          height = math.min(36 / vim.o.lines, 0.8),
        },
        previewers = { builtin = { toggle_behavior = "default" } },
      }, opts or {})
      return require("telescope.themes").get_dropdown(opts)
    end

    return {
      {
        "<leader>or",
        "<cmd>lua require('fzf-lua').resume()<CR>",
        silent = true,
        desc = "Fzf-Lua Resume",
      },
      -- { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files - FzfLua" },
      -- { "<C-Space>", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files - FzfLua" },
      -- { "<leader>r", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live Grep" },
      { "<leader>r", "<cmd>FzfLua grep_project<cr>", desc = "Grep Project" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep Project" },
      {
        "<leader>r",
        function()
          require("fzf-lua").grep_visual()
        end,
        mode = "v",
        silent = true,
        desc = "Grep",
      },
      -- { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Grep buffer" },
      {
        "<leader>sb",
        function()
          local text = vim.getVisualSelection()
          require("fzf-lua").grep_curbuf({ query = text })
        end,
        mode = { "n", "v" },
        desc = "Grep buffer",
      },
      -- {
      --   "<leader>sh",
      --   function()
      --     require("fzf-lua").help_tags(fzflua_theme())
      --   end,
      --   desc = "Help tags",
      -- },
      -- {
      --   "<leader>sh",
      --   function()
      --     local text = vim.getVisualSelection()
      --     require("fzf-lua").help_tags(fzflua_theme({ query = text }))
      --   end,
      --   mode = "v",
      --   silent = true,
      --   desc = "Help tags",
      -- },
      {
        "<leader>fh",
        ":lua require('fzf-lua').help_tags({query = vim.fn.expand('<cword>')})<CR>",
        silent = true,
        desc = "Help current word",
      },
      -- {
      --   "<leader>fr",
      --   function()
      --     -- Read from ShaDa to include files that were already deleted from the buffer list.
      --     vim.cmd("rshada!")
      --     require("fzf-lua").oldfiles()
      --   end,
      --   silent = true,
      --   desc = "Recently opened files",
      -- },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key maps" },
      { "gd", "<cmd>FzfLua lsp_definitions<cr>", silent = true, desc = "Go to LSP definition" },
      {
        "<leader>ls",
        function()
          require("fzf-lua").lsp_document_symbols(fzflua_theme())
        end,
        silent = true,
        desc = "LSP document symbols (FzfLua)",
      },
      -- { "<leader>zx", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "FzfLua - Diagnostics Project" },
      -- {
      --   "<leader>lS",
      --   function()
      --     require("fzf-lua").lsp_live_workspace_symbols(fzflua_theme())
      --     -- Disable the grep switch header.
      --     -- require("fzf-lua").lsp_live_workspace_symbols(fzflua_theme({ no_header_i = true }))
      --   end,
      --   silent = true,
      --   desc = "LSP workspace symbols (FzfLua)",
      -- },
      {
        "<leader>gs",
        -- "<cmd>FzfLua git_status<cr>",
        function()
          require("fzf-lua").git_status(fzflua_theme())
        end,
        silent = true,
        desc = "Git Status",
      },
    }
  end,
  opts = function()
    vim.api.nvim_set_hl(0, "FZFLuaBorder", { fg = "#9D7CD8" })
    return {
      winopts = {
        backdrop = 100,
        row = 0,
        preview = {
          vertical = "up:41%",
          layout = "vertical",
          scrollbar = false,
        },
        width = math.min(126 / vim.o.columns, 0.82),
        height = math.min(36 / vim.o.lines, 0.8),
      },
      previewers = { builtin = { toggle_behavior = "extend" } },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "inline-right",
      },
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Comment" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["border"] = { "fg", "FZFLuaBorder" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bg", "Normal" },
      },
      files = {
        cmd = "rg --files --hidden --follow --no-ignore -g '!{node_modules,.zig-cache,.git,**/_build,deps,.elixir_ls,**/__pycache__,**/.DS_Store,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'",
        -- cmd = "rg --files",
        prompt = "  ",
        winopts = {
          preview = { hidden = "hidden" },
        },
        _fzf_nth_devicons = false,
        no_header_i = true,
      },
      grep = {
        rg_opts = "--hidden --column --follow --line-number --no-heading "
          .. "--color=always --smart-case -g '!{node_modules,.zig-cache,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out,**/__pycache__,**/.DS_Store}'",
      },
      oldfiles = {
        include_current_session = true,
        winopts = {
          preview = { hidden = "hidden" },
        },
      },
      blines = { prompt = "  " },
      keymap = {
        builtin = {
          ["<C-L>"] = "toggle-preview",
          ["<C-D>"] = "preview-page-down",
          ["<C-U>"] = "preview-page-up",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-l"] = "toggle-preview",
          ["ctrl-q"] = "select-all+accept", -- send all to quick list
          ["ctrl-f"] = "select-all+accept", -- send all to quick list
        },
      },
    }
  end,
}
