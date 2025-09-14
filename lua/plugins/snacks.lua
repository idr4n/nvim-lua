return {
  "folke/snacks.nvim",
  opts = function()
    local exclude_pattern = {
      "node_modules",
      ".DS_Store",
      ".next",
      ".zig-cache/",
      "**/_build/",
      "deps/",
      ".elixir_ls/",
      "**/__pycache__/",
      ".ruff_cache",
      "**/target/",
      "**/assets/node_modules/",
      "**/assets/vendor/",
      "**/.next/",
      "**/.vercel/",
      "**/build/",
      "**/out/",
      "*.class",
    }
    return {
      image = {
        enabled = false,
        doc = { inline = false },
        math = {
          enabled = false,
          latex = { font_size = "large" },
        },
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = exclude_pattern,
          },
        },
        layout = { layout = { backdrop = false } },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        matcher = { frecency = true },
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
    local default_opts =
      { layout = { preset = "select", layout = { width = 0.6, min_width = 100, height = 0.3, min_height = 17 } } }

    -- stylua: ignore
    local buffers_opts = {
      sort_lastused = false,
      on_show = function() vim.cmd.stopinsert() end,
      layout = { preset = "select", layout = { width = 0.6, min_width = 90, height = 0.3, min_height = 15 } },
    }

    -- stylua: ignore
    return {
      { "<leader>ff", function() snacks.picker.files(default_opts) end, desc = "Find Files" },
      { "<leader>so", function() snacks.picker.buffers(buffers_opts) end, desc = "Buffers" },
      { "<leader>:", function() snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>'", function() snacks.picker.resume() end, desc = "Resume" },
      { "<leader>u", function() snacks.picker.undo() end, desc = "Undo Tree" },
      -- { "<C-P>", function() snacks.picker() end, desc = "Show all pickers" },
      -- find
      { "<leader>fb", function() snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fg", function() snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gc", function() snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() snacks.picker.git_status({ on_show = function() vim.cmd.stopinsert() end }) end, desc = "Git Status" },
      -- search
      { '<leader>s"', function() snacks.picker.registers() end, desc = "Registers" },
      { "<leader>sa", function() snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() snacks.picker.commands() end, desc = "Commands" },
      -- { "<leader>sd", function() snacks.picker.diagnostics() end, desc = "Diagnostics" },
      -- { "<leader>sh", function() snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sj", function() snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sM", function() snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() snacks.picker.resume() end, desc = "Resume Snacks Picker" },
      { "<leader>sq", function() snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>qp", function() snacks.picker.projects() end, desc = "Projects" },
      -- LSP
      { "gd", function() snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "<leader>gr", function() snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    }
  end,
}
