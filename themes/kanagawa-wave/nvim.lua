return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			theme = "wave",
			transparent = true,
			dimInactive = false,
			commentStyle = { italic = true },
			keywordStyle = { italic = false },
			colors = {
				theme = {
					all = {
						ui = {
							-- Drop the gutter background so line numbers sit on the terminal bg.
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				local palette = colors.palette
				return {
					SnacksPickerPathHidden = { fg = theme.syn.comment },
					SnacksPickerDir = { fg = theme.syn.comment },
					SnacksPickerGitStatusIgnored = { fg = theme.ui.nontext },
					SnacksPickerGitStatusUntracked = { fg = theme.ui.nontext },
					ColorColumn = { bg = theme.ui.bg_p2 },
					SpellBad = { fg = palette.samuraiRed, undercurl = true },
					SpellCap = { fg = palette.samuraiRed, undercurl = true },
					SpellLocal = { fg = palette.samuraiRed, undercurl = true },
					SpellRare = { fg = palette.samuraiRed, undercurl = true },
				}
			end,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa-wave",
		},
	},
}
