" Plugin manager setup
call plug#begin('~/.vim/plugged')

" === Navigacija i struktura koda ===
Plug 'preservim/nerdtree' " File explorer unutar Vima
Plug 'majutsushi/tagbar' " Prikazuje strukturu klase/funkcija (ctags)

" === Glavni LSP i auto-completion plugin ===
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Sintaksno isticanje i linting ===
Plug 'sheerun/vim-polyglot' " Sintaksna podrška za više jezika
Plug 'ap/vim-css-color' " Prikazuje stvarne boje u CSS/HTML kodu
Plug 'cocopon/iceberg.vim' " Iceberg tema
Plug 'ryanoasis/vim-devicons' " Dodaje ikone u NERDTree i Vim

" === Automatsko zatvaranje tagova i zagrada ===
Plug 'alvan/vim-closetag' " Automatsko zatvaranje HTML/XML tagova
Plug 'jiangmiao/auto-pairs' " Automatsko zatvaranje zagrada i navodnika

" === Formatiranje i automatsko sređivanje koda ===
Plug 'prettier/vim-prettier' " Automatski formatira JS/TS/CSS kod

" === Web development ===
Plug 'mattn/emmet-vim' " Omogućava brzo HTML/CSS pisanje pomoću Emmet-a
Plug 'leafOfTree/vim-vue-plugin' " Poboljšana podrška za Vue.js
Plug 'lepture/vim-jinja' " Podrška za Jinja2 templating
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'} " Live Server za pregled u pregledniku
Plug 'https://github.com/wolandark/vim-live-server.git' " Pokreće live server unutar Vim-a


" === Backend development ===
Plug 'jmcantrell/vim-virtualenv' " Omogućava rad s Python virtualnim okruženjima
Plug 'fatih/vim-go' " Poboljšana podrška za Go jezik
Plug 'bfrg/vim-cpp-modern' " Poboljšano sintaksno isticanje za moderni C++

" === Markdown i dokumentacija ===
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' } " Live pregled Markdowna

" === Alati i pretraga ===
Plug 'junegunn/fzf.vim' " Brza pretraga datoteka i buffera
Plug 'nicwest/vim-http' " Slanje HTTP zahtjeva iz Vim-a
Plug 'francoiscabrol/ranger.vim' " Terminalski file manager unutar Vim-a
Plug 'tpope/vim-fugitive' " Napredna Git integracija

" === Poboljšanja za VIM interface ===
Plug 'vim-airline/vim-airline' " Napredna statusna traka
Plug 'vim-airline/vim-airline-themes' " Tematski dodaci za airline
call plug#end()

" === coc.nvim language servers setup ===
let g:coc_global_extensions = [
     \'coc-clangd',       
     \'coc-pyright',      
     \'coc-tsserver',    
     \'coc-eslint',      
     \'coc-prettier',    
     \'coc-vetur',       
     \'coc-html',         
     \'coc-css',          
     \'coc-json',         
     \'coc-sh',           
     \'coc-markdownlint'  
     \]
" Auto-format and fix on save
autocmd BufWritePre *.js,*.ts,*.vue :CocCommand eslint.executeAutofix
autocmd BufWritePre *.html,*.css,*.json,*.md :CocCommand prettier.formatFile
autocmd BufWritePre *.cpp,*.h,*.c :CocCommand clangd.applyFix
autocmd BufWritePre *.py :CocCommand python.sortImports
" Automatsko formatiranje Python koda prilikom spremanja
autocmd BufWritePre *.py :silent! !isort %
autocmd BufWritePre *.py :silent! !black % --quiet %
set autoread
autocmd FocusGained, BufEnter * checktime
autocmd BufWritePost *.py silent! edit


" Key mappings for coc.nvim
nmap <leader>d <Plug>(coc-definition)  " Jump to definition
nmap <leader>r <Plug>(coc-rename)      " Rename symbol
nmap <leader>f <Plug>(coc-format)      " Manual format
" <Enter> for trigger
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Run program based on file type
" Python
autocmd filetype python nnoremap <F5> :w<CR>:! clear;python %<CR>

" Javascript
autocmd filetype javascript nnoremap <F5> :w<CR>:! clear;node %<CR>

"Cpp
autocmd filetype cpp nnoremap <F5>:w<CR>:! clear;g++ % -o %< &&./%< <CR>


"Start Live Server
nnoremap <leader>ls :BraceyStart<CR>
nnoremap <leader>lq :BraceyStop<CR>

" === Vim Interface Enhancements ===
set background=dark
set termguicolors
colorscheme iceberg


" boilerplate for vue files(snippet)
nnoremap vue, :-1read $HOME/.vim/.boilerplate.vue<CR>5jwe4l

set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" postavljanje <Leader>
let mapleader = " "

set ts=4
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set cursorline
set cursorcolumn
set showmatch
" Provides tab-completion for all file-related tasks
" fuzzyfind
set path+=**
" Display all matching files when tabcomplete
set wildmenu
" set transparent background
hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE


" redefine the trigger key
let g:user_emmet_leader_key=','

" NERDTree bindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-t> :TagbarToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" no backup files
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
"airline tabs
let g:airline#extensions#tabline#enabled = 1

" vim VUE plugin config
let g:vim_vue_plugin_config = {
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 1,
      \'keyword': 1,
      \'foldexpr': 0,
      \'debug': 0,
      \}



" CloseTag setup
let g:closetag_filetypes = 'html,xhtml,htmx,vue'

" Start-Stop LiveServer
nmap <F2> :StartBrowserSync <CR>
nmap <F3> :KillBrowserSync <CR>

