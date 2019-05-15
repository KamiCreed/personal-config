set exrc
set secure

set ff=unix

" Set a colour when at the limit
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Mostly for tmux-resurrect
set nobackup noswapfile

set background=dark
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set path=.,,**

set autoread

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <F5> :tabdo exec 'windo e'<CR>

filetype plugin indent on

set makeprg=ninja\ -C\ ./build
nnoremap <F4> :make!<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Allow saving of files as sudo through `w!!` when one forgets to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

set splitbelow
set splitright
set cinoptions=l1
set cino+=g0 " Unindents public:, etc.

" Map // in visual mode to search highlighted text
vnoremap // y/<C-R>"<CR>

" Apply YCM FixIt
map <F9> :YcmCompleter FixIt<CR>

map <F6> :ClangFormat<CR>

" Use auto ClangFormat
autocmd FileType c,cpp,cc,hpp,h ClangFormatAutoEnable

" Map tag jumping in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" IndentLine config
let g:indentLine_char = '┆'
let g:indentLine_bgcolor_term = 255
let g:indentLine_bgcolor_gui = '#FF5F00'

" Prosession config
let g:prosession_tmux_title = 1

" Autodownload vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Session auto-saving
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" Language autocompletion (What language it autocompletes depends on how it is compiled)
Plug 'Valloric/YouCompleteMe'
" Generator for C++ YCM config
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Jenkinsfile syntax
Plug 'martinda/Jenkinsfile-vim-syntax'

Plug 'rhysd/vim-clang-format'

Plug 'Shougo/denite.nvim'

" Initialize plugin system
call plug#end()
