-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.yaml", "*.yml", "*.tpl" },
  callback = function()
    -- Check if this file lives inside a Helm chart (Chart.yaml in an ancestor dir)
    local path = vim.fn.expand("%:p:h")
    local chart = vim.fn.findfile("Chart.yaml", path .. ";")
    if chart ~= "" then
      vim.opt_local.filetype = "helm"
      return
    end

    -- Check for Go template syntax anywhere in the buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(vim.api.nvim_buf_line_count(0), 50), false)
    for _, line in ipairs(lines) do
      if line:match("{{.*}}") or line:match("{%%-?") then
        vim.opt_local.filetype = "helm"
        return
      end
    end
  end,
})
