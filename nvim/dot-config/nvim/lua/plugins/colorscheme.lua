return {
	{
		"maxmx03/solarized.nvim",
		priority = 1000,
		init = function()
			vim.o.background = "light"
		end,
		opts = {
			variant = "summer",
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "solarized",
		},
	},
}
