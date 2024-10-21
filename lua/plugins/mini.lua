return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.files",
    keys = {
      -- { "-", ":lua require('mini.files').open()<cr>", silent = true, desc = "Mini Files" },
      -- {
      --   "-",
      --   function()
      --     local bufname = vim.api.nvim_buf_get_name(0)
      --     local path = vim.fn.fnamemodify(bufname, ":p")
      --     if path and vim.uv.fs_stat(path) then
      --       require("mini.files").open(bufname, false)
      --     end
      --   end,
      --   silent = true,
      --   desc = "Mini Files",
      -- },
      {
        "<C-Q>",
        -- "s",
        -- "<leader>-",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")
          if path and vim.uv.fs_stat(path) then
            local MiniFiles = require("mini.files")
            if not MiniFiles.close() then
              MiniFiles.open(bufname, false)
            end
          end
        end,
        silent = true,
        desc = "Mini Files",
      },
      {
        ",,",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")
          if path and vim.uv.fs_stat(path) then
            local MiniFiles = require("mini.files")
            if not MiniFiles.close() then
              MiniFiles.open(bufname, false)
            end
          end
        end,
        silent = true,
        desc = "Mini Files",
      },
    },
    -- init = function()
    --   if vim.fn.argc(-1) == 1 then
    --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --     if stat and stat.type == "directory" then
    --       require("mini.files").open()
    --     end
    --   end
    -- end,
    opts = function()
      local copy_path = function()
        local cur_entry_path = require("mini.files").get_fs_entry().path
        vim.fn.setreg("+", cur_entry_path)
        print("Path copied to clipboard!")
      end
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("idr4n/mini-files", { clear = true }),
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "Y", copy_path, { buffer = args.data.buf_id })
        end,
      })
      return {
        mappings = {
          close = "q",
          show_help = "?",
          go_in_plus = "l",
          go_out_plus = "<tab>",
        },
        windows = { width_nofocus = 25, preview = false },
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    -- enabled = false,
    lazy = true,
    opts = function()
      vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#28A2D4" })
      return {
        file = {
          [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          README = { glyph = "", hl = "MiniIconsYellow" },
          ["README.md"] = { glyph = "", hl = "MiniIconsYellow" },
          ["README.txt"] = { glyph = "", hl = "MiniIconsYellow" },
        },
        filetype = {
          dotenv = { glyph = "", hl = "MiniIconsYellow" },
        },
        -- extension = {
        --   lua = { glyph = "󰢱", hl = "MiniIconsCyan" },
        -- },
      }
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    {
      "echasnovski/mini.move",
      -- event = "VeryLazy",
      keys = {
        -- { "<M-down>", mode = { "n", "v" } },
        -- { "<M-up>", mode = { "n", "v" } },
        -- { "<M-left>", mode = { "n", "v" } },
        -- { "<M-right>", mode = { "n", "v" } },
        { "<M-j>", mode = { "n", "v" } },
        { "<M-k>", mode = { "n", "v" } },
        { "<M-h>", mode = { "n", "v" } },
        { "<M-l>", mode = { "n", "v" } },
      },
      -- opts = {
      --   mappings = {
      --     -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      --     left = "<M-left>",
      --     right = "<M-right>",
      --     down = "<M-down>",
      --     up = "<M-up>",
      --
      --     -- Move current line in Normal mode
      --     line_left = "<M-left>",
      --     line_right = "<M-right>",
      --     line_down = "<M-down>",
      --     line_up = "<M-up>",
      --   },
      -- },
      config = true,
    },
  },

  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "S", -- Add surrounding
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "fsr", -- Find surrounding (to the right)
        find_left = "fsl", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`
      },
    },
  },
}