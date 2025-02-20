return {
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- rad sa Treesitterom
			map_cr = true -- pritisnuto Enter automatski zatvara parove
		})
	end,
}
