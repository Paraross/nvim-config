return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "git", "<CMD>tab Git<CR>", {})
			vim.keymap.set("n", "<leader>gs-", "<CMD>Git switch -<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
