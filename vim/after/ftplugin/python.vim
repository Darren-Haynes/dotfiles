""""""""""' SETTINGS '"""""""""
	       """"""""""
" python tabs, indentation etc
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
set autoindent
set fileformat=unix
set encoding=utf-8
set nocursorline


""""""""""' KEY BINDINGS '"""""""""
	        """""""""""

let maplocalleader = ","


" press tab in normal mode acts like insert mode
nnoremap <Tab> i<Tab>
" indent code on present line
nnoremap <localleader>i I<space><space><space><space><ESC>$
" deindent code on present line
nnoremap <localleader>d 04x$
" indent code on next line
nnoremap <localleader>1 j0i<Tab><ESC>$
" indent code on next 2 lines
nnoremap <localleader>2 j0i<Tab><ESC>j0i<Tab><ESC>$
" indent code on next 3 lines
nnoremap <localleader>3 j0i<Tab><ESC>j0i<Tab><ESC>j0i<Tab><ESC>$
" indent code  on next 4 lines
nnoremap <localleader>4 j0i<Tab><ESC>j0i<Tab><ESC>j0i<Tab><ESC>j0i<Tab><ESC>$

" backspace deletes 4 spaces in normal mode
nnoremap <BS> xxxx
" align square brackets
nnoremap <localleader>aB :Tabularize / [/l0<cr>


""""""""""' AUTO COMPLETION '"""""""""
	        """""""""""

" If name == main
nnoremap <localleader>main i<CR><CR>def<space>main():<CR>"""comment"""<CR><CR><CR><ESC>0iif<space>__name__<space>==<space>'__main__':<CR><tab>main()<ESC>?c<CR>A<CR>

" create empty list " = []"
"inoremap [[ <space>=<space>[]<esc>i
" create empty dict " = {}"
"inoremap {{ <space>=<space>{}<esc>i
" create empty set " = ()"
"inoremap (( <space>=<space>()<esc>i

" # -*- coding: utf-8 -*-
nnoremap <localleader>8 i# -*- coding: utf-8 -*-<CR><ESC>



""""""""""' RUN SCRIPTS '"""""""""
	        """""""""""

" Run python2 scripts
nnoremap <buffer> <F2> :exec '!python2' shellescape(@%, 1)<cr>

" Run python3 scripts
nnoremap <buffer> <F3> :exec '!python' shellescape(@%, 1)<cr>

" Quick run
nnoremap <localleader><space> :QuickRun<cr>

