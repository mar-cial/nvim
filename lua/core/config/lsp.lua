require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.rustywind,
        null_ls.builtins.formatting.prettierd,
    },
    on_attach = on_attach,
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "typescriptreact", "typescript", "javascript", "tsx", "jsx" }
}

require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {
            runtime = {
                -- Use LuaJIT as the runtime for Love2D
                version = "LuaJIT",
                -- Define the runtime path to include common Lua modules
                path = {
                    "?.lua",
                    "?/init.lua",
                    "./?.lua",
                    "/usr/share/luajit-2.1/?.lua",
                    "/usr/local/share/lua/5.1/?.lua",
                    "/usr/local/share/lua/5.1/?/init.lua",
                    "/usr/share/lua/5.1/?.lua",
                    "/usr/share/lua/5.1/?/init.lua",
                },
            },
            diagnostics = {
                -- Recognize global variables `vim` and `love` to avoid false positives
                globals = { "vim", "love" },
            },
            workspace = {
                -- Add library paths for Neovim runtime and Love2D API
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.expand("~/.local/share/nvim/love-api")] = true,
                },
                -- Do not check for third-party libraries
                checkThirdParty = false,
            },
            telemetry = {
                -- Disable telemetry to avoid data collection
                enable = false,
            },
        },
    }
}
require("lspconfig").tailwindcss.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").rust_analyzer.setup {
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
require("lspconfig").astro.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").jsonls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").pylsp.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").terraformls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require("lspconfig").emmet_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}
