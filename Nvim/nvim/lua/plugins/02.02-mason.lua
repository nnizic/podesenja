return {
	{
		"mason-org/mason.nvim",
		lazy = false, -- odmah load, :Mason komanda dostupna odmah
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false, -- odmah load, veže se na mason.nvim
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "vue_ls" },
				automatic_installation = true,
			})
		end,
	},
}
