local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
	})

	-- plenary, for some reason...
	use("nvim-lua/plenary.nvim")

	-- tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- add brackets/curly/parenthesis automatically
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- file explorer
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons") -- this is moved here, idk if to remove

	-- theme
	use("sainnhe/everforest")

	-- headwind (tailwindcss class sorter)
	use("steelsojka/headwind.nvim")

	-- FINE. I'll give in and use autocomplete
	use("neovim/nvim-lspconfig")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
