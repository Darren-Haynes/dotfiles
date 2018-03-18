"          \ \   / /_ _|  \/  |  _ \ / ___|
"           \ \ / / | || |\/| | |_) | |
"            \ V /  | || |  | |  _ <| |___
"             \_/  |___|_|  |_|_| \_\\____|
"


""""""""""""""""""""""""""""""""""""""""""""""""""
               "VUNDLE
               "PLUGIN
               "MANAGER
""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " alternatively, pass a path where Vundle should install plugins call vundle#begin('~/some/path/here') let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

"""COLOR SCHEMES / STYLING"""
Plugin 'chriskempson/base16-vim'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'Matt-Deacalion/vim-systemd-syntax'

"""WINDOW MANAGEMENT"""
Plugin 'qpkorr/vim-bufkill'
Plugin 'wesQ3/vim-windowswap'

"""NAVIGATION"""
Plugin 'ctrlpvim/ctrlp.vim'

"""SEARCH / FIND"""
Plugin 'vim-scripts/SearchComplete'
Plugin 'jez/vim-superman'

"""VIEW"""
Plugin 'airblade/vim-gitgutter'
Plugin 'kshenoy/vim-signature'
Plugin 'lfv89/vim-interestingwords'

"""CODING PRODUCTIVITY"""
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/Pydiction'
Plugin 'yggdroot/indentline'

"""CODING TOOLS"""
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
Plugin 'thinca/vim-quickrun'
Plugin 'w0rp/ale'

"""GENERAL PRODUCTIVITY"""
Plugin 'vim-scripts/YankRing.vim'
Plugin 'chrisbra/Recover.vim'
Plugin 'christoomey/vim-system-copy'

"""PYTHON"""
Plugin 'davidhalter/jedi-vim'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'tweekmonster/django-plus.vim'

"""WEB DEVELOPMENT"""
Plugin 'jaxbot/browserlink.vim'

"""JAVASCRIPT"""
Plugin 'pangloss/vim-javascript'

"""HTML"""
Plugin 'mattn/emmet-vim'

call vundle#end()
filetype plugin indent on

""""""""""' COLOR SCHEME SETTINGS '"""""""""
        """""""""""""""""""""
syntax on
let base16colorspace=256
set background=dark
colorscheme spacemacs-theme
hi Normal guibg=NONE ctermbg=NONE
let g:airline_theme='base16_spacemacs'

""""""""""' PLUGIN SETTINGS '""""""""""
            """""""""""""""

" RAINBOW PARENTHESIS
let g:rainbow_active = 1
let g:rainbow_conf = {
    \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \	'operators': '_,_',
    \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \	'separately': {
    \		'*': {},
    \		'tex': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \		},
    \		'lisp': {
    \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \		},
    \		'vim': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \		},
    \		'html': {
    \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \		},
    \		'css': 0,
    \	}
    \}

 "Ultisnips settings
"let g:UltiSnipsSnippetsDir = "~/.vim/my_snippets"
"let g:UltiSnipsSnippetDirectories = ["UltiSnips", "my_snippets"]
"let g:UltiSnipsExpandTrigger = "<C-w>"
"let g:UltiSnipsListSnippets = "<C-l>"
"let g:UltiSnipsJumpForwardTrigger = "<C-b>"
"let g:UltiSnipsJumpBackwardTrigger = "<C-z>"
"let g:UltiSnipsEditSplit = "vertical"

let g:indentLine_setColors = 0 "show space indents use native colorscheme

"Show yankring
nnoremap <silent> <leader>yr :YRShow<CR> "Show yankring
let g:yankring_history_dir = '/home/darren/dotfiles/vim' "Set directory for yankring history file
"Quickrun
nnoremap <localleader><space> :QuickRun<cr>
" Swap split windows using swap-windows plugin
nnoremap <leader>sw <C-w>R

"TagBar
let g:tagbar_width = 35
let g:tagbar_indent = 1
let g:tagbar_compact = 1
let g:tagbar_zoomwidth = 0

