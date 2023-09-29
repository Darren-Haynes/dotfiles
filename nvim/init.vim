" Visual
set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
set ruler	" Show row and column ruler information

" Toggle relative or absolute number lines
nnoremap <leader>tn :call NumberToggle()<CR>

function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

" Search / Match
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set matchpairs+=<:> "especially handy for html
set wildmenu
set wildignore+=*/tmp/*,*.so,*.zip               " Linux
set wildignore+=*.pyc,*.out                      " Compiled files
set wildignore+=__pycache__			 " Py cache folder
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.mp4,*.mp3			 " Media
set wildignore+=*.pdf,*.o,*.obj,*.ini		 " Other

" Toggle highlight search
let hlstate=0
nnoremap <leader>hl :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr><cr>


" Indent
set autoindent	" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
 
" Undo
set undofile	" Maintain undo history
set undodir=~/.config/vim/.undo	" Undo folder
set undolevels=1000	" Number of undo levels

" Editing
set backspace=indent,eol,start	" Backspace behaviour
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Stop autocommenting on next line

" Use powershell on windows
if has('win64')
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote   = ''
    let &shellpipe    = '| Out-File -Encoding UTF8 %s'
    let &shellredir   = '| Out-File -Encoding UTF8 %s'
endif

" Leaderkey - it has to be space :)
nnoremap <SPACE> <Nop>
let mapleader=" "

" Buffers
nnoremap <Leader>b :buffers<CR>:buffer<Space>

"Neovim Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Splits
set splitbelow
set splitright

" make horizontal split full height
nnoremap <leader>ru <C-w><C-_>
" make vertical split full width
nnoremap <leader>rw <C-w>\|
" make split full screen (full width and height)
nnoremap <leader>rf <C-w><C-_><C-w>\|
" make splits equal size
nnoremap <leader>r= <C-w>=

" increase width by 5
nnoremap <leader>rl :vertical resize +5<CR>
" decrease width by 5
nnoremap <leader>rh :vertical resize -5<CR>
" increase height by 5
nnoremap <leader>rk :res +5<CR>
" decrease height by 5
nnoremap <leader>rj :res -5<CR>

" increase width by 1
nnoremap <leader>rL :vertical resize +1<CR>
" decrease width by 1
nnoremap <leader>rH :vertical resize -1<CR>
" increase height by 1
nnoremap <leader>rK :res +1<CR>
" decrease height by 1
nnoremap <leader>rJ :res -1<CR>

" Spell Check
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>sl ]s
nnoremap <leader>sh [s
nnoremap <leader>sa zg
nnoremap <leader>sn z=
