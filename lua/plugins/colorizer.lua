return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup()
		vim.keymap.set("n", "<leader>ct", "<CMD>ColorizerToggle<CR>")
	end,
}
