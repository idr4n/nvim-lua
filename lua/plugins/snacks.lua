return {
  "folke/snacks.nvim",
  opts = function()
    -- local exclude_pattern = {
    --   "node_modules",
    --   ".DS_Store",
    --   ".next",
    --   ".zig-cache/",
    --   "**/_build/",
    --   "deps/",
    --   ".elixir_ls/",
    --   "**/target/",
    --   "**/assets/node_modules/",
    --   "**/assets/vendor/",
    --   "**/.next/",
    --   "**/.vercel/",
    --   "**/build/",
    --   "**/out/",
    -- }
    return {
      picker = {
        sources = {
          files = {
            hidden = false,
            ignored = false,
            -- exclude = exclude_pattern,
          },
        },
        layout = { layout = { backdrop = false } },
        formatters = {
          file = {
            filename_first = false,
          },
        },
        win = {
          input = {
            keys = {
              ["<c-l>"] = { "toggle_preview", mode = { "i", "n" } },
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["l"] = { "confirm", mode = { "n" } },
              ["s"] = { "close", mode = { "n" } },
              ["<c-\\>"] = { "toggle_ignored", mode = { "i", "n" } },
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
        },
      },
    }
  end,
  keys = function()
    local snacks = require("snacks")
    -- local default_opts = { layout = { preset = "select", layout = { width = 0.6, min_width = 80, height = 0.5, min_height = 15 } } }

    -- stylua: ignore
    return {
      { "<C-Space>", function() snacks.picker.files() end, desc = "Find Files" },
      { "<leader>,", function() snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() snacks.picker.grep() end, desc = "Grep" },
      { "<leader>r", function() snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>'", function() snacks.picker.resume() end, desc = "Resume" },
      { "<leader>u", function() snacks.picker.undo() end, desc = "Undo Tree" },
      { "<C-P>", function() snacks.picker() end, desc = "Show all pickers" },
      -- find
      { "<leader>fb", function() snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gc", function() snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() snacks.picker.git_status() end, desc = "Git Status" },
      -- Grep
      { "<leader>sb", function() snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() snacks.picker.grep() end, desc = "Grep" },
      { "<leader>r", function() snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "x" } },
      { "<leader>fw", function() snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() snacks.picker.registers() end, desc = "Registers" },
      { "<leader>sa", function() snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sh", function() snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sl", function() snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sj", function() snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sM", function() snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sq", function() snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>qp", function() snacks.picker.projects() end, desc = "Projects" },
      -- LSP
      { "gd", function() snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "gs", function() snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>ss", function() snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    }
  end,
}
