return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          require("dapui").setup()
        end,
      },
      -- Virtual text.
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = { virt_text_pos = "eol" },
      },
      -- JS/TS debugging.
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        },
      },
      {
        "microsoft/vscode-js-debug",
        enabled = false,
        build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
      },
      { "jbyuki/one-small-step-for-vimkind" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" , },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" , },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" , },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" , },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Widgets" , },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Repl" , },
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" , },
      { "<leader>ds", function() require("osv").launch({ port = 8086 }) end, desc = "Launch Lua Debugger Server" , },
      { "<leader>dd", function() require("osv").run_this() end, desc = "Launch Lua Debugger" , },
    },
    config = function()
      local dap = require("dap")

      --: Lua {{{
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
      --: }}}

      --: Rust {{{
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      local codelldb_adapter = {
        type = "server",
        port = "${port}",
        executable = {
          command = mason_path .. "bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.adapters.codelldb = codelldb_adapter
      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      --: }}}

      --: c and c++ {{{
      dap.adapters.lldb = function(cb, config)
        if config.preLaunchTask then
          vim.fn.system(config.preLaunchTask)
        end
        local apapter = {
          type = "executable",
          command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
          name = "lldb",
        }
        cb(apapter)
      end

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = "./a.out",
          cwd = "${workspaceFolder}",
          preLaunchTask = "clang++ -g -o a.out -std=c++17 -stdlib=libc++ ${file}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
      --: }}}

      --: nvim-dap-ui {{{
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --     dapui.close({})
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --     dapui.close({})
      -- end
      --: }}}

      --: Breakpoints highlights {{{
      vim.api.nvim_set_hl(0, "red", { fg = "#F7768E" })
      vim.api.nvim_set_hl(0, "green", { fg = "#73DACA" })
      vim.api.nvim_set_hl(0, "yellow", { fg = "#F6C177" })
      vim.api.nvim_set_hl(0, "orange", { fg = "#FF9E64" })

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "red", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "orange", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", linehl = "", numhl = "" })
      --: }}}
    end,
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = {
      dap_configurations = {
        {
          -- Must be "go" or it will be ignored by the plugin
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      -- delve configurations
      delve = {
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port
        port = "${port}",
      },
    },

    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = {
      { "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", mode = "v" },
    },
    config = function()
      require("dap-python").resolve_python = function()
        return "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3"
      end
      require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    end,
  },
}
