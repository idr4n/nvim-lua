return {
  "mfussenegger/nvim-jdtls",
  enabled = false,
  ft = "java",
  config = function()
    -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

    local jdtls_server = require("lspconfig")["jdtls"]
    local new_cmd = jdtls_server.document_config.default_config.cmd
    local config = {
      -- The command that starts the language server
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
      -- cmd = {
      --   'java', -- or '/path/to/java11_or_newer/bin/java'
      --   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      --   '-Dosgi.bundles.defaultStartLevel=4',
      --   '-Declipse.product=org.eclipse.jdt.ls.core.product',
      --   '-Dlog.protocol=true',
      --   '-Dlog.level=ALL',
      --   '-Xms1g',
      --   '--add-modules=ALL-SYSTEM',
      --   '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      --   '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      --   -- 💀
      --   '-jar', '/opt/homebrew/Cellar/jdtls/1.9.0-202203031534/libexec/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      --   -- 💀
      --   '-configuration', '/opt/homebrew/Cellar/jdtls/1.9.0-202203031534/libexec/config_mac',
      --   -- 💀
      --   -- See `data directory configuration` section in the README
      --   '-data', workspace_dir
      -- },

      -- using nvim-lsp-installer server instead
      -- cmd = new_cmd,

      autostart = true,
      filetypes = { "java" },

      -- 💀
      -- This is the default if not provided, you can remove it. Or adjust as needed.
      -- One dedicated LSP server & client will be started per unique root_dir
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

      -- Here you can configure eclipse.jdt.ls specific settings
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- for a list of options
      settings = {
        java = {
          project = {
            referencedLibraries = {
              "/Users/iduran/Dev/Java-Libraries/*.jar",
            },
          },
        },
      },

      -- Language server `initializationOptions`
      -- You need to extend the `bundles` with paths to jar files
      -- if you want to use additional eclipse.jdt.ls plugins.
      --
      -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
      --
      -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
      init_options = {
        bundles = {},
      },
    }

    config.on_attach = require("config.lsp").on_attach
    config.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    config.capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    config.capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    -- require('jdtls').start_or_attach(config)

    local function jdtls_start()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      -- local workspace_dir = vim.env.HOME .. '/.local/share/nvim/workspace/' .. project_name
      local workspace_dir = vim.env.TMPDIR .. "workspace/" .. project_name

      new_cmd[#new_cmd] = workspace_dir
      config.cmd = new_cmd

      require("jdtls").start_or_attach(config)
    end

    vim.api.nvim_create_augroup("jdtls-lsp", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = jdtls_start,
      group = "jdtls-lsp",
    })
  end,
}
