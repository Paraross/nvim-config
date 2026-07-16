return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local languages = { "lua", "rust", "json", "markdown", "markdown_inline" }

			require("nvim-treesitter").install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
					selection_modes = {
						["@function.outer"] = "v",
						["@class.outer"] = "V",
					},
				},
				move = {
					set_jumps = true,
				},
			})

			-- mappings

			local ts_select = require("nvim-treesitter-textobjects.select")
			local ts_move = require("nvim-treesitter-textobjects.move")

			local select_modes = { "x", "o" }
			local move_modes = { "n", "x", "o" }

			local next_start_prefix = "]"
			local next_end_prefix = "]]"
			local previous_start_prefix = "["
			local previous_end_prefix = "[["

			local outer_mapping_prefix = "a"
			local inner_mapping_prefix = "i"

			local function set_textobject_mappings(mapping, textobject)
				vim.keymap.set(select_modes, mapping, function()
					ts_select.select_textobject(textobject, "textobjects")
				end)

				vim.keymap.set(move_modes, next_start_prefix .. mapping, function()
					ts_move.goto_next_start(textobject, "textobjects")
				end)
				vim.keymap.set(move_modes, next_end_prefix .. mapping, function()
					ts_move.goto_next_end(textobject, "textobjects")
				end)
				vim.keymap.set(move_modes, previous_start_prefix .. mapping, function()
					ts_move.goto_previous_start(textobject, "textobjects")
				end)
				vim.keymap.set(move_modes, previous_end_prefix .. mapping, function()
					ts_move.goto_previous_end(textobject, "textobjects")
				end)
			end

			local function set_full_textobject_mappings(short_mapping, textobject)
				local outer_mapping = outer_mapping_prefix .. short_mapping
				local inner_mapping = inner_mapping_prefix .. short_mapping
				local outer_textobject = "@" .. textobject .. ".outer"
				local inner_textobject = "@" .. textobject .. ".inner"

				set_textobject_mappings(outer_mapping, outer_textobject)
				set_textobject_mappings(inner_mapping, inner_textobject)

				vim.keymap.set(move_modes, next_start_prefix .. short_mapping, function()
					ts_move.goto_next({ outer_textobject, inner_textobject }, "textobjects")
				end)
				vim.keymap.set(move_modes, previous_start_prefix .. short_mapping, function()
					ts_move.goto_previous({ outer_textobject, inner_textobject }, "textobjects")
				end)
			end

			set_full_textobject_mappings("f", "function")
			set_full_textobject_mappings("c", "class")
			set_full_textobject_mappings("a", "parameter")
			set_full_textobject_mappings("l", "loop")

			set_textobject_mappings("a/", "@comment.outer")

			-- repeat move

			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			vim.keymap.set(move_modes, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set(move_modes, ",", ts_repeat_move.repeat_last_move_opposite)

			vim.keymap.set(move_modes, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set(move_modes, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set(move_modes, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set(move_modes, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
}
