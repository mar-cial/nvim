require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "rust", "css", "go", "html", "javascript", "json", "markdown", "tsx", "typescript" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  }
}
