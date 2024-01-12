return {
    on_attach = function(client, bufnr)
        require("plugins.lsp.handlers").on_attach(client, bufnr)
        require("sqlls").on_attach(client, bufnr)
    end,
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
