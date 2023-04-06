local M = {}

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

-- stylua: ignore
local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local od = require("util").opts_and_desc

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", od("Code actions"))
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", od("Code actions"))
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", od("Diagnostics float"))
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-F>", ":Format<cr>", opts)
end

M.on_attach = function(client, bufnr)
    -- disable client specific features, e.g. to use null-ls formating instead
    local clientsNoFormat = { "tsserver", "gopls", "lua_ls", "sqlls" }
    for _, v in ipairs(clientsNoFormat) do
        if client.name == v then
            client.server_capabilities.documentFormattingProvider = false
        end
    end
    local clientsNoHover = { "tailwindcss", "cssmodules_ls" }
    for _, v in ipairs(clientsNoHover) do
        if client.name == v then
            client.server_capabilities.hoverProvider = false
        end
    end
    -- client.server_capabilities.semanticTokensProvider = nil
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

return M
