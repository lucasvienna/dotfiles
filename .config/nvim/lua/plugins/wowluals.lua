local function addon_root(bufnr)
  return vim.fs.root(bufnr, ".wowluarc.json")
end

return {
  {
    "folke/lazydev.nvim",
    opts = {
      enabled = function(root_dir)
        return vim.uv.fs_stat(root_dir .. "/.luarc.json") == nil
      end,
      -- The integration replaces lua_ls's root_dir, which would drop the addon check below.
      integrations = { lspconfig = false },
    },
  },
  {
    "TradeSkillMaster/wowlua-ls",
    name = "wowlua_ls",
    build = "cargo build --release",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        wowlua_ls = {
          cmd = { vim.fn.stdpath("data") .. "/lazy/wowlua_ls/target/release/wowlua_ls" },
          filetypes = { "lua" },
          root_dir = function(bufnr, on_dir)
            local root = addon_root(bufnr)
            if root then
              on_dir(root)
            end
          end,
        },
        lua_ls = {
          -- Never calling on_dir keeps lua_ls out of addons. Elsewhere this is
          -- what lazydev's lspconfig integration does.
          root_dir = function(bufnr, on_dir)
            if not addon_root(bufnr) then
              on_dir(require("lazydev").find_workspace(bufnr))
            end
          end,
        },
      },
    },
  },
}
