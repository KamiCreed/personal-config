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
set spelllang=en_ca

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
let g:prosession_tmux_title_format = "@@@"

" OmniSharp config

" Use the stdio OmniSharp-roslyn server
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1

" Update semantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

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

" C# IDE stuff
Plug 'OmniSharp/omnisharp-vim'
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()
