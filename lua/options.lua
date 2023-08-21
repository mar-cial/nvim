vim.opt.number = true
vim.wo.signcolumn = "yes"
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- remove the virtual text. Taken from:
-- https://github.com/samhh/dotfiles/blob/99e67298fbcb61d7398ad1850f3c2df31d90bd0d/home/.config/nvim/plugin/lsp.lua#L120
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
})

-- hover diagnostics
vim.opt.updatetime = 250
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
