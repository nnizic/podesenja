return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" }, -- lazy load LSP
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false }, -- Mason učitava se odmah
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- =============================================
			-- 0. Helpers
			-- =============================================
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)

				if client.supports_method("textDocument/formatting") then
					local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end

			-- =============================================
			-- 1. Mason
			-- =============================================
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls",
					"vue_ls",
					"clangd",
				},
				automatic_installation = true,
			})

			-- =============================================
			-- 2. Diagnostic UI (future-proof)
			-- =============================================
			vim.diagnostic.config({
				virtual_text = { spacing = 4, prefix = "●" },
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Signs (deprecated define ignored, vim.diagnostic.config koristi ih automatski)
			local signs = { Error = "", Warn = "", Info = "", Hint = "󰌵" }
			for type, icon in pairs(signs) do
				vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "Diagnostic" .. type, numhl = "" })
			end

			-- =============================================
			-- 3. LSP configs
			-- =============================================
			vim.lsp.config.lua_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			}

			vim.lsp.config.pyright = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.ts_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			vim.lsp.config.vue_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "vue" },
				init_options = {
					typescript = {
						tsdk = vim.fn.stdpath("data")
							.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
					},
				},
			}

			vim.lsp.config.clangd = {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
				root_dir = function(fname)
					return vim.fs.root(fname, { "compile_commands.json", "compile_flags.txt", ".git" })
				end,
			}

			-- =============================================
			-- 4. Start svi instalirani serveri
			-- =============================================
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				local cfg = vim.lsp.config[server_name]
				if cfg then
					vim.lsp.start(cfg)
				end
			end
		end,
	},
}
