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

			-- Override highlights after colorscheme loads
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "dracula_pro*",
				callback = function()
					-- More visible active button in Lazy UI
					vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = "#7c6f9f", fg = "#f8f8f2", bold = true })
				end,
			})
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "dracula_pro",
		},
	},
}
