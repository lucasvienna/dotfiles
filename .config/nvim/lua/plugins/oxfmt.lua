-- Extra filetypes for oxfmt beyond what the LazyVim oxc extra provides.
-- The oxc extra already covers: javascript, javascriptreact, typescript,
-- typescriptreact, json, jsonc, vue, svelte, astro.
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local extra_fts = {
        "css",
        "graphql",
        "handlebars",
        "html",
        "htmlangular",
        "json5",
        "less",
        "markdown",
        "mdx",
        "scss",
        "svelte",
        "toml",
        "yaml",
      }
      for _, ft in ipairs(extra_fts) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end
    end,
  },
}
