return {
  "preservim/tagbar",
  config = function()
    vim.g.tagbar_autofocus = 1 -- Automatski fokusira Tagbar kada se otvori
    vim.g.tagbar_width = 30     -- Postavlja širinu prozora
    vim.g.tagbar_sort = 0       -- Isključuje sortiranje po abecedi (prikazuje kako se pojavljuju)
    vim.api.nvim_set_keymap("n", "<C-t>", ":TagbarToggle<CR>", { noremap = true, silent = true }) -- ctrl+t za otvaranje/zatvaranje
  end
}
