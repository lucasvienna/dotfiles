return {
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "moon",
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = false },
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(hl, c)
				hl.SnacksPickerPathHidden = { fg = c.comment }
				hl.SnacksPickerDir = { fg = c.comment }
				hl.SnacksPickerGitStatusIgnored = { fg = c.nontext }
				hl.SnacksPickerGitStatusUntracked = { fg = c.nontext }
				hl.ColorColumn = { bg = c.bg_highlight }
				hl.SpellBad = { fg = c.red, undercurl = true }
				hl.SpellCap = { fg = c.red, undercurl = true }
				hl.SpellLocal = { fg = c.red, undercurl = true }
				hl.SpellRare = { fg = c.red, undercurl = true }
			end,
		},
	},
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
