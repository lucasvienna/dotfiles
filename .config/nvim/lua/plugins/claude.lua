return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
    },
  },
  {
    "folke/edgy.nvim",
    opts = {
      right = {
        { ft = "ClaudeCode", size = { width = 0.40 } },
      },
    },
  },
}
