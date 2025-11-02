return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	-- Globalni keybind za otvaranje/zatvaranje Neo-tree-a
	vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree toggle<CR>", { noremap = true, silent = true }),
	-- Osvježavanje nakon spremanja
}