" undo tree persistent undo
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:pydiction_location = '$HOME/.vim/bundle/Pydiction/complete-dict'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let NERDTreeIgnore=['db\.sqlite3$[[file]]', '\.pyc$[[file]]', '__pycache__$[[dir]]', 'migrations$[[dir]]', '__init__\.py$[[file]]']
let NERDTreeMinimalUI=1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"""""""""""""""""""""""""""""""""""""""""""""""""
                 "WILDIGNORE
""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu
set wildmode=list:longest

set wildignore+=*.pyc,
set wildignore+=migrations						 " Django migrations
set wildignore+=__pycache__						 " Py cache folder
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files



""""""""""' SETTINGS '""""""""""
            """"""""
set relativenumber
set scrolloff=5 "show 5 lines above/below cursor
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab "set expandtab #converts tabs to spaces
set shiftround "round indent to multiple of shiftwidth
set wrap
set formatoptions-=cro
set autoindent
set fileformat=unix
set foldlevel=99
"set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white
set splitright
set splitbelow
set history=500
set autochdir
set showbreak=↪
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set matchpairs+=<:> "especially handy for html
set noshowmode
" speed up esc key in terminal vim
set timeoutlen=1000 ttimeoutlen=0
highlight Comment cterm=italic "italicize code comments

au VimResized * exe "normal! \<c-w>="


""""""""""' NAVIGATION '"""""""""
           """"""""""""
"split screen navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" j,k move by screen line instead of file line
nnoremap j gj
nnoremap k gk

" return in normal mode like return in insert mode
nnoremap <CR> a<CR>

" show full path when using ctrl+g
nnoremap <C-G> 1<C-G>

""""""""""' EDITING FILES '"""""""""
            """""""""""""
vnoremap < <gv
vnoremap > >gv


""""""""""""""""""""""""""""""""""""""""""""""""""
                   "TOGGLE
                  "SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>tu :UndotreeToggle<cr>
nnoremap <leader>tg :GitGutterToggle<cr>
nnoremap <leader>tb :TagbarToggle<cr>
nnoremap <leader>ti :IndentLinesToggle<cr>
nnoremap <leader>tr :RainbowToggle<cr>
nnoremap <silent><leader>ta :ArgWrap<CR>
nnoremap <leader>tw :set wrap!<cr>
nnoremap <leader>tl :set list!<cr>
nnoremap <leader>tt :NERDTreeToggle<cr>

" Toggle relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <leader>tn :call NumberToggle()<CR>

" Toggle spell check with highlighting
set spell spelllang=en_us

hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal

function! ToggleSpell()
  if !exists("g:showingSpell")
    let g:showingSpell=0
  endif

  if g:showingSpell==0
    execute "hi SpellBad cterm=underline ctermfg=red"
    let g:showingSpell=1
  else
    execute "hi clear SpellBad"
    let g:showingSpell=0
  endif
endfunction
  :map <F5> :call ToggleSpell()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""
                    "LEADER
                     "KEY
                   "MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""

"Set leader key to spacebar. You know it makes sense
let mapleader = " "
"And set local leader
let localleader =  ","

"And use leader to source vimrc and ftplugins
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sa :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/python.vim<cr>/home/darren/.vim/after/ftplugin/javascript.vim<cr>:source /home/darren/.vim/after/ftplugin/css.vim<cr>:source /home/darren/.vim/after/ftplugin/html.vim<cr>
nnoremap <leader>sj :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/javascript.vim<cr>
nnoremap <leader>sp :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/python.vim<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/css.vim<cr>
nnoremap <leader>sh :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/html.vim<cr>
nnoremap <leader>ss :source $MYVIMRC<cr>:source /home/darren/.vim/after/ftplugin/sh.vim<cr>
"Plugin Install
nnoremap <leader>pi :PluginInstall<cr>


