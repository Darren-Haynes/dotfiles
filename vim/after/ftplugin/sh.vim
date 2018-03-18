""""""""""' SETTINGS '"""""""""
	       """"""""""
"css tabs, indentation etc
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=79
set formatoptions=qrn1
set autoindent smartindent
set fileformat=unix

let maplocalleader = ","

"""""""""' ABBREVIATION '""""""

" indent code on present line
nnoremap <localleader>i I<Tab><ESC>$

" tab in normal mode acts like tab i insert mode
nnoremap <Tab> i<Tab>

