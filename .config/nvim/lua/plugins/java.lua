return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "google-java-format",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- LazyVim's Java extra ships no default formatter.
        java = { "google-java-format", stop_after_first = true },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      test = false, -- disable jdtls's test runner; we use neotest below instead.
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "rcasia/neotest-java" },
    opts = {
      adapters = {
        ["neotest-java"] = {
          junit_jar = nil, -- auto-detected from Mason
        },
      },
    },
  },
}
