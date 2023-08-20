if vim.fn.has("termguicolors") then
	vim.cmd("set termguicolors")
end

vim.opt.background = "dark"
vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 0

-- setup must be called before loading
vim.cmd.colorscheme("everforest")
