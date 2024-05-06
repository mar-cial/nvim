require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "typescript", "lua", "rust", "javascript" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
}
