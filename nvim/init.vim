"  __     __    __  __ ____   ____
"  \ \   / /_ _|  \/  |  _ \ / ___|
"   \ \ / / | || |\/| | |_) | |
"    \ V /  | || |  | |  _ <| |___
"     \_/  |___|_|  |_|_| \_\\____|


"""""""""""""""""""""""""""""""""""""
               "PLUG
"""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-surround'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rbgrouleff/bclose.vim' " Ranger dependency for neovim
Plug 'francoiscabrol/ranger.vim'
Plug 'rakr/vim-one'
Plug 'jiangmiao/auto-pairs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
" yank text to system clipboard (requires +clipboard)
set clipboard^=unnamedplus
set relativenumber              " Set number lines
set confirm             " Ask for confimation messages"
set shortmess+=aAcIws   " Hide certain messages like 'Search Hit Bottom' etc.
set expandtab           " Tab inserts Spaces not Tabs '\t'
set softtabstop=4       " Amount of spaces to enter when Tab is pressed
set shiftwidth=4        " 4 space indentation
set tabstop=4
set showbreak=↪
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set undofile " Maintain undo history
set ignorecase " ignore case when searching
set smartcase
set noswapfile          " No swap files thank you"

" better defaults
nnoremap 0 ^
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <Tab> ==j
nnoremap g; g;zz

""""""""""""""""""""""""""""""""""""""
            "WILDMENU
""""""""""""""""""""""""""""""""""""""
" enable tab completion menu when using colon command mode (:)
set wildmenu
set wildignore+=*/tmp/*,*.so,*.zip               " Linux
set wildignore+=*.pyc,*.out                      " Compiled files
set wildignore+=__pycache__						 " Py cache folder
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?

"""""""""""""""""""""""""""""""""""""""
           " LET THE GAMES BEGIN
"""""""""""""""""""""""""""""""""""""""
filetype indent plugin on

"""""""""""""""""""""""""""""""""""""""
           " PYTHON
"""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = "~/.pyenv/versions/py3nvim/bin/python"

"""""""""""""""""""""""""""""""""""""""
           " COLORS
"""""""""""""""""""""""""""""""""""""""
set termguicolors
lua require'colorizer'.setup()
set encoding=UTF-8
colorscheme deep-space

"""""""""""""""""""""""""""""""""""""""
           " SESSIONS
"""""""""""""""""""""""""""""""""""""""
let g:prosession_dir = "~/.config/nvim/sessions"
nnoremap <space>pp <esc>:Prosession<space>
nnoremap <space>po <esc>:Obsession<CR>
nnoremap <space>pl <esc>:! ls ~/.config/nvim/sessions/<CR>

"""""""""""""""""""""""""""""""""""""""
           " Wrist Savers
"""""""""""""""""""""""""""""""""""""""
nnoremap <C-W> :q<CR>
inoremap <C-W> <esc>:q<CR>
vnoremap <C-W> <esc>:q<CR>
tnoremap <C-W> <C-\><C-n>:q<CR>

"""""""""""""""""""""""""""""""""""""""
           " TagBar
"""""""""""""""""""""""""""""""""""""""
nmap <space>tb :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""
           " Airline
"""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme='deep_space'

"""""""""""""""""""""""""""""""""""""""
           " DENITE
"""""""""""""""""""""""""""""""""""""""
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   split                       - Use floating window for Denite
"   start_filter                - Start filtering on default
"   auto_resize                 - Auto resize the Denite window height automatically.
"   source_names                - Use short long names if multiple sources
"   prompt                      - Customize denite prompt
"   highlight_matched_char      - Matched characters highlight
"   highlight_matched_range     - matched range highlight
"   highlight_window_background - Change background group in floating window
"   highlight_filter_background - Change background group in floating filter window
"   winrow                      - Set Denite filter window to top
"   vertical_preview            - Open the preview window vertically

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc', 'node_modules/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'assets/'])

let ignore=&wildignore

let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

