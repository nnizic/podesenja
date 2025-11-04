return {
	"cocopon/iceberg.vim",
	priority = 1000, -- učitava se prije ostalih
	config = function()
		vim.cmd("colorscheme iceberg")
	end,
}
