-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Certain but not all LSPs will set the root directory based on which buffer
-- is active. This affects picking files. I found this to be disruptive, for
-- example editing a Lua file in my dotfiles prevented me from fuzzy finding
-- files of the nvim/ directory. Remove this to bring things back to LazyVim's
-- default behavior.
vim.g.root_spec = { "cwd" }

-- For ease of debugging, setting the default to WARN is a nice middleground
-- It's not super noisy, but quick glances at the file are still useful.
vim.lsp.set_log_level("WARN")

local opt = vim.opt

-- Show a vertical line at this character.
opt.colorcolumn = "100"

-- Each buffer gets its own status line instead of sharing one.
opt.laststatus = 2