nnoremap <leader>b :Denite buffer<CR>
nnoremap <space>k<space>p :Denite buffer<CR>
nnoremap <C-P> :Denite buffer file/rec<CR>
nnoremap <C-T> :Denite outline file/point<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>w :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction


"""""""""""""""""""""""""""""""""""""""
           " MARKDOWN PREVIEW
"""""""""""""""""""""""""""""""""""""""

nnoremap <space>mp :MarkdownPreview<cr>
nnoremap <space>ms :MarkdownPreviewStop<cr>
nnoremap <space>mt :MarkdownPreviewToggle<cr>

"""""""""""""""""""""""""""""""""""""""
           " WINDOW MANAGEMENT
"""""""""""""""""""""""""""""""""""""""

"Split as you expect splits to split.
set splitright
set splitbelow

"Set leader key to spacebar. You know it makes sense
let mapleader = ","

" Open window in new tab (My preferred way to 'zoom' a window.)
nnoremap <space>z :tabnew %<CR>

" make horizontal split full height
nnoremap <space>ru <C-w><C-_>
" make vertical split full width
nnoremap <space>rw <C-w>\|
" make split full screen (full width and height)
nnoremap <space>rf <C-w><C-_><C-w>\|

" make splits equal size
nnoremap <space>r= <C-w>=

" increase width by 5
nnoremap <space>rl :vertical resize +5<CR>
" decrease width by 5
nnoremap <space>rh :vertical resize -5<CR>
" increase height by 5
nnoremap <space>rk :res +5<CR>
" decrease height by 5
nnoremap <space>rj :res -5<CR>

" increase width by 1
nnoremap <space>rL :vertical resize +1<CR>
" decrease width by 1
nnoremap <space>rH :vertical resize -1<CR>
" increase height by 1
nnoremap <space>rK :res +1<CR>
" decrease height by 1
nnoremap <space>rJ :res -1<CR>

" resize for different widths
nnoremap <space>r8 :vertical resize 80<CR>
nnoremap <space>r9 :vertical resize 90<CR>
nnoremap <space>r0 :vertical resize 100<CR>
nnoremap <space>r1 :vertical resize 110<CR>
nnoremap <space>r2 :vertical resize 120<CR>
nnoremap <space>r3 :vertical resize 130<CR>
nnoremap <space>r4 :vertical resize 140<CR>

" Move between / create splits
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <c-h> :call WinMove('h')<CR>
nnoremap <silent> <c-j> :call WinMove('j')<CR>
nnoremap <silent> <c-k> :call WinMove('k')<CR>
nnoremap <silent> <c-l> :call WinMove('l')<CR>
nnoremap <silent> <c-\> :call WinMove('l')<CR>

let g:bclose_no_plugin_maps=0
nnoremap <space>qb :Bclose<CR>
nnoremap <space>qa :qa<CR>

"""""""""""""""""""""""""""""""""""""""
           " TAB MANAGEMENT
"""""""""""""""""""""""""""""""""""""""

nnoremap <space>wl :tabnext<CR>
nnoremap <space>wh :tabprevious<CR>
nnoremap <space>wn :tabnew<CR>
nnoremap <space>wq :tabclose<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
              "OPEN CONFIG FILES
                 "SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""

"Use leader to source vimrc and ftplugins
nnoremap <space>sv :source ~/.config/nvim/init.vim<CR>
nnoremap <space>sa :!source ~/.aliases<CR>
nnoremap <space>sz :!source ~/.zshrc<CR>
nnoremap <space>sb :!source ~/.bashrc<CR>
nnoremap <space>sk :!source ~/.config/kitty/kitty.conf<CR>


" Open config files in new tab
nnoremap <space>eV :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <space>eH :tabnew ~/.config/nvim/after/ftplugin/html.vim<CR>
nnoremap <space>eA :tabnew ~/.aliases<CR>
nnoremap <space>eB :tabnew ~/.bashrc<CR>
nnoremap <space>eK :tabnew ~/.config/kitty/kitty.conf<CR>
nnoremap <space>eZ :tabnew ~/.zshrc<CR>
nnoremap <space>eR :tabnew ~/.config/ranger/rc.conf<CR>
nnoremap <space>eX :tabnew ~/.Xresources<CR>

