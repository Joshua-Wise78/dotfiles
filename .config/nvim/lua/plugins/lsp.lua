return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"rust_analyzer",
					"pyright",
					"eslint",
					"emmet_ls",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"isort",
					"black",
					"prettierd",
					"prettier",
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set("n", "<S-d>", vim.diagnostic.goto_next, { desc = "LSP Next Diagnostic" })
			vim.keymap.set("n", "<S-u>", vim.diagnostic.goto_prev, { desc = "LSP Prev Diagnostic" })
		end,
	},
}
