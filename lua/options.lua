-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- tabs, spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
-- shell
vim.opt.shell = "nu"
vim.opt.shellcmdflag = "-c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
-- other
vim.opt.showmode = false
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.gdefault = true
vim.opt.winborder = "single"

vim.diagnostic.config({
	virtual_text = { current_line = false },
	virtual_lines = false,
})
