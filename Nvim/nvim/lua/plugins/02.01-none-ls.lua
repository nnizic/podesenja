return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		-- ✨ Lakša čitljivost
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions

		null_ls.setup({
			sources = {
				-- 🔧 Formatters
				formatting.prettier.with({
					extra_filetypes = { "svelte", "astro", "vue" },
				}),
				formatting.stylua,
				formatting.isort,
				formatting.black,
				formatting.clang_format,

				-- 🩺 Diagnostics (iz none-ls-extras)
				require("none-ls.diagnostics.cpplint"),

				-- 🧩 Ostalo
				require("none-ls.formatting.jq"),
				require("none-ls.code_actions.eslint_d"),
			},

			-- 🔁 Autoformat on save (modern 0.11 safe)
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local augroup = vim.api.nvim_create_augroup("NullLsFormatting", { clear = false })
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = false })
						end,
					})
				end
			end,
		})
	end,
}
