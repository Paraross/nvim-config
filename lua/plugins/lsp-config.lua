local function configure_lsp_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			local builtin = require("telescope.builtin")
			map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
			map("grr", builtin.lsp_references, "[G]oto [R]eferences")
			map("gri", builtin.lsp_implementations, "[G]oto [I]mplementation")
			map("grt", builtin.lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("<leader>h", vim.lsp.buf.document_highlight, "")
			map("<leader>H", vim.lsp.buf.clear_references, "")

			local client = vim.lsp.get_client_by_id(event.data.client_id)

			-- The following autocommand is used to enable inlay hints
			if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})
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

			configure_lua_ls()
			configure_rust_analyzer()
		end,
	},
}
