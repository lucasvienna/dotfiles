return {
  -- Provides filetype detection, syntax highlighting, indent, and :Terramate command
  {
    "terramate-io/vim-terramate",
  },
  -- Configure terramate-ls through nvim-lspconfig (custom server, not in registry)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.terramate_ls then
        configs.terramate_ls = {
          default_config = {
            cmd = { "terramate-ls" },
            filetypes = { "terramate" },
            root_dir = lspconfig.util.root_pattern("terramate.tm.hcl", ".git"),
          },
        }
      end

      opts.servers = opts.servers or {}
      opts.servers.terramate_ls = {}
    end,
  },
}
