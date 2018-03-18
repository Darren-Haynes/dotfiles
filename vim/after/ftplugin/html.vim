

""""""""""' SETTINGS '"""""""""
	       """"""""""
" html tabs, indentation etc
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set autoindent
set colorcolumn=0
set fileformat=unix
set encoding=utf-8
set nocursorline

if has('gui_running')
  colorscheme base16-bespin
endif

let maplocalleader = ","

" deindent code on present line
nnoremap <localleader>d 02x$