" Open config files in buffer
nnoremap <space>ev :e ~/.config/nvim/init.vim<CR>
nnoremap <space>eh :e ~/.config/nvim/after/ftplugin/html.vim<CR>
nnoremap <space>ea :e ~/.aliases<CR>
nnoremap <space>eb :e ~/.bashrc<CR>
nnoremap <space>ek :e ~/.config/kitty/kitty.conf<CR>
nnoremap <space>ez :e ~/.zshrc<CR>
nnoremap <space>er :e ~/.config/ranger/rc.conf<CR>

"""""""""""""""""""""""""""""""""""""""
            "SETTINGS
""""""""""""""""""""""""""""""""""""""

" Toggle spell check
nnoremap <space>ts :setlocal spell! spelllang=en_us<CR>

" Toggle highlight search
let hlstate=0
nnoremap <space>th :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr><cr>

" Toggle relative or absolute number lines
nnoremap <space>tn :call NumberToggle()<CR>

function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction


" Ctrl-S to save
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>
vnoremap <c-s> <esc>:w<cr>

"""""""""""""""""""""""""""""""""""""""
            "COC SETTINGS
""""""""""""""""""""""""""""""""""""""
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <space>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<space>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cb  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <leader>cs <Plug>(coc-range-select)
xmap <silent> <leader>cs <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vnoremap <leader>cp  <Plug>(coc-format-selected)
nnoremap <leader>cp  <Plug>(coc-format-selected)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workleader symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cm  :<C-u>CocList marketplace<CR>

nnoremap <silent><nowait> <space>k<space>t  :<C-u>Denite colorscheme<CR>

tnoremap <c-k> <C-\><C-N><C-w>k<CR>
tnoremap <c-j> <C-\><C-N><C-w>j<CR>
tnoremap <c-h> <C-\><C-N><C-w>h<CR>
tnoremap <c-l> <C-\><C-N><C-w>l<CR>
tnoremap <c-e> <C-\><C-N>

""""""""""""""""""""""""""""""""""""""
            "COC PLUGINS
""""""""""""""""""""""""""""""""""""""
nnoremap <leader>cp :CocList --top commands<cr>
nnoremap <space>` :CocCommand split-term.Toggle<CR>
tnoremap <space>` <C-\><C-N>:CocCommand split-term.Toggle<CR>
inoremap <space>` <esc>:CocCommand split-term.Toggle<CR>
vnoremap <space>` <esc>:CocCommand split-term.Toggle<CR>

""""""""""""""""""""""""""""""""""""""
            "FILE EXPLORERS
""""""""""""""""""""""""""""""""""""""

nnoremap <c-e> :CocCommand explorer<CR>
nnoremap <leader>fa :call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nnoremap <space>fd :CocCommand explorer --preset .vim<CR>
nnoremap <space>ff :CocCommand explorer --preset floating<CR>
nnoremap <space>fc :CocCommand explorer --preset cocConfig<CR>
nnoremap <space>fb :CocCommand explorer --preset buffer<CR>

" List all presets
nnoremap <space>el :CocList explPresets

""""""""""""""""""""""""""""""""""""""
            "RANGER
""""""""""""""""""""""""""""""""""""""
let g:ranger_map_keys = 0
nnoremap <space>fr :Ranger<CR>
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory

""""""""""""""""""""""""""""""""""""""
            "NERD Commenter
""""""""""""""""""""""""""""""""""""""
" Create default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

nnoremap <silent> <c-_> :call NERDComment('n', 'toggle')<cr>
vnoremap <silent> <c-_> :call NERDComment('x', 'toggle')<cr>
nnoremap <silent> <M-/> :call NERDComment('n', 'Sexy')<cr>
vnoremap <silent> <M-/> :call NERDComment('x', 'Sexy')<cr>

""""""""""""""""""""""""""""""""""""""
            "WHITE SPACE
""""""""""""""""""""""""""""""""""""""

" trim trailing whitespace on file save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"convert tabs to spaces
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
"convert spaces to tab
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

