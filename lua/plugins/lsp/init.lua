return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("plugins.lsp.mason")
        require("plugins.lsp.handlers").setup()

        -- Convert JSON filetype to JSON with comments (jsonc)
        vim.cmd([[
				augroup jsonFtdetect
				autocmd!
				autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
				augroup END
				]])

        require("lspconfig").sourcekit.setup({
            on_attach = require("plugins.lsp.handlers").on_attach,
            capabilities = require("plugins.lsp.handlers").capabilities,
        })
    end,
}
