return {
    --: {{{ mason.nvim
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>om", "<cmd>Mason<cr> " } },
        opts = {
            ensure_installed = {
                "astro-language-server",
                "bash-language-server",
                "black",
                "clangd",
                "css-lsp",
                "cssmodules-language-server",
                "emmet-ls",
                "flake8",
                "goimports",
                "gopls",
                "html-lsp",
                "jdtls",
                "json-lsp",
                "lua-language-server",
                "prettier",
                "pyright",
                "revive",
                "ruff",
                "rust-analyzer",
                "sqlfluff",
                "sqlls",
                "stylelint-lsp",
                "stylua",
                "svelte-language-server",
                "tailwindcss-language-server",
                "typescript-language-server",
                "vim-language-server",
                "vue-language-server",
            },
            ui = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, value in ipairs(opts.ensure_installed) do
                local p = mr.get_package(value)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    --: }}}

    --: nvim-jdtls {{{
    {
        "mfussenegger/nvim-jdtls",
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

            config.on_attach = require("plugins.lsp.handlers").on_attach
            config.capabilities = require("plugins.lsp.handlers").capabilities

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
    },
    --: }}}

    --: nvim-lspconfig {{{
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            },

            diagnostics = {
                virtual_text = { spacing = 4, prefix = "●" },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            },

            servers = {
                jsonls = require("plugins.lsp.settings.jsonls"),
                lua_ls = require("plugins.lsp.settings.lua_ls"),
                pyright = require("plugins.lsp.settings.pyright"),
                sqlls = require("plugins.lsp.settings.sqls"),
            },

            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,

                -- rust_analyzer
                rust_analyzer = function()
                    local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
                    local codelldb_adapter = {
                        type = "server",
                        port = "${port}",
                        executable = {
                            command = mason_path .. "bin/codelldb",
                            args = { "--port", "${port}" },
                        },
                    }

                    require("rust-tools").setup({
                        tools = {
                            inlay_hints = {
                                show_parameter_hints = true,
                                parameter_hints_prefix = "<- ",
                                other_hints_prefix = "=> ",
                            },
                            on_initialized = function()
                                vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead", "CursorHold", "InsertLeave" }, {
                                    pattern = { "*.rs" },
                                    callback = function()
                                        local _, _ = pcall(vim.lsp.codelens.refresh)
                                    end,
                                })
                            end,
                        },
                        dap = {
                            adapter = codelldb_adapter,
                        },
                        server = {
                            on_attach = function(client, bufnr)
                                require("plugins.lsp.handlers").on_attach(client, bufnr)
                                local rt = require("rust-tools")
                                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                            end,

                            capabilities = require("cmp_nvim_lsp").default_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            ),
                            settings = {
                                ["rust-analyzer"] = {
                                    lens = {
                                        enable = true,
                                    },
                                    checkOnSave = {
                                        enable = true,
                                        command = "clippy",
                                    },
                                },
                            },
                        },
                    })
                    return true
                end,

                -- jdtls
                jdtls = function()
                    return true
                end,
            },
        },

        config = function(_, opts)
            -- diagnostics
            for _, sign in ipairs(opts.signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end
            vim.diagnostic.config(opts.diagnostics)

            -- hover, signatureHelp, and Lsp floating window border
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

            require("lspconfig.ui.windows").default_options.border = "rounded"

            local servers = opts.servers
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    on_attach = require("plugins.lsp.handlers").on_attach,
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

            -- temp fix for lspconfig rename
            -- https://github.com/neovim/nvim-lspconfig/pull/2439
            local mappings = require("mason-lspconfig.mappings.server")
            if not mappings.lspconfig_to_package.lua_ls then
                mappings.lspconfig_to_package.lua_ls = "lua-language-server"
                mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
            end

            local mlsp = require("mason-lspconfig")
            local available = mlsp.get_available_servers()

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup_handlers({ setup })

            -- Convert JSON filetype to JSON with comments (jsonc)
            vim.cmd([[
                    augroup jsonFtdetect
                    autocmd!
                    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
                    augroup END
                    ]])

            require("lspconfig").sourcekit.setup({
                on_attach = require("plugins.lsp.handlers").on_attach,
                capabilities = capabilities,
            })
        end,
    },
    --: }}}

    --: null-ls {{{
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
            local null_ls = require("null-ls")

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            local formatting = null_ls.builtins.formatting

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            local diagnostics = null_ls.builtins.diagnostics

            return {
                debug = false,
                sources = {
                    -- Prettier
                    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                    formatting.prettier.with({
                        extra_args = { "--single-quote", "--jsx-single-quote" },
                        disabled_filetypes = { "markdown", "html" },
                    }),

                    -- Python
                    -- diagnostics.flake8,
                    formatting.black.with({ extra_args = { "--fast", "--preview" } }),
                    formatting.ruff,
                    diagnostics.ruff,

                    -- LUA
                    formatting.stylua.with({ "--config-path", vim.fn.expand("~/.config/stylua.toml") }),
                    -- diagnostics.vale,

                    -- GOLANG
                    -- diagnostics.golangci_lint,
                    -- For revive, there is a ~/revive.toml config file to exclude linting rules
                    diagnostics.revive,
                    formatting.goimports,

                    -- SQL
                    -- sqlfluff: extra config option set in ~/.sqlfluff
                    -- formatting.sql_formatter.with({ extra_args = { "--keywordCase", "upper" } }),
                    formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" },
                    }),

                    -- Bash
                    formatting.beautysh.with({
                        extra_args = { "--indent-size", "2" },
                    }),
                },
            }
        end,
    },
    --: }}}
}
