local function addon_root(bufnr)
  return vim.fs.root(bufnr, function(name)
    return name == ".wowluarc.json" or name:match("%.toc$") ~= nil
  end)
end

return {
  {
    "folke/lazydev.nvim",
    opts = {
      enabled = function(root_dir)
        return vim.uv.fs_stat(root_dir .. "/.luarc.json") == nil
      end,
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
          -- on_dir(nil) falls back to root_markers; skipping it keeps lua_ls out of addons.
          root_dir = function(bufnr, on_dir)
            if not addon_root(bufnr) then
              on_dir(nil)
            end
          end,
        },
      },
    },
  },
}
