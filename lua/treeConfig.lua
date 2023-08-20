-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

-- Define a function to open the NvimTree when "\" key is pressed
function toggleTree()
	vim.cmd(":NvimTreeToggle")
end

-- Map "\" key to the function
vim.api.nvim_set_keymap("n", "\\", ":lua toggleTree()<CR>", { noremap = true, silent = true })

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 25,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
