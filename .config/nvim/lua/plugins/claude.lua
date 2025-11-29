return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
  },
}
