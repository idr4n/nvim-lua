local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    return
end

local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "emmet_ls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sqls",
    "stylelint_lsp",
    "lua_ls",
    "svelte",
    "tailwindcss",
    "tsserver",
    "vimls",
    "yamlls",
}

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
}

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
    if server == "jsonls" then
        local jsonls_opts = require("plugins.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server == "lua_ls" then
        local sumneko_opts = require("plugins.lsp.settings.lua_ls")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require("plugins.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "jdtls" then
        goto continue
    end

    if server == "sqls" then
        opts = {
            on_attach = function(client, bufnr)
                require("plugins.lsp.handlers").on_attach(client, bufnr)
                require("sqls").on_attach(client, bufnr)
            end,
            capabilities = require("plugins.lsp.handlers").capabilities,
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = "postgresql",
                            dataSourceName = "host=127.0.0.1 port=5432 user=iduran dbname=plants_dev",
                        },
                        {
                            driver = "postgresql",
                            dataSourceName = "host=127.0.0.1 port=5432 user=iduran dbname=test",
                        },
                        {
                            driver = "postgresql",
                            dataSourceName = "host=127.0.0.1 port=5432 user=iduran",
                        },
                    },
                },
            },
        }
    end

    lspconfig[server].setup(opts)
    ::continue::
end

require("mason-lspconfig").setup_handlers({
    ["rust_analyzer"] = function()
        require("rust-tools").setup({
            tools = {
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "<- ",
                    other_hints_prefix = "=> ",
                },
            },
            server = opts,
        })
    end,
})
