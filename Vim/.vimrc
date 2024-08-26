set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'lepture/vim-jinja'
Plugin 'dense-analysis/ale'
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'farfanoide/vim-kivy'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'cocopon/iceberg.vim'
Plugin 'prettier/vim-prettier'
Plugin 'bfrg/vim-cpp-modern'
Plugin 'wolandark/vim-live-server.git'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'fatih/vim-go'
Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'mattn/emmet-vim'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ap/vim-css-color'
Plugin 'vifm/vifm.vim'
" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" enable syntax highlighting
syntax enable

" set colorscheme
set background=dark
colorscheme iceberg

" show line numbers
" hybrid line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" intelligent indentation for C
set smartindent

" Search down in subolders
" Provides tab-completion for all file-related tasks
" fuzzyfind
set path+=**

" Display all matching files when tabcomplete
set wildmenu


" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" boilerplate for vue files(snippet)
nnoremap vue, :-1read $HOME/.vim/.boilerplate.vue<CR>5jwe4l



" omnicomplete
" autocmd FileType vue set omnifunc=syntaxcomplete#Complete

function! s:setCompeteFunc()
  if searchpair('<script', '', '</script>', 'bnW')
    setlocal omnifunc=javascriptcomplete#CompleteJS
  elseif searchpair('<style', '', '</style>', 'bnW')
    setlocal omnifunc=csscomplete#CompleteCSS
  elseif searchpair('<template', '', '</template>', 'bnW')
    setlocal omnifunc=htmlcomplete#CompleteTags
  endif
endfunction

augroup vueBinds
  au!
  au CursorMoved,CursorMovedI *.vue call s:setCompeteFunc()
augroup END



" enable all Python syntax highlighting features
let python_highlight_all = 1

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

" ALE linting
let b:ale_python_auto_virtualenv = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['prettier','black'],
            \ 'javascript': ['prettier', 'eslint'],
            \ 'css': ['prettier'],
            \ 'html': ['prettier', 'html-beautify'],
            \ 'cpp': ['prettier', 'astyle'],
            \ 'vue': ['prettier', 'eslint'],}
let g:ale_fix_on_save = 1
" redefine the trigger key
let g:user_emmet_leader_key=','
" file browser
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-t> :TagbarToggle<CR>

" no backup files
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" closetag filetypes
let g:closetag_filetypes = 'html,xhtml,htmx,vue'


" Python
autocmd filetype python nnoremap <F5> <Esc>:w<CR>:! clear;python %<CR>

" Javascript
autocmd filetype javascript nnoremap <F5> <Esc>:w<CR>:! clear;node %<CR>
"autocmd filetype javascript setlocal shiftwidth=2 tabstop=2

"Cpp
autocmd filetype cpp nnoremap <F5> <Esc>:w<CR>:! clear;g++ % -o %< &&./%< <CR>

"Start-Stop LiveServer
nmap <F2> :StartBrowserSync <CR>
nmap <F3> :KillBrowserSync <CR>
