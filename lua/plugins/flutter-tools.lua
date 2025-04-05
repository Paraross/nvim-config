return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	-- config = true,
	config = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2

		vim.keymap.set("n", "<leader>br", function()
			vim.cmd.tabnew()
			vim.cmd.FlutterRun("-d windows")
		end, {})

		require("flutter-tools").setup({})
	end,
}
