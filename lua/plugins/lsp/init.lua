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
                -- "emmet-ls",
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
                "zls",
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
        -- event = { "BufReadPre", "BufNewFile" },
        init = function()
            require("util").lazy_load("nvim-lspconfig")
        end,
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = require("plugins.lsp.config").lsp_opts,
        config = function(_, opts)
            require("plugins.lsp.config").lsp_config(opts)
        end,
    },
    --: }}}

    --: null-ls/none-ls {{{
    {
        -- "jose-elias-alvarez/null-ls.nvim",
        "nvimtools/none-ls.nvim",
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
                border = "rounded",
                sources = {
                    -- Prettier
                    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                    formatting.prettier.with({
                        extra_args = { "--single-quote", "--jsx-single-quote" },
                        disabled_filetypes = { "markdown", "html", "vue" },
                        extra_filetype = { "svelte" },
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
