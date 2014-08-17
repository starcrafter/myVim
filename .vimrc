call pathogen#infect()

" keep buffer list when exit vim
set viminfo^=%

" Basics {
    syntax on
    set nocompatible        " turn off vi-compatible mode
    set noexrc              " don't use local version of .(g)vimrc, .exrc
    set background=dark     " blue shows much better
    set tabpagemax=50
" }

" Vim UI {
    colorscheme desert
    " the following lines explicitly define status line coloring when splitting
    hi StatusLine term=reverse ctermfg=2 ctermbg=white gui=bold,reverse
    hi StatusLineNC term=reverse ctermfg=black ctermbg=darkyellow cterm=none
    set cursorline
    set incsearch           " incremental search
    set hlsearch            " highlighting when searching
    set laststatus=2        " always show status line
    set linespace=0         " don't insert extra pixel lines between rows
    set listchars=tab:>-,trail:-  " show tabs and trailing
    set nostartofline   " leave cursor in current position
    set number        " turn on line numbers
    " set numberwidth=5   " 5 digits displayed for line numbers (0-99999)
    set report=0      " report anything changed with :...
    set ruler       " show current position along bottom
    set scrolloff=10    " keep 10 lines (top/bottom) in view for scope
    set showcmd       " show command being typed
    set showmatch     " show matching brackets
    set sidescrolloff=10  " keep 5 lines at size
    set statusline=%F%m%r%h%w\ %=[C%v,L%l/%L]
    "              |                         | | | |   |   |   |  + total lines
    "              |                         | | | |   |   |   + current line
    "              |                         | | | |   |   + current column
    "              |                         | | | |   + right align rest of status
    "              |                         | | | +-- preview flag in square brackets
    "              |                         | | +-- help flag in square brackets
    "              |                         | +-- readonly flag in square brackets
    "              |                         +-- modified flag in square brackets
    "              +-- full path to file in the buffer
" }

" Text Formatting/Layout {
    set autoindent              " repeat current indent level in next line
    " filetype on
    filetype plugin on
    set expandtab               " turn tabs into spaces...
    if has("autocmd")           " ... except in Makefiles
      au BufRead,BufNewFile Makefile* set noexpandtab
      autocmd FileType php set shiftwidth=2|set expandtab
      autocmd BufNewFile,BufRead *.as setfiletype javascript
    endif
    set ignorecase              " case insensitive
    set infercase               " cased inferred
    set smartcase               " if there are caps, go case-sensitive
    set shiftwidth=2
    set expandtab
    set tabstop=2
    set softtabstop=2
    set backspace=2
    set textwidth=80
    set formatoptions+=cro      " auto comment headers
" }
"
" Folding {
    set foldenable              " turn on folding
    set foldmarker={,}          " fold C style code
    set foldmethod=indent       " fold on indent
    set foldlevel=100           " don't autofold
    set foldopen=block,hor,mark,percent,quickfix,tag    " these open folds
"}

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
\ autocmd BufWritePre <buffer>
\ :call <SID>StripTrailingWhitespaces()

au Filetype html,xml,xsl,php,phpt source ~/.vim/scripts/closetag.vim

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=5 ctermbg=white gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine ctermfg=2 ctermbg=white gui=bold,reverse
  au InsertLeave * hi StatusLineNC term=reverse ctermfg=black ctermbg=darkyellow cterm=none
endif

" window switching
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

" Taglist-related
set tags=tags;/
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap <c-u> :TlistToggle

" let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1 "if taglist window is the only window left, exit vim
let Tlist_Show_Menu = 1 "show Tags menu in gvim
let Tlist_Show_One_File = 1 "show tags of only one file
let Tlist_Sort_Type = "name"
let Tlist_WinWidth = 40
let tlist_php_settings = 'php;c:class;f:function'

" 
nmap <S-q> : TW<CR>
set mouse-=a

" show history
nnoremap <c-n> :MRU

" disable paren match for confusion
let loaded_matchparen = 1 

" block comments
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>
vnoremap // :s/^/\/\//<cr>
vnoremap -// :s/^\/\///<cr>

" copy and paste
xnoremap p "_dP

" easy tag: disable auto highlight
let g:easytags_on_cursorhold = 0
let g:easytags_autorecurse = 0
let g:easytags_auto_highlight = 0
let g:easytags_always_enabled = 0
let g:easytags_resolve_links = 1

" syntastic
let g:syntastic_auto_loc_list = 1
