return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
              and (spinner .. " (LSP) " .. table.concat(series_messages, ", "))
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
  config = function()
    local lsp_conf = require("config.lsp")
    local methods = vim.lsp.protocol.Methods
    local icons = require("utils").diagnostic_icons
    local x = vim.diagnostic.severity

    local lspconfig = require("lspconfig")

    local function is_deno_project(filename)
      local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
      return denoRootDir ~= nil
    end

    local opts = {
      diagnostics = {
        virtual_text = { prefix = "" },
        signs = {
          text = { [x.ERROR] = icons.Error, [x.WARN] = icons.Warn, [x.INFO] = icons.Info, [x.HINT] = icons.Hint },
        },
        underline = true,
        float = { border = "rounded" },
      },

      servers = {
        jsonls = require("config.lsp.server_settings.jsonls"),
        lua_ls = require("config.lsp.server_settings.lua_ls"),
        pyright = require("config.lsp.server_settings.pyright"),
        sqlls = require("config.lsp.server_settings.sqls"),
        cssls = require("config.lsp.server_settings.cssls"),
        solargraph = require("config.lsp.server_settings.solargraph"),
        tailwindcss = require("config.lsp.server_settings.tailwindcss"),
        gleam = { mason = false },
        vtsls = {
          single_file_support = not is_deno_project(vim.fn.expand("%:p")),
        },
        denols = { root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc") },
        ruff = { init_options = { settings = { lint = { enable = false } } } },
      },

      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,

        -- rust_analyzer (it is being setup by rustaceanvim plugin)
        rust_analyzer = function()
          return true
        end,

        -- jdtls
        jdtls = function()
          return true
        end,

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

    -- setup signs and diagnostics
    vim.diagnostic.config(opts.diagnostics)

    -- If not using noice.nvim, configure hover and signatureHelp
    if not package.loaded["noice"] then
      if vim.fn.has("nvim-0.10.0") == 1 then
        vim.lsp.handlers[methods.textDocument_hover] = lsp_conf.enhanced_float_handler(vim.lsp.buf.hover, true)
        vim.lsp.handlers[methods.textDocument_signatureHelp] =
          lsp_conf.enhanced_float_handler(vim.lsp.buf.signature_help, false)
      else
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.with(vim.lsp.buf.hover, {
          border = "rounded",
        })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.with(vim.lsp.buf.signature_help, {
          border = "rounded",
        })
      end
    end

    require("lspconfig.ui.windows").default_options.border = "rounded"

    local servers = opts.servers
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

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        on_attach = lsp_conf.on_attach,
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    if have_mason then
      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end

    -- Convert JSON filetype to JSON with comments (jsonc)
    vim.cmd([[
      augroup jsonFtdetect
      autocmd!
      autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
      augroup END
    ]])

    require("lspconfig").sourcekit.setup({
      on_attach = lsp_conf.on_attach,
      capabilities = capabilities,
      filetypes = { "swift" },
    })
  end,
}
