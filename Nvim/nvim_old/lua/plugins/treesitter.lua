return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- Automatsko ažuriranje parsera ako koristiš Neovimovu verziju
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
