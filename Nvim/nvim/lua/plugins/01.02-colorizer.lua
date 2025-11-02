return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			"*", -- omoguava sve filetyove
			css = { rgb_fn = true, hsl_fn = true, names = true },
			html = { names = true },
			lua = { names = true },
			python = { names = true },
			kivy = { names = true, rgb_fn = true, hslfn = true },
		}, {
			mode = "background",
			names = true,
			RRGGBBAA = true, -- globalna aktivacija podrške za alpha
		})
	end,
}