""""""""""' OPEN CONFIG FILES IN VERTICAL SPLITS '""""""""" "
            """"""""""""""""""""""""""""""""""""
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ep :vsplit ~/.vim/after/ftplugin/python.vim<cr>
nnoremap <leader>ej :vsplit ~/.vim/after/ftplugin/javascript.vim<cr>
nnoremap <leader>eh :vsplit ~/.vim/after/ftplugin/html.vim<cr>
nnoremap <leader>ec :vsplit ~/.vim/after/ftplugin/css.vim<cr>
nnoremap <leader>ea :vsplit ~/.aliases<cr>
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>ex :vsplit ~/.Xresources<cr>
nnoremap <leader>ei :vsplit ~/.config/i3/config<cr>
nnoremap <leader>eq :vsplit ~/.config/qutebrowser/qutebrowser.conf<cr>
nnoremap <leader>el :vsplit ~/dotfiles/vim/.leaderkeys_used.csv<cr>

" open helpfiles and all docs in vertical splits
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

""""""""""' MANAGE SPLITS '""""""""""
            """""""""""""
" make horizontal split full height
nnoremap <leader>ru <C-w><C-_>
" make vertical split full width
nnoremap <leader>rw <C-w>\|
" make split full screen (full width and height)
nnoremap <leader>rf <C-w><C-_><C-w>\|

" make splits equal size
nnoremap <leader>r= <C-w>=

" increase width by 5
nnoremap <leader>rl :vertical resize +5<cr>
" decrease width by 5
nnoremap <leader>rh :vertical resize -5<cr>
" increase height by 5
nnoremap <leader>rk :res +5<cr>
" decrease height by 5
nnoremap <leader>rj :res -5<cr>

" increase width by 1
nnoremap <leader>rL :vertical resize +1<cr>
" decrease width by 1
nnoremap <leader>rH :vertical resize -1<cr>
" increase height by 1
nnoremap <leader>rK :res +1<cr>
" decrease height by 1
nnoremap <leader>rJ :res -1<cr>


" make split width 80 col for python. Adjust for your screen
nnoremap <leader>rp :vertical resize 83<cr>

" make split width 3/4 ish
nnoremap <leader>r3v :vertical resize 113<cr>

" make split width 3/4 ish
nnoremap <leader>r3h :res 50<cr>

" Open new vertical split
nnoremap <leader>v :vsplit<cr>


""""""""""' CUT, COPY, PASTE & DELETE '"""""""""
            """""""""""""""""
" copy line to clipboard
nnoremap <leader>yy "+yy
" copy to end of line to clipboard
nnoremap <leader>yY "+y$
" copy word under cursor to clipboard
" caveat: doesn't work if cursor on first character of word
nnoremap <leader>yw b"+yee
" copy WORD under cursor to clipboard
" caveat: doesn't work if cursor on first character of WORD
nnoremap <leader>yW B"+yEE
" copy paragraph clipboard
nnoremap <leader>yp {"+y}}
" copy to end of paragraph to clipboard
nnoremap <leader>y} "+y}}
" copy to beginning of paragraph to clipboard
nnoremap <leader>y{ "+y{
" copy sentence to clipboard
nnoremap <leader>ys ("+y))
" copy from cursor to end of buffer to clipboard
nnoremap <leader>yG "+yG
" copy from cursor to beginning of buffer to clipboard
nnoremap <leader>ygg "+ygg
" copy buffer to clipboard
nnoremap <leader>yb gg"+yG

" paste from clipboard after cursor
nnoremap <leader>ph "+p
" paste clipboard at end of buffer
nnoremap <leader>pG Go<ESC>"+p
" paste clipboard at beginning of buffer
nnoremap <leader>pgg ggO<ESC>"+p
" paste clipboard on next line
nnoremap <leader>po o<ESC>"+p
" paste clipboard on previous line
nnoremap <leader>pO O<ESC>"+p
" paste clipboard after paragraph
nnoremap <leader>p} }"+p
" paste clipboard before paragraph
nnoremap <leader>p{ {"+po<Esc>
" paste clipboard after sentence
nnoremap <leader>p) )"+p
" paste clipboard before sentence
nnoremap <leader>p( ("+po<Esc>

"yank to end of line
nnoremap <leader>Y y$

" delete buffer
nnoremap <leader>db ggdG


""""""""""' BASH '"""""""""
            """"
nnoremap <leader>ls :!ls<cr>
nnoremap <leader>la :!ls -a<cr>
nnoremap <leader>ll :!ls -l<cr>


""""""""""' SURROUND '"""""""""
            """"""""
