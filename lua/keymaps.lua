vim.g.mapleader = " "
vim.g.maplocalleader = " "
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

-- inserting a semicolon before a closing bracket puts it after the bracket if at the end of the line
SemiAfterBracket = true

vim.keymap.set("i", ";", function()
	if not SemiAfterBracket then
		return ";"
	end

	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local line_end = line:sub(col)

	-- if line_end:match("[%)%]%}]$") ~= nil then
	if line_end == ")" or line_end == "}" then
		return "<Right>;"
	end

	return ";"
end, { expr = true, noremap = true })

vim.keymap.set("n", "<leader>;", function()
	SemiAfterBracket = not SemiAfterBracket
	if SemiAfterBracket then
		vim.print("Semicolon after brackets ON")
	else
		vim.print("Semicolon after brackets OFF")
	end
end, {})
