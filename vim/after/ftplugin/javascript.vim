if has('gui_running')
  colorscheme base16-spacemacs
endif

""""""""""' SETTINGS '"""""""""
	       """"""""""
" javascript tabs, indentation etc
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80
set autoindent
set fileformat=unix
set nocursorline

let maplocalleader = ","

""""""""""' AUTO COMPLETION '"""""""""
	        """""""""""

" create empty list " = []"
inoremap [[ <space>=<space>[]<CR>
" create brace space
inoremap {{ <space>{<CR><CR>}<Esc>ki<space><space>
" create array loop starting with 0
inoremap 0ar for (var i = 0; i <  .length; i++) {<CR><CR>}<Esc>kk/ .l<CR>i
nnoremap <leader>0ar ifor (var i = 0; i <  .length; i++) {<CR><CR>}<Esc>kk/ .l<CR>i
" create array loop starting with 1
inoremap 1ar for (var i = 1; i <=  .length; i++) {<CR><CR>}<Esc>kk/ .l<CR>i

" insert semicolon at end of line
nnoremap <localleader>; A;<Esc>
" indent code on present line
nnoremap <localleader>i I<Tab><ESC>$

"console.log() insert mode
inoremap #co console.log();<Esc>hi
inoremap #nco <CR>console.log();<Esc>hi
inoremap #Nco <CR><CR>console.log();<Esc>hi
inoremap #pco <Esc>Oconsole.log();<Esc>hi
inoremap #Pco <Esc>O<Esc>Oconsole.log();<Esc><CR><Esc>kf)i

"console.log() normal mode
nnoremap <localleader>co iconsole.log();<Esc>hi
nnoremap <localleader>nco oconsole.log();<Esc>hi
nnoremap <localleader>pco Oconsole.log();<Esc>hi
nnoremap <localleader>Nco o<Esc>oconsole.log();<Esc>hi
nnoremap <localleader>Pco O<Esc>Oconsole.log();<Esc>hi

nnoremap <leader>1ar ifor (var i = 1; i <=  .length; i++) {<CR><CR>}<Esc>kk/ .l<CR>i

" backspace deletes 2 spaces in normal mode
nnoremap <BS> xx

" tab in normal mode acts like tab i insert mode
nnoremap <Tab> i<Tab>


" Quick run
nnoremap <localleader><space> :QuickRun<cr>

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
