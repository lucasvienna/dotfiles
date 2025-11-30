return {
	{
		"git@github.com:dracula-pro/vim.git",
		name = "dracula_pro",
		lazy = false,
		priority = 1000,
		init = function()
			-- These must be set BEFORE the colorscheme loads
			vim.g.dracula_colorterm = 0 -- Disable background fill (enables transparency)
			vim.g.dracula_italic = 1
			vim.g.dracula_bold = 1
			vim.g.dracula_underline = 1
			vim.g.dracula_undercurl = 1
			vim.g.dracula_strikethrough = 1
			vim.g.dracula_full_special_attrs_support = 1
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "dracula_pro",
		},
	},
}
