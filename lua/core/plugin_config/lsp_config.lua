require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "rust_analyzer", "gopls", "bashls" }
})

local on_attach = function(client, buffer)
  require("lsp-format").on_attach(client, buffer)

  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()


require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

require("lspconfig").tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "typescript", "typescriptreact", "typescript.tsx"
  }
}

require("lspconfig").rust_analyzer.setup {}

require("lspconfig").gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "typescript", "typescriptreact", "typescript.tsx"
  }
}

require("lspconfig").bashls.setup {}
require("lspconfig").cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").htmx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").docker_compose_language_service.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
