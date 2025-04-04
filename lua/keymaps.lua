vim.g.mapleader = " "
-- tabs
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, {})
vim.keymap.set("n", "<leader>tq", vim.cmd.tabclose, {})
vim.keymap.set("n", "<leader>tt", "<CMD>tab split<CR>", {})
vim.keymap.set("n", "<C-S-PageUp>", "<CMD>tabmove -1<CR>", {})
vim.keymap.set("n", "<C-S-PageDown>", "<CMD>tabmove +1<CR>", {})
-- highlighting
vim.keymap.set("n", "<leader>nh", vim.cmd.nohlsearch, {})
-- diagnostics
vim.keymap.set("n", "<leader>dc", function()
	local current_virtual_text = vim.diagnostic.config().virtual_text.current_line
	vim.diagnostic.config({
		virtual_text = { current_line = not current_virtual_text },
	})
end)
vim.keymap.set("n", "<leader>dv", function()
	local current_virtual_lines = vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({
		virtual_lines = not current_virtual_lines,
	})
end)
-- missclick prevention
vim.keymap.set({ "n", "i", "v" }, "<C-m>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<C-f>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<C-b>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<Home>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<End>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<C-Home>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<C-End>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<PageUp>", "", {})
vim.keymap.set({ "n", "i", "v" }, "<PageDown>", "", {})
