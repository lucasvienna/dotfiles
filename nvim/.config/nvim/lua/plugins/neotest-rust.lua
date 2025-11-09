return {
  { "rouge8/neotest-rust" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-rust"] = {
          args = { "--no-capture" },
        },
      },
    },
  },
}
