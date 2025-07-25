return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "mason.nvim",
    -- "saghen/blink.cmp",
    -- "j-hui/fidget.nvim",
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        max_size = 50,
        spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
        -- client_format = function(client_name, spinner, series_messages)
        client_format = function(_, spinner, series_messages)
          return #series_messages > 0
              -- and (spinner .. " [" .. client_name .. "] " .. table.concat(series_messages, ", "))
              -- and (spinner .. " (LSP) " .. table.concat(series_messages, ", "))
              and (spinner .. " LSP")
            or nil
        end,
        format = function(client_messages)
          if #client_messages > 0 then
            return table.concat(client_messages, " ")
          end
          return ""
        end,
      },
    },
  },
  keys = {
    {
      "<leader>cD",
      function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
      end,
      desc = "Toggle diagnostic virtual_lines",
    },
  },
  config = function()
    local lsp_conf = require("config.lsp")
    local lspconfig = require("lspconfig")
    local icons = require("utils").diagnostic_icons
    local x = vim.diagnostic.severity

    local function is_deno_project(filename)
      local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
      return denoRootDir ~= nil
    end

    local opts = {
      diagnostics = {
        virtual_text = { prefix = "" },
        virtual_lines = false,
        -- virtual_lines = { current_line = true },
        signs = {
          text = { [x.ERROR] = icons.Error, [x.WARN] = icons.Warn, [x.INFO] = icons.Info, [x.HINT] = icons.Hint },
          numhl = {
            [x.WARN] = "WarningMsg",
            [x.ERROR] = "ErrorMsg",
            [x.INFO] = "DiagnosticInfo",
            [x.HINT] = "DiagnosticHint",
          },
        },
        underline = true,
        float = { border = "rounded" },
      },

      custom_server_settings = {
        jsonls = require("config.lsp.server_settings.jsonls"),
        lua_ls = require("config.lsp.server_settings.lua_ls"),
        pyright = require("config.lsp.server_settings.pyright"),
        sqlls = require("config.lsp.server_settings.sqls"),
        cssls = require("config.lsp.server_settings.cssls"),
        -- solargraph = require("config.lsp.server_settings.solargraph"),
        tailwindcss = require("config.lsp.server_settings.tailwindcss"),
        vtsls = {
          single_file_support = not is_deno_project(vim.fn.expand("%:p")),
        },
        denols = { root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc") },
        ruff = { init_options = { settings = { lint = { enable = false } } } },
      },

      custom_server_setup = {
        -- rust_analyzer (it is being setup by rustaceanvim plugin)
        rust_analyzer = function()
          return true
        end,

        -- jdtls
        jdtls = function()
          return true
        end,

        -- tailwindcss
        tailwindcss = function(_, opts)
          local tw = require("lspconfig.configs.tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains({ "markdown" }, ft)
          end, opts.filetypes)
        end,
      },
    }

    --: Diagnostics, Hover, SignatureHelp, UI {{{
    -- setup signs and diagnostics
    vim.diagnostic.config(opts.diagnostics)

    -- If not using noice.nvim, configure hover and signatureHelp
    if not package.loaded["noice"] then
      local hover = vim.lsp.buf.hover
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.lsp.buf.hover = function()
        return hover({
          border = "rounded",
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.5),
        })
      end

      local signature_help = vim.lsp.buf.signature_help
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.lsp.buf.signature_help = function()
        return signature_help({
          border = "rounded",
          max_height = math.floor(vim.o.lines * 0.5),
          max_width = math.floor(vim.o.columns * 0.4),
        })
      end
    end

    -- UI border
    require("lspconfig.ui.windows").default_options.border = "rounded"
    --: }}}

    --: Capabilities {{{
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- local capabilities = require("blink.cmp").get_lsp_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }
    --: }}}

    --: LSP's setup {{{
    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        on_attach = lsp_conf.on_attach,
        capabilities = vim.deepcopy(capabilities),
      }, opts.custom_server_settings[server] or {})

      if opts.custom_server_setup[server] then
        if opts.custom_server_setup[server](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    local servers_lists = require("config.lsp.server_names")
    local installed_servers = require("mason-registry").get_installed_package_names()
    local servers_mapping = servers_lists.names_mapping

    for _, server in ipairs(servers_lists.ensure_installed) do
      if vim.tbl_contains(installed_servers, server) and servers_mapping[server] then
        setup(servers_mapping[server])
      end
    end
    --: }}}

    --: Servers not in Mason {{{
    -- Swift (sourcekit)
    require("lspconfig").sourcekit.setup({
      on_attach = lsp_conf.on_attach,
      capabilities = capabilities,
      filetypes = { "swift" },
    })
    --: }}}
  end,
}
