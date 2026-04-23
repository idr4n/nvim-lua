return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSLog" },
    config = function()
      require("nvim-treesitter").setup({
        -- optional: where parsers get installed
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local ensure_installed = {
        "bash",
        "cpp",
        "css",
        "elixir",
        "gleam",
        "go",
        "heex",
        "html",
        "java",
        "javascript",
        "json",
        "julia",
        "latex",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "nu",
        "python",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "typst",
        "scss",
        "svelte",
        "swift",
        "vim",
        "vimdoc",
        "vue",
        "zig",
      }

      -- Install parsers asynchronously on startup
      require("nvim-treesitter").install(ensure_installed)

      -- Enable highlight + indent per filetype
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          -- Map filetype -> parser language if they differ
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end
          -- Only start if parser is available
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end
          -- Indent via treesitter
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          -- Folds (optional)
          -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.wo.foldmethod = "expr"
        end,
      })
    end,
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
  },

  -- Textobjects: also on `main`, also rewritten
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        -- move / swap submodules also exist; see :h nvim-treesitter-textobjects
      })

      local map = vim.keymap.set
      local ts_select = require("nvim-treesitter-textobjects.select").select_textobject

      map({ "x", "o" }, "af", function()
        ts_select("@function.outer", "textobjects")
      end, { desc = "outer function" })
      map({ "x", "o" }, "if", function()
        ts_select("@function.inner", "textobjects")
      end, { desc = "inner function" })
      map({ "x", "o" }, "ac", function()
        ts_select("@conditional.outer", "textobjects")
      end, { desc = "outer conditional" })
      map({ "x", "o" }, "ic", function()
        ts_select("@conditional.inner", "textobjects")
      end, { desc = "inner conditional" })
      map({ "x", "o" }, "al", function()
        ts_select("@loop.outer", "textobjects")
      end, { desc = "outer loop" })
      map({ "x", "o" }, "il", function()
        ts_select("@loop.inner", "textobjects")
      end, { desc = "inner loop" })
    end,
  },

  -- Context: still works, but verify it supports main-branch treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
      multiline_threshold = 1,
    },
    keys = {
      {
        "<leader>tx",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
      {
        "<leader>lc",
        function()
          vim.schedule(function()
            require("treesitter-context").go_to_context()
          end)
          return "<Ignore>"
        end,
        desc = "Jump to upper context",
        expr = true,
      },
    },
  },
}
