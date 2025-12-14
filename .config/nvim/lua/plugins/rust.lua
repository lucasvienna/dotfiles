return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          procMacro = {
            attributes = { enable = true },
          },
        },
      },
    },
  },
}
