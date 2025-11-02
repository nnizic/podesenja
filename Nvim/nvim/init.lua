-- Postavi mapleader prije učitavanja bilo čega
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Postavi putanju do lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- preporučena stabilna verzija
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Učitaj osnovne postavke
require("core.options")
require("core.keymaps")

-- Učitaj lazy i sve plugine iz lua/plugins/
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
  },
})
