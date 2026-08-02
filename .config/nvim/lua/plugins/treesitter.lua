return {
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = {
      -- Add custom treesitters not present by default in LazyVim.
      ensure_installed = {
        "csv",
        "ini",
        "nginx",
        "ghostty",
      },
    },
  },
}
