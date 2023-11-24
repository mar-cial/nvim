require("core.keymaps")
require("core.plugins")
require("core.plugin_config")

vim.opt.clipboard = "unnamedplus"
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
