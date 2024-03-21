return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>or",
      "<cmd>lua require('fzf-lua').resume()<CR>",
      silent = true,
      desc = "Fzf-Lua Resume",
    },
    -- { "<leader><Space>", "<cmd>lua require('fzf-lua').files()<CR>" },
    { "<C-P>", "<cmd>FzfLua files<cr>", desc = "Find files" },
    -- { "<leader>r", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live Grep" },
    { "<leader>r", "<cmd>FzfLua grep_project<cr>", desc = "Grep Project" },
    {
      "<leader>fw",
      -- ":lua require('fzf-lua').live_grep_glob({query = vim.fn.expand('<cword>')})<CR>",
      ":lua require('fzf-lua').grep_cword()<CR>",
      silent = true,
      desc = "Grep current word",
    },
    {
      "<leader>r",
      function()
        -- local text = vim.getVisualSelection()
        -- require("fzf-lua").live_grep_glob({ query = text })
        require("fzf-lua").grep_visual()
      end,
      mode = "v",
      silent = true,
      desc = "Live Grep",
    },
    -- { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
    -- {
    --   "<leader>sh",
    --   function()
    --     local text = vim.getVisualSelection()
    --     require("fzf-lua").help_tags({ query = text })
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
    {
      "<leader>fr",
      function()
        -- Read from ShaDa to include files that were already deleted from the buffer list.
        vim.cmd("rshada!")
        require("fzf-lua").oldfiles()
      end,
      silent = true,
      desc = "Recently opened files",
    },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key maps" },
    {
      "gd",
      function()
        require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
      end,
      silent = true,
      desc = "Go to LSP definition",
    },
    {
      "gD",
      "<cmd>FzfLua lsp_definitions<cr>",
      silent = true,
      desc = "Peek definition",
    },
    {
      "<leader>ls",
      "<cmd>FzfLua lsp_document_symbols<cr>",
      silent = true,
      desc = "LSP document symbols",
    },
    {
      "<leader>lS",
      function()
        -- Disable the grep switch header.
        require("fzf-lua").lsp_live_workspace_symbols({ no_header_i = true })
      end,
      silent = true,
      desc = "LSP workspace symbols",
    },
    {
      "<leader>gs",
      "<cmd>FzfLua git_status<cr>",
      silent = true,
      desc = "Git Status",
    },
  },
  opts = function()
    vim.api.nvim_set_hl(0, "FZFLuaBorder", { fg = "#9D7CD8" })
    return {
      winopts = {
        -- height = 0.45,
        -- width = 1,
        -- row = 1,
        -- border = { "─", "─", "─", " ", "", "", "", " " },
        -- height = 0.7,
        -- width = 0.55,
        preview = {
          -- vertical = "up:40%",
          -- horizontal = "right:54%",
          -- flip_columns = 120,
          -- delay = 60,
          -- hidden = "hidden",
          vertical = "up:40%",
          layout = "vertical",
          scrollbar = false,
        },
      },
      winopts_fn = function()
        -- smaller width if neovim win has over 80 columns
        local max_width = 100 / vim.o.columns
        local max_height = 40 / vim.o.lines
        -- return { width = vim.o.columns > 140 and max_width or 1 }
        return {
          width = math.min(max_width, 0.7),
          height = math.min(max_height, 0.7),
        }
      end,
      fzf_opts = {
        -- ["--layout"] = "default",
        -- ["--layout"] = "reverse",
        ["--info"] = "default",
        ["--layout"] = "reverse-list",
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
        cmd = "rg --files --hidden --follow --no-ignore -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'",
        prompt = "  ",
        winopts = {
          preview = { hidden = "hidden" },
        },
        _fzf_nth_devicons = false,
      },
      grep = {
        rg_opts = "--hidden --column --follow --line-number --no-heading "
          .. "--color=always --smart-case -g '!{node_modules,.git,**/_build,deps,.elixir_ls,**/target,**/assets/node_modules,**/assets/vendor,**/.next,**/.vercel,**/build,**/out}'",
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
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-l"] = "toggle-preview",
          ["ctrl-q"] = "select-all+accept", -- send all to quick list
        },
      },
    }
  end,
}
