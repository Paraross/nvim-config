return {
	"gbprod/substitute.nvim",
	config = function()
		require("substitute").setup({
			on_substitute = nil,
			yank_substituted_text = false,
			preserve_cursor_position = false,
			modifiers = nil,
			highlight_substituted_text = {
				enabled = true,
				timer = 500,
			},
			range = {
				prefix = "s",
				prompt_current_text = false,
				confirm = false,
				complete_word = false,
				subject = nil,
				range = nil,
				suffix = "",
				auto_apply = false,
				cursor_position = "end",
			},
			exchange = {
				motion = false,
				use_esc_to_cancel = true,
				preserve_cursor_position = false,
			},
		})

		local chuj = require("substitute")

		vim.keymap.set("n", "s", chuj.operator, { noremap = true })
		vim.keymap.set("n", "ss", chuj.line, { noremap = true })
		vim.keymap.set("n", "S", chuj.eol, { noremap = true })
		vim.keymap.set("x", "s", chuj.visual, { noremap = true })
	end,
}
