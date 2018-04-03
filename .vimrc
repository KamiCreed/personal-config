set exrc
set secure

" Set a colour when at the limit
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

set background=dark
set shiftwidth=4
set tabstop=4
set noexpandtab
set path=.,,**

set autoread

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

filetype plugin indent on

set makeprg=make\ -C\ ../build
nnoremap <F4> :make!<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
set cinoptions=l1

" Apply YCM FixIt
map <F9> :YcmCompleter FixIt<CR>

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Session auto-saving
Plug 'tpope/vim-obsession'

" C++ autocomplete
Plug 'Valloric/YouCompleteMe'

" Initialize plugin system
call plug#end()
