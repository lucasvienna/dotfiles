-- Use `tsc --lsp` (the native TypeScript 7 compiler) as the TS/JS language server.
--
-- nvim-lspconfig deprecated `tsgo` in favour of `tsc` once the Go port landed in
-- TypeScript proper: `lsp/tsgo.lua` is now just `tsc` plus a `vim.deprecate` call
-- and disappears in nvim-lspconfig 3.0.0.
--
-- LazyVim has no `lang.typescript.tsc` extra yet (LazyVim/LazyVim#7233 is open),
-- so the `tsgo` extra is gone from lazyvim.json and the swap happens here. Note
-- that `vim.g.lazyvim_ts_lsp = "tsc"` is *not* an option: `lang.typescript`'s
-- init only registers `vtsls` and `tsgo` as valid values, and an unknown one is
-- an error. With the tsgo extra gone that registry falls back to its first entry
-- and enables vtsls, which is why vtsls has to be turned off explicitly. This
-- file is imported after the extras, so it wins that merge.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = { enabled = false },
        tsc = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras (lspconfig itself omits the jsx/tsx ones)
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          ---@type lspconfig.settings.tsc
          settings = {
            -- The server pulls both `js/ts` and `typescript`, but `js/ts` wins
            -- where the two overlap, and nvim-lspconfig's defaults fill `js/ts`
            -- with every hint enabled — so the quiet ones have to be set there,
            -- not under `typescript` where LazyVim used to put them for tsgo.
            ["js/ts"] = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = {
                  enabled = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}
