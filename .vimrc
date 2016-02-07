
" au = autocmd
" hi = highlight

syntax on
filetype plugin indent on

set ruler               " Show row and column ruler information
set laststatus=2 	    " Always show the statusline
set cmdheight=2 	    " Make the command area two lines high
set encoding=utf-8
set title 		        " Set the title of the window in the terminal to the file
set cursorline

set tabstop=4	        " stops in a tab
set shiftwidth=4        " width of indent
set expandtab	        " convert tabs to spaces
set autoindent          " Auto-indent new lines
set smartindent
set smarttab
set cindent             " Use 'C' style program indenting
set nowrap 		        " Line wrapping off
set showmatch	        " show matching {} and [] and ()
set softtabstop=4       " Number of spaces per Tab
set backspace=indent,eol,start  " Backspace behaviour

set number 		        " Line numbers on
set colorcolumn=80,120  " color 80th and 120th columns
set scrolloff=5         " Keep 5 lines below the last line when scrolling
set mouse=a		        " enable mouse support

" Status line
set statusline=
set statusline+=%<\ " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\ " buffer number, and flags
set statusline+=%f\ " relative path
set statusline+=%= " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\ " file type
set statusline+=%10(L(%l/%L)%)\ " line
set statusline+=%2(C(%v/125)%)\ " column
set statusline+=%P " percentage of file
set statusline+=%#warningmsg#
set statusline+=%*

"""""
" Pimping colors
"""""
hi User1 gui=NONE ctermfg=White ctermbg=DarkGray guifg=#a7dfff guibg=#333333 " File name
hi User2 gui=NONE ctermfg=LightRed ctermbg=DarkGray guifg=#ff9999 guibg=#333333 " File Flag
hi User3 gui=NONE ctermfg=White ctermbg=DarkGray guifg=#ffffff guibg=#333333 " File type
hi User4 gui=NONE ctermfg=Green ctermbg=DarkGray guifg=#90ff90 guibg=#333333 " Fugitive
hi User5 gui=NONE ctermfg=LightYellow ctermbg=DarkGray guifg=#ffffa0 guibg=#333333 " RVM
hi User6 gui=NONE ctermfg=White ctermbg=DarkRed guifg=#ffffff guibg=#af0000 " Syntax Errors
hi User7 gui=NONE ctermfg=White ctermbg=Yellow guifg=#ffff00 guibg=#333333
hi User8 gui=NONE ctermfg=Magenta ctermbg=DarkGray guifg=#99a0f9 guibg=#333333 " Position

" Show trailing Whitespaces
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
hi ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

"""""
" Misc
"""""
set pastetoggle=<F12>  " disable autoindent (for pasting)
au FileType make setlocal noexpandtab " for makefile, no expand tab
au BufReadPost .bash_aliases set syntax=sh

" Stop that stupid window from popping up
map q: :q

"""""
" pathogen (vim plugins)
"""""
execute pathogen#infect()

set updatetime=250
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_escape_grep = 1  " use original grep, not the user's aliase

