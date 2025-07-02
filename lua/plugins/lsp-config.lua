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
				ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "zls", "clangd" },
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
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")
					map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
					map("<leader>gr", builtin.lsp_references, "[G]oto [R]eferences")
					map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
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

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			-- TODO: tabs instead of spaces
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_init = function()
					vim.keymap.set("n", "<leader>bb", "<CMD>!cargo build<CR>", {})
					vim.keymap.set("n", "<leader>br", "<CMD>!cargo run<CR>", {})
					vim.keymap.set("n", "<leader>Bb", "<CMD>!cargo build --release<CR>", {})
					vim.keymap.set("n", "<leader>Br", "<CMD>!cargo run --release<CR>", {})
					vim.keymap.set("n", "<leader>bl", "<CMD>!cargo clippy<CR>", {})
					vim.keymap.set("n", "<leader>bt", "<CMD>!cargo test<CR>", {})
					vim.keymap.set("n", "<leader>bc", "<CMD>!cargo clean<CR>", {})
				end,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_init = function()
					vim.keymap.set("n", "<leader>bb", "<CMD>!go build<CR>", {})
					vim.keymap.set("n", "<leader>br", "<CMD>!go run .<CR>", {})
					vim.keymap.set("n", "<leader>bt", "<CMD>!go test<CR>", {})
				end,
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
		end,
	},
}
