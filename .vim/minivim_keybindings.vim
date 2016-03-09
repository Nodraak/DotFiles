" Helper functions

function! CreateShortcut(keys, cmd, where, ...)
  let keys = "<" . a:keys . ">"
  if a:where =~ "i"
    let i = (index(a:000,"noTrailingIInInsert") > -1) ? "" : "i"
    let e = (index(a:000,"noLeadingEscInInsert") > -1) ? "" : "<esc>"
    execute "imap " . keys . " " . e .  a:cmd . i
  endif
  if a:where =~ "n"
    execute "nmap " . keys . " " . a:cmd
  endif
  if a:where =~ "v"
    let k = (index(a:000,"restoreSelectionAfter") > -1) ? "gv" : ""
    let c = a:cmd
    if index(a:000,"cmdInVisual") > -1
      let c = ":<C-u>" . strpart(a:cmd,1)
    endif
    execute "vmap " . keys . " " . c . k
  endif
endfunction
function! TabIsEmpty()
    return winnr('$') == 1 && len(expand('%')) == 0 && line2byte(line('$') + 1) <= 2
endfunction
function! OpenLastBufferInNewTab()
    redir => ls_output
    silent exec 'ls'
    redir END
    let ListBuffers = reverse(split(ls_output, "\n"))
    for line in ListBuffers
      let title = split(line, "\"")[1]
      if title !~  "\[No Name"
        execute "tabnew +" . split(line, " ")[0] . "buf"
        break
      endif
    endfor
endfunction
function! OpenNetrw()
  if TabIsEmpty() == 1
    Explore
  else
    Texplore
  endif
endfunction

function! MenuNetrw()
  let c = input("What to you want to do? (M)ake a dir, Make a (F)ile, (R)ename, (D)elete : ")
  if (c == "m" || c == "M")
    normal d
  elseif (c == "f" || c == "F")
    normal %
  elseif (c == "r" || c == "R")
    normal R
  elseif (c == "d" || c == "D")
    normal D
  endif
endfunction

" Usefull shortcuts to enter insert mode
nnoremap <Enter> i<Enter>
nnoremap <Backspace> i<Backspace>
nnoremap <Space> i<Space>

" Ctrl F - Find
call CreateShortcut("C-f", ":/", "in", "noTrailingIInInsert")

" Ctrl H - Search and Replace
call CreateShortcut("C-h", ":%s/", "in", "noTrailingIInInsert")

" Ctrl T - New tab
call CreateShortcut("C-t", ":tabnew<enter>i", "inv", "noTrailingIInInsert", "cmdInVisual")

" Alt Right - Next tab
call CreateShortcut("A-Right", "gt", "inv")

" Alt Left - Previous tab
call CreateShortcut("A-Left", "gT", "inv")

" Ctrl O - Netrw (:Explore)
call CreateShortcut("C-o",":call OpenNetrw()<Enter>", "inv", "noTrailingIInInsert", "cmdInVisual")
let g:netrw_banner=0 " Hide banner
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' " Hide hidden files
autocmd filetype netrw call KeysInNetrw()
function! KeysInNetrw()
  " Right to enter
  nmap <buffer> <Right> <Enter>
  " Left to go up
  nmap <buffer> <Left> -
  " l - Display info
  nmap <buffer> l qf
  " n - Menu
  nmap <buffer> n :call MenuNetrw()<Enter>
endfunction

" :W - To write with root rights
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" :UndoCloseTab - To undo close tab
command UndoCloseTab call OpenLastBufferInNewTab()

