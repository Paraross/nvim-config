vim.g.mapleader = " "
-- tabs
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, {})
vim.keymap.set("n", "<leader>tq", vim.cmd.tabclose, {})
vim.keymap.set("n", "<leader>tt", ":tab split<CR>", {})
vim.keymap.set("n", "<S-PageUp>", ":tabmove -1<CR>", {})
vim.keymap.set("n", "<S-PageDown>", ":tabmove +1<CR>", {})
-- highlighting
vim.keymap.set("n", "<leader>nh", vim.cmd.nohlsearch, {})
vim.keymap.set("n", "<leader>h", vim.lsp.buf.document_highlight, {})
vim.keymap.set("n", "<leader>H", vim.lsp.buf.clear_references, {})
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
