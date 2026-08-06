return {
  "mrcjkb/rustaceanvim",
  -- Upstream renamed its default branch master -> main. Without pinning it
  -- here, Lazy keeps re-resolving the default and lazy-lock.json flip-flops
  -- between "master" and "main" on every sync. Track main explicitly.
  branch = "main",
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
