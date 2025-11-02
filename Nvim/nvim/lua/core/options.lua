-- ====================================================
-- FINALNI OPTIONS.LUA (Neovim 0.11+)
-- ====================================================

local opt = vim.opt

-- ====================================================
-- OSNOVNE POSTAVKE
-- ====================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.wrap = false

-- ====================================================
-- INDENTATION (Važno za Vue/JS/Python/C++)
-- ====================================================
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- ====================================================
-- CMP / AUTOCOMPLETE
-- ====================================================
opt.completeopt = "menu,menuone,noselect"

-- ====================================================
-- DIJAGNOSTIKA (0.11 future-proof)
-- ====================================================
local signs = { Error = " ", Warn = " ", Info = " ", Hint = "󰌵 " }
for type, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. type, {
		text = icon,
		texthl = "Diagnostic" .. type,
		numhl = "",
	})
end

vim.diagnostic.config({
	virtual_text = { spacing = 4, prefix = "●" },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- ====================================================
-- AUTOFORMAT PRI SPREMANJU
-- ====================================================
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local ok, _ = pcall(vim.lsp.buf.format, { async = false })
		if not ok then
			return
		end
	end,
})

-- ====================================================
-- DYNAMIC RELATIVENUMBER
-- ====================================================
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set relativenumber" })

-- ====================================================
-- PROZIRNA POZADINA
-- ====================================================
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
]])
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd("hi Normal guibg=NONE ctermbg=NONE | hi NonText guibg=NONE ctermbg=NONE")
	end,
})

-- ====================================================
-- QUICK RUN ZA ODREĐENE FILETYPEOVE (F5)
-- ====================================================
local function map_run(ft, cmd)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		callback = function()
			vim.keymap.set("n", "<F5>", cmd, { buffer = true })
		end,
	})
end

map_run("python", ":w<CR>:term python3 %<CR>i")
map_run("javascript", ":w<CR>:term node %<CR>i")
map_run("cpp", ":w<CR>:term g++ % -o %< && ./%< <CR>i")
