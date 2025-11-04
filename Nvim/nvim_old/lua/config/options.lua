-- Vodič i osnovne opcije
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true  -- 🔧 omogućava true-color za colorizer i teme

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Automatsko formatiranje pri spremanju
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    pcall(function()
      vim.lsp.buf.format({ async = false })
    end)
  end,
})

-- Automatsko prebacivanje number / relativenumber
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set relativenumber",
})

-- Dijagnostika (greške, upozorenja itd.)
vim.diagnostic.config({
  virtual_text = true,    -- prikaz teksta uz liniju koda
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Prozirna pozadina
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
]])

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  command = "hi Normal guibg=NONE ctermbg=NONE | hi NonText guibg=NONE ctermbg=NONE",
})

-- Izvršavanje koda ovisno o jeziku
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = [[nnoremap <buffer> <F5> :w<CR>:term python3 %<CR>i]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  command = [[nnoremap <buffer> <F5> :w<CR>:term node %<CR>i]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  command = [[nnoremap <buffer> <F5> :w<CR>:term g++ % -o %< && ./%< <CR>i]],
})

