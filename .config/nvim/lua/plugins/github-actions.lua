return {
  {
    "skanehira/github-actions.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function(_, opts)
      require("github-actions").setup(opts)
      -- Only the inline version check is wanted; runs are managed with `gh`.
      for _, cmd in ipairs({
        "GithubActionsDispatch",
        "GithubActionsHistory",
        "GithubActionsHistoryByPR",
        "GithubActionsWatch",
      }) do
        pcall(vim.api.nvim_del_user_command, cmd)
      end
    end,
  },
}
