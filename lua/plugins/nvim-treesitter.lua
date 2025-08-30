return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "javascript", "typescript", "html", "css", "lua", "json" },
    context_commentstring = {
      enable = true,
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
