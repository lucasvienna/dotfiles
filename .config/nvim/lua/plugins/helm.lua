return {
  {
    "qvalentin/helm-ls.nvim",
    opts = {
      conceal_templates = {
        -- enable the replacement of templates with virtual text of their current values
        enabled = true,
      },
      indent_hints = {
        -- enable hints for indent and nindent functions
        enabled = true,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        helm = { "helmfmt" },
      },
      formatters = {
        helmfmt = {
          command = "helmfmt",
          args = { "--files", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
