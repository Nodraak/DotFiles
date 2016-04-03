
" au = autocmd
" hi = highlight

syntax on
filetype plugin indent on

set encoding=utf-8              " The encoding displayed.
set fileencoding=utf-8          " The encoding written to file.
set title                       " Set the title of the window in the terminal to the file
set mouse=a                     " enable mouse support
set ruler                       " Show row and column ruler information
set number                      " Line numbers on
set cursorline
set laststatus=2                " Always show the statusline
set cmdheight=2                 " Make the command area two lines high
set virtualedit=onemore         " Allow the cursor to move just past the end of the line
set colorcolumn=80,120          " color 80th and 120th columns
set scrolloff=5                 " Keep 5 lines below the last line when scrolling
set sidescrolloff=15
set showtabline=2               " always show window tabs
set updatetime=500

set expandtab                   " convert tabs to spaces
set tabstop=4                   " stops in a tab
set shiftwidth=4                " width of indent
set softtabstop=4               " Number of spaces per Tab
set autoindent                  " Auto-indent new lines
set smartindent
set smarttab
set cindent                     " Use 'C' style program indenting
set nowrap                      " Line wrapping off
set showmatch                   " show matching {} and [] and ()
set backspace=indent,eol,start  " The normal behaviour of backspace

" Status line
set statusline=
set statusline+=%<\                 " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\  " buffer number, and flags
set statusline+=%f\                 " relative path
set statusline+=%=                  " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\          " file type
set statusline+=%10(L(%l/%L)%)\     " line
set statusline+=%2(C(%v/125)%)\     " column
set statusline+=%P                  " percentage of file
set statusline+=%#warningmsg#
set statusline+=%*

" custom folder for swap files
let myVimDir = expand("$HOME/.vim")
let mySwapDir = myVimDir . '/swap'
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir,'p')
  endif
endfunction
call EnsureDirExists(myVimDir)
call EnsureDirExists(mySwapDir)
let &directory = mySwapDir

"""""
" Misc
"""""
set pastetoggle=<F12>                   " disable autoindent (for pasting)
au FileType make setlocal noexpandtab   " for makefile, no expand tab
au BufReadPost .bash_aliases set syntax=sh

map q: :q " Stop that stupid window from popping up


"""""
" pathogen (vim plugins)
"""""
execute pathogen#infect()

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_escape_grep = 1  " use original grep, not the user's aliase

source ~/.vim/minivim_keybindings.vim
source ~/.vim/minivim_color_statusbar.vim
