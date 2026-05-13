return {
	{
		"maxmx03/solarized.nvim",
		priority = 1000,
		init = function()
			vim.o.background = "dark"
		end,
		opts = {
			variant = "winter",
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "solarized",
		},
	},
}
