-- Keep friendly-snippets out of the way of real LSP completions.
--
-- LazyVim's nvim-cmp extra appends the snippets source without a group_index.
-- nvim-cmp defaults that to 0, and view.open() breaks at the first group with
-- entries, so a matching snippet hides the entire LSP group. Two fixes below:
-- rejoin the LSP group, and demote snippets within it.
return {
  "hrsh7th/nvim-cmp",
  optional = true,
  opts = function(_, opts)
    local cmp = require("cmp")

    for _, source in ipairs(opts.sources or {}) do
      if source.name == "snippets" then
        source.group_index = 1 -- same group as nvim_lsp instead of ahead of it
        source.max_item_count = 5
        source.keyword_length = 2 -- don't fire on a single character
      end
    end

    -- Runs before compare.offset, so it overrides compare.kind's snippet boost.
    table.insert(opts.sorting.comparators, 1, function(e1, e2)
      local s1 = e1.source.name == "snippets"
      local s2 = e2.source.name == "snippets"
      if s1 ~= s2 then
        return s2
      end
      return nil
    end)

    -- Snippets-only menu, for when you actually want one.
    opts.mapping["<C-l>"] = cmp.mapping.complete({
      config = { sources = { { name = "snippets" } } },
    })
  end,
}
