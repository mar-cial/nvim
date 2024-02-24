require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require 'cmp'

cmp.setup({
        snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
        },
        window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
        }, {
                { name = 'buffer' },
        })
})

local null_ls = require("null-ls")

null_ls.setup({
        sources = {
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.rustywind,
                null_ls.builtins.formatting.prettierd,
        },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                vim.lsp.buf.format({ async = false })
                        end,
                })
        end
end

require("null-ls").setup({
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = on_attach
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").tsserver.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").tailwindcss.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").jsonls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").rust_analyzer.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").emmet_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").html.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").htmx.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").yamlls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").dockerls.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").docker_compose_language_service.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
require("lspconfig").zig.setup {
        capabilities = capabilities,
        on_attach = on_attach
}
