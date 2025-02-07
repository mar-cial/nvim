local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        }
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP
    use({
        "neovim/nvim-lspconfig",

    })

    use("onsails/lspkind-nvim")
    use({
        "L3MON4D3/LuaSnip",
    })

    -- cmp: Autocomplete
    use({
        "hrsh7th/nvim-cmp",
    })

    use("hrsh7th/cmp-nvim-lsp")

    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

    -- LSP diagnostics, code actions, and more via Lua.
    use({
        "nvimtools/none-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Mason: Portable package manager
    use({
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    })

    use({
        "williamboman/mason-lspconfig.nvim"
    })

    use({
        "folke/trouble.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    })

    use 'gleam-lang/gleam.vim'

    use "fatih/vim-go"

    use {
        '/home/cesar/dev/luascripts/floating-terra',
        config = function()
            require('floating-terra')
        end
    }

    use {
        "folke/lazydev.nvim",
        config = function()
            require("lazydev").setup()
        end
    }

    use {
        "mfussenegger/nvim-dap",
        requires = {
            "jbyuki/one-small-step-for-vimkind",
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio"
        }
    }

    use {
        'tomblind/local-lua-debugger-vscode'
    }

    use { "rebelot/kanagawa.nvim" }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
