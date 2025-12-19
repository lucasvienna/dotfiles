return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local function find_oxfmt(ctx)
        -- Check local node_modules first (may be a symlink)
        local root = vim.fs.find("node_modules", {
          upward = true,
          path = ctx.dirname,
          type = "directory",
        })[1]
        if root then
          local local_bin = root .. "/.bin/oxfmt"
          if vim.uv.fs_stat(local_bin) then
            return local_bin
          end
        end
        -- Fall back to global
        if vim.fn.executable("oxfmt") == 1 then
          return "oxfmt"
        end
        return nil
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = {
        command = function(_, ctx)
          return find_oxfmt(ctx) or "oxfmt"
        end,
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
        condition = function(_, ctx)
          return find_oxfmt(ctx) ~= nil
        end,
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local oxfmt_fts = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "yaml",
      }
      for _, ft in ipairs(oxfmt_fts) do
        opts.formatters_by_ft[ft] = { "oxfmt", "prettier", stop_after_first = true }
      end

      return opts
    end,
  },
}
