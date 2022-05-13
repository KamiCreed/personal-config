set exrc
set secure

set ff=unix

set encoding=utf-8

" Set a colour when at the limit
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Mostly for tmux-resurrect
set nobackup noswapfile

set background=dark
set smarttab
set sts=4 sw=4 ts=4 et
autocmd FileType tf setlocal sw=2 sts=2 ts=2 et ai ff=unix
autocmd FileType tf setlocal sw=2 sts=2 ts=2 et ai
autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et ai
set path=.,,**

set autoread

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <F5> :tabdo exec 'windo e'<CR>

filetype plugin indent on

set makeprg=ninja\ -C\ ./build
nnoremap <F4> :make!<cr>

" Allow saving of files as sudo through `w!!` when one forgets to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

set splitbelow
set splitright
set cinoptions=l1
set cino+=g0 " Unindents public:, etc.

" Map // in visual mode to search highlighted text
vnoremap // y/<C-R>"<CR>
set spelllang=en_ca

" o/O                   Start insert mode with [count] blank lines.
"                       The default behavior repeats the insertion [count]
"                       times, which is not so useful.
function! s:NewLineInsertExpr( isUndoCount, command )
    if ! v:count
        return a:command
    endif

    let l:reverse = { 'o': 'O', 'O' : 'o' }
    " First insert a temporary '$' marker at the next line (which is necessary
    " to keep the indent from the current line), then insert <count> empty lines
    " in between. Finally, go back to the previously inserted temporary '$' and
    " enter insert mode by substituting this character.
    " Note: <C-\><C-n> prevents a move back into insert mode when triggered via
    " |i_CTRL-O|.
    return (a:isUndoCount && v:count ? "\<C-\>\<C-n>" : '') .
    \   a:command . "$\<Esc>m`" .
    \   v:count . l:reverse[a:command] . "\<Esc>" .
    \   'g``"_s'
endfunction
nnoremap <silent> <expr> o <SID>NewLineInsertExpr(1, 'o')
nnoremap <silent> <expr> O <SID>NewLineInsertExpr(1, 'O')


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

" Vimtex config
let g:tex_flavor = 'latex'

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" OmniSharp config

"" Use the stdio OmniSharp-roslyn server
"let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_server_use_mono = 1
"
"" Update semantic highlighting on BufEnter and InsertLeave
"let g:OmniSharp_highlight_types = 2
"
"" Tell ALE to use OmniSharp for linting C# files, and no other linters.
"let g:ale_linters = { 'cs': ['OmniSharp'] }
"
"augroup omnisharp_commands
"    autocmd!
"
"    " Show type information automatically when the cursor stops moving
"    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"
"    " The following commands are contextual, based on the cursor position.
"    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
"
"    " Finds members in the current buffer
"    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
"
"    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
"    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
"    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
"
"    " Navigate up and down by method/property/field
"    autocmd FileType cs nnoremap <buffer> <M-k> :OmniSharpNavigateUp<CR>
"    autocmd FileType cs nnoremap <buffer> <M-j> :OmniSharpNavigateDown<CR>
"
"    " Find all code errors/warnings for the current solution and populate the quickfix window
"    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
"augroup END
"
"" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
"nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
"" Run code actions with text selected in visual mode to extract method
"xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
"
"" Rename with dialog
"nnoremap <Leader>nm :OmniSharpRename<CR>
"nnoremap <F2> :OmniSharpRename<CR>

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
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Language autocompletion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Jenkinsfile syntax
Plug 'martinda/Jenkinsfile-vim-syntax'

Plug 'rhysd/vim-clang-format'

Plug 'Shougo/denite.nvim'

" C# IDE stuff
"Plug 'OmniSharp/omnisharp-vim'
"Plug 'w0rp/ale'

Plug 'tpope/vim-fugitive'

" Adds vim-like navigation with tmux
Plug 'christoomey/vim-tmux-navigator'

" Vim Latex
Plug 'lervag/vimtex'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }

" Initialize plugin system
call plug#end()
