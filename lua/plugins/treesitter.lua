return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "rust", "cpp", "asm" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			local select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					-- ["ab"] = "@block.outer",
					-- ["ib"] = "@block.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["a/"] = "@comment.outer",
				},
				-- 'v' - charwise (default), 'V' - linewise, '<c-v>' - blockwise
				selection_modes = {
					["@function.outer"] = "V",
					["@class.outer"] = "V",
				},
				include_surrounding_whitespace = false,
			}

			local move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]af"] = "@function.outer",
					["]if"] = "@function.inner",
					["]ac"] = "@class.outer",
					["]ic"] = "@class.inner",
					["]aa"] = "@parameter.outer",
					["]ia"] = "@parameter.inner",
					["]a/"] = "@comment.outer",
				},
				goto_next_end = {
					["]]af"] = "@function.outer",
					["]]if"] = "@function.inner",
					["]]ac"] = "@class.outer",
					["]]ic"] = "@class.inner",
					["]]aa"] = "@parameter.outer",
					["]]ia"] = "@parameter.inner",
					["]]a/"] = "@comment.outer",
				},
				goto_previous_start = {
					["[af"] = "@function.outer",
					["[if"] = "@function.inner",
					["[ac"] = "@class.outer",
					["[ic"] = "@class.inner",
					["[aa"] = "@parameter.outer",
					["[ia"] = "@parameter.inner",
					["[a/"] = "@comment.outer",
				},
				goto_previous_end = {
					["[[af"] = "@function.outer",
					["[[if"] = "@function.inner",
					["[[ac"] = "@class.outer",
					["[[ic"] = "@class.inner",
					["[[aa"] = "@parameter.outer",
					["[[ia"] = "@parameter.inner",
					["[[a/"] = "@comment.outer",
				},
				goto_next = {
					["]f"] = { query = { "@function.outer", "@function.inner" } },
					["]c"] = { query = { "@class.outer", "@class.inner" } },
					["]a"] = { query = { "@parameter.outer", "@parameter.inner" } },
					["]/"] = { query = { "@comment.outer", "@comment.inner" } },
				},
				goto_previous = {
					["[f"] = { query = { "@function.outer", "@function.inner" } },
					["[c"] = { query = { "@class.outer", "@class.inner" } },
					["[a"] = { query = { "@parameter.outer", "@parameter.inner" } },
					["[/"] = { query = { "@comment.outer", "@comment.inner" } },
				},
			}

			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = select,
					move = move,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
