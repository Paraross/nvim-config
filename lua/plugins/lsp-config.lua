local function map_lsp_action(keys, func, event)
	vim.keymap.set("n", keys, func, { buffer = event.buf })
end

local function map_lsp_actions(event)
	local map = function(keys, func)
		map_lsp_action(keys, func, event)
	end

	local builtin = require("telescope.builtin")

	map("gd", builtin.lsp_definitions)
	map("grr", builtin.lsp_references)
	map("gri", builtin.lsp_implementations)
	map("grt", builtin.lsp_type_definitions)
	map("<leader>ds", builtin.lsp_document_symbols)
	map("<leader>ws", builtin.lsp_dynamic_workspace_symbols)
	map("gD", vim.lsp.buf.declaration)
end

local function configure_ts_ls_when_angularls_attached(client, event)
	-- disable ts_ls renaming, otherwise rename prompt appears twice
	if client.name == "ts_ls" then
		local angularls = vim.lsp.get_clients({ name = "angularls", bufnr = event.buf })[1]
		if angularls then
			client.server_capabilities.renameProvider = false
		end
	end

	if client.name == "angularls" then
		local ts_ls = vim.lsp.get_clients({ name = "ts_ls", bufnr = event.buf })[1]
		if ts_ls then
			ts_ls.server_capabilities.renameProvider = false
		end
	end
end

local function configure_inlay_hints(client, event)
	if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
		map_lsp_action("<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, event)
	end
end

local function configure_symbol_highlight_under_cursor(client, event)
	if not client.server_capabilities.documentHighlightProvider then
		return
	end

	local group = vim.api.nvim_create_augroup("highlight-symbol", { clear = false })

	vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.document_highlight,
	})
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.clear_references,
	})
end

local function configure_lsp_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			map_lsp_actions(event)

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if not client then
				return
			end

			configure_ts_ls_when_angularls_attached(client, event)
			configure_inlay_hints(client, event)
			configure_symbol_highlight_under_cursor(client, event)
		end,
	})
end

local function configure_web()
	vim.lsp.config["html"] = {
		on_attach = function(_, bufnr)
			vim.bo[bufnr].tabstop = 2
		end,
		filetypes = { "html", "htmlangular" },
	}

	vim.lsp.config["cssls"] = {
		on_attach = function(_, bufnr)
			vim.bo[bufnr].tabstop = 2
		end,
	}

	vim.lsp.config["ts_ls"] = {
		on_attach = function(_, bufnr)
			vim.bo[bufnr].tabstop = 2
		end,
	}

	vim.lsp.config["angularls"] = {
		on_attach = function(_, bufnr)
			if vim.bo[bufnr].filetype == "html" then
				vim.bo[bufnr].filetype = "htmlangular"
			end
		end,
	}
end

local function configure_lua_ls()
	vim.lsp.config["lua_ls"] = {
		on_attach = function(_, bufnr)
			vim.bo[bufnr].expandtab = false
		end,
	}
end

local function configure_rust_analyzer()
	local rust_analyzer_on_attach = vim.lsp.config["rust_analyzer"].on_attach
	vim.lsp.config["rust_analyzer"] = {
		on_attach = function(client, bufnr)
			rust_analyzer_on_attach(client, bufnr)
		end,
		cargo = {
			features = "all",
		},
		procMacro = {
			ignored = {
				leptos_macro = {
					"server",
				},
			},
		},
	}
end

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			configure_lsp_attach()

			configure_web()
			configure_lua_ls()
			configure_rust_analyzer()
		end,
	},
}
