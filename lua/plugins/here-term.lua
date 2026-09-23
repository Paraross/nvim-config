return {
	"jaimecgomezz/here.term",
	opts = {},
	config = function()
		require("here-term").setup({
			mappings = {
				enable = true,
				toggle = "<C-;>",
				kill = "<C-A-;>",
			},
			extra_mappings = {
				enable = true,
				escape = "<C-x>",
				left = "<C-w>h",
				down = "<C-w>j",
				up = "<C-w>k",
				right = "<C-w>l",
			},
		})
	end,
}
