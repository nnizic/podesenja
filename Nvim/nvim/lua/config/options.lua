vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set cursorline")
vim.cmd("set cursorcolumn")

--Automatsko foramtirasnje pri spremanju
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

--Automatsko prebacivanje number i realtive number
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set relativenumber",
})

--Prozirna pozadina
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE

]])
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  command = "hi Normal guibg=NONE ctermbg=NONE | hi NonText guibg=NONE ctermbg=NONE",
})

-- Izvršavanje koda

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = [[nnoremap <buffer> <F5> :w<CR>:term python %<CR>i]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  command = [[nnoremap <buffer> <F5> :w<CR>:term node %<CR>i]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  command = [[nnoremap <buffer> <F5> :w<CR>:term g++ % -o %< && ./%< <CR>i]],
})
