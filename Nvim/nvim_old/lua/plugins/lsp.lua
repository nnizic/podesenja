return {
	-- 🧱 Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- 🔗 Mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls",
					"clangd",
					"vue_ls", -- ✅ točan naziv za novi API
				},
				automatic_installation = true,
			})
		end,
	},

	-- ⚙️ LSP konfiguracija
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)

				-- automatsko formatiranje pri spremanju
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

			-- dodaj Mason bin u PATH
			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
				vim.env.PATH = vim.env.PATH .. ":" .. mason_bin
			end

			-- ========================
			-- 💡 pojedinačni serveri
			-- ========================

			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			}

			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				capabilities = capabilities,
				on_attach = on_attach,
			}

			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_dir = function(fname)
					return vim.fs.dirname(
						vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { upward = true })[1]
					)
				end,
			}
			-- Vue (Volar)
			vim.lsp.config.vue_ls = {
				cmd = { "vue-language-server", "--stdio" },
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "vue", "typescript", "javascript" },
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(
						"package.json",
						"tsconfig.json",
						"jsconfig.json",
						".git"
					)(fname) or vim.fn.getcwd()
				end,
				init_options = {
					typescript = {
						tsdk = vim.fn.stdpath("data")
							.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
					},
					vue = {
						hybridMode = true, -- stavi true ako koristiš <script setup>
					},
				},
			}

			vim.lsp.config.clangd = {
				cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = function(fname)
					return vim.fs.dirname(
						vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git" }, { upward = true })[1]
					)
				end,
			}

			-- ========================
			-- 🔁 Pokretanje svih instaliranih servera
			-- ========================
			local mason_lspconfig = require("mason-lspconfig")

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				local cfg = vim.lsp.config[server_name]
				if cfg then
					vim.lsp.start(cfg)
				end
			end
		end,
	},
}