" insert brackets or quotes around current word
nnoremap <leader>ip viw<Esc>a)<esc>hbi(<esc>lel
nnoremap <leader>ib viw<Esc>a}<esc>hbi{<esc>lel
nnoremap <leader>iB viw<Esc>a]<esc>hbi[<esc>lel
nnoremap <leader>iq viw<Esc>a"<esc>hbi"<esc>lel
nnoremap <leader>is viw<Esc>a'<esc>hbi'<esc>lel
nnoremap <leader>it viw<Esc>a><esc>hbi<<esc>lel


" insert brackets or quotes around current WORD
nnoremap <leader>Ip viW<Esc>a)<esc>hBi(<esc>lEl
nnoremap <leader>Ib viW<Esc>a}<esc>hBi{<esc>lEl
nnoremap <leader>IB viW<Esc>a]<esc>hBi[<esc>lEl
nnoremap <leader>Iq viW<Esc>a"<esc>hBi"<esc>lEl
nnoremap <leader>Is viW<Esc>a'<esc>hBi'<esc>lEl
nnoremap <leader>It viW<Esc>a><esc>hBi<<esc>lEl


""""""""""' CREATE & REMOVE SPACE '""""""""""
            """""""""""""""""""""
"create empty line below cursor
nnoremap <leader><cr> o<Esc>
"remove trailing white space on all lines
nnoremap <leader>st :%s/\s\+$//e<cr>
" remove leading space on line
nnoremap <leader>sl :left<cr>


""""""""""' FUZZY FINDER '""""""""""
            """"""""""""
" list open buffers
nnoremap <leader>fo :CtrlPBuffer<cr>
" list files
nnoremap <leader>ff :CtrlP<cr>
" list dirs
nnoremap <leader>fd :CtrlP
" list all files recursively from present directory
nnoremap <leader>fa :CtrlPMixed<cr>


""""""""""' VIM FUGITIVE '""""""""""
            """"""""""""

nnoremap <leader>gs :Gstatus<cr><C-w><C-_>
nnoremap <leader>gp :Git push origin master<cr>
nnoremap <leader>gc :Git commit -m "
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>ga :Git add


""""""""""' EXECUTE BROWSERS '"""""""""
            """""""""""""""
nnoremap <leader>xg :!google-chrome-stable %<CR>
nnoremap <leader>xf :!firefox %<CR>
nnoremap <leader>xc :!chromium %<CR>
nnoremap <leader>xq :!qutebrowser %<CR>


""""""""""' BUFFERS '"""""""""
            """""""
" delete buffer without closing window
nnoremap <leader>bd :BUN<cr>
"open empty buffer in vertical split
nnoremap <leader>bn :vnew<cr>
"open empty buffer in horizontal split
nnoremap <leader>bh :new<cr>


""""""""""' ABBREVIATIONS '"""""""""
            """""""""""""
"urls
iabbrev dotcom https://.com<Esc>F.i
iabbrev dotorg https://.org<Esc>F.i
iabbrev dotnet https://.net<Esc>F.i
iabbrev dotio https://.io<Esc>F.i
iabbrev dottech https://.tech<Esc>F.i


""""""""""""""""""""""""""""""""""""""""""""""""
                    "SOME
                   "FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""

"disable auto commenting
augroup auto_comment
  au!
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" trim trailing whitespace on file save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"open on line that was last edited
augroup line_return
  au!

  au BufReadPost *
        \ if line("'\"") > 9 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

"Save folds on exiting a file and load state when opening file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* loadview
augroup END

"convert tabs to spaces
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
"convert spaces to tab
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

