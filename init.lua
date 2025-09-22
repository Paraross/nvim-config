-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

-- setup
require("options")
require("keymaps")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		-- vim.highlight.on_yank()
		vim.highlight.on_yank({ higroup = "Search", timeout = 350 })
	end,
})

require("lazy").setup("plugins", opts)
