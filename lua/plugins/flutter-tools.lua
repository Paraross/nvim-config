return {
	"nvim-flutter/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		local on_attach = function()
			vim.opt.tabstop = 2
			vim.opt.softtabstop = 2

			vim.keymap.set("n", "<leader>br", "<CMD>FlutterRun<CR>", {})
			vim.keymap.set("n", "<leader>bl", "<CMD>FlutterReload<CR>", {})
			vim.keymap.set("n", "<leader>bs", "<CMD>FlutterRestart<CR>", {})
			vim.keymap.set("n", "<leader>bq", "<CMD>FlutterQuit<CR>", {})
			vim.keymap.set("n", "<leader>bc", "<CMD>FlutterLogClear<CR>", {})
		end

		require("flutter-tools").setup({
			dev_log = {
				open_cmd = "tabnew",
				focus_on_open = false,
			},
			lsp = {
				on_attach = on_attach,
			},
		})
	end,
}
