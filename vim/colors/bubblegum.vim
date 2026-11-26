" Bubblegum for Vim (dark + light, follows 'background'; "bubblegum" or "shhhed"
" family from ~/.local/state/bubblegum/family).
" Palettes mirror nvim/neovim-bubblegum/lua/bubblegum/palette.lua.

highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'bubblegum'
set termguicolors

function! s:ReadFamily() abort
  let l:f = expand('~/.local/state/bubblegum/family')
  let l:v = filereadable(l:f) ? get(readfile(l:f, '', 1), 0, '') : ''
  return trim(l:v) ==# 'shhhed' ? 'shhhed' : 'bubblegum'
endfunction
let s:family = s:ReadFamily()
let g:bubblegum_family = s:family

if s:family ==# 'shhhed' && &background ==# 'light'
  let s:p = {
    \ 'bg': '#fbfdff', 'bg_dark': '#eaf1f7', 'bg_alt': '#f4f8fc', 'bg_float': '#f1f6fb',
    \ 'bg_visual': '#d7e1eb', 'bg_search': '#c7dcd1', 'border': '#e1eaf3', 'guide': '#e4edf6',
    \ 'fg': '#1e1a14', 'text': '#1e1a14', 'variable': '#2d2821', 'comment': '#877f73',
    \ 'line_nr': '#a4a4ab', 'line_nr_active': '#62626a', 'punct': '#7f7970',
    \ 'pink': '#2a7848', 'func': '#0050d8', 'blue': '#79658d', 'cyan': '#1e6838', 'purple': '#008cb4',
    \ 'green': '#547559', 'string': '#a85b01', 'constant': '#c42840', 'number': '#c82868',
    \ 'red': '#b84e60', 'orange': '#9c7c00', 'teal': '#236292',
    \ 'diff_add': '#deeae5', 'diff_delete': '#ece3e6', 'diff_change': '#eeebdb',
    \ 'diff_text': '#e2dbbd', 'error_bg': '#f2e4e9', 'warn_bg': '#ece8d6'}
elseif s:family ==# 'shhhed'
  let s:p = {
    \ 'bg': '#1e1e22', 'bg_dark': '#17171a', 'bg_alt': '#232328', 'bg_float': '#26262b',
    \ 'bg_visual': '#38383d', 'bg_search': '#415048', 'border': '#2a2a2f', 'guide': '#27272c',
    \ 'fg': '#dadadf', 'text': '#cbcbcf', 'variable': '#b8b8bc', 'comment': '#797981',
    \ 'line_nr': '#4d4d52', 'line_nr_active': '#9e9ea4', 'punct': '#74747a',
    \ 'pink': '#6ca880', 'func': '#729bcf', 'blue': '#918699', 'cyan': '#8bc37b', 'purple': '#60b1b1',
    \ 'green': '#7f8e7f', 'string': '#c48d2f', 'constant': '#c09090', 'number': '#ca8489',
    \ 'red': '#cc7078', 'orange': '#c8a050', 'teal': '#6088b0',
    \ 'diff_add': '#2e3a35', 'diff_delete': '#3b2f32', 'diff_change': '#393329',
    \ 'diff_text': '#4e422f', 'error_bg': '#412e33', 'warn_bg': '#3d352a'}
elseif &background ==# 'light'
  let s:p = {
    \ 'bg': '#f5f5f5', 'bg_dark': '#e0e0e0', 'bg_alt': '#ececec', 'bg_float': '#ececec',
    \ 'bg_visual': '#d5d5d5', 'bg_search': '#f0dcb5', 'border': '#c8c8c8', 'guide': '#d5d5d5',
    \ 'fg': '#2a2a2a', 'text': '#2a2a2a', 'variable': '#4a4a4a', 'comment': '#888888',
    \ 'line_nr': '#999999', 'line_nr_active': '#2a2a2a', 'punct': '#707070',
    \ 'pink': '#b060a0', 'func': '#b060a0', 'blue': '#006ca8', 'cyan': '#0088cc', 'purple': '#5f5fa0',
    \ 'green': '#4f7f2f', 'string': '#75702a', 'constant': '#7a7a00', 'number': '#a66a00',
    \ 'red': '#c0504d', 'orange': '#b07a30', 'teal': '#2a8a8a',
    \ 'diff_add': '#dcefd0', 'diff_delete': '#f3d4d4', 'diff_change': '#f0ebc8',
    \ 'diff_text': '#e6dfa0', 'error_bg': '#f3d4d4', 'warn_bg': '#f3e3c4'}
else
  let s:p = {
    \ 'bg': '#303030', 'bg_dark': '#2a2a2a', 'bg_alt': '#3a3a3a', 'bg_float': '#252525',
    \ 'bg_visual': '#454545', 'bg_search': '#4f3f30', 'border': '#454545', 'guide': '#454545',
    \ 'fg': '#d7d7d7', 'text': '#a7a7a7', 'variable': '#afafaf', 'comment': '#808080',
    \ 'line_nr': '#808080', 'line_nr_active': '#e2e2e2', 'punct': '#878787',
    \ 'pink': '#d7afd7', 'func': '#d7afd7', 'blue': '#87afd7', 'cyan': '#87d7ff', 'purple': '#afafd7',
    \ 'green': '#afd787', 'string': '#d7d7a7', 'constant': '#d7d787', 'number': '#d7af5f',
    \ 'red': '#d78787', 'orange': '#d7af87', 'teal': '#7fc5c5',
    \ 'diff_add': '#2a3a2a', 'diff_delete': '#402020', 'diff_change': '#3a3a2a',
    \ 'diff_text': '#4a4a2a', 'error_bg': '#402020', 'warn_bg': '#4f3f30'}
endif

" H(group, fg, bg, attrs)  -- fg/bg are palette keys or 'NONE'
function! s:H(group, fg, bg, attr) abort
  let l:fg = a:fg ==# 'NONE' ? 'NONE' : s:p[a:fg]
  let l:bg = a:bg ==# 'NONE' ? 'NONE' : s:p[a:bg]
  execute 'highlight' a:group 'guifg=' . l:fg 'guibg=' . l:bg 'gui=' . a:attr 'cterm=' . a:attr
endfunction

" Editor UI
call s:H('Normal',       'text',    'bg',       'NONE')
call s:H('NormalFloat',  'fg',      'bg_float', 'NONE')
call s:H('Cursor',       'bg',      'cyan',     'NONE')
call s:H('CursorLine',   'NONE',    'bg_alt',   'NONE')
call s:H('CursorColumn', 'NONE',    'bg_alt',   'NONE')
call s:H('ColorColumn',  'NONE',    'bg_alt',   'NONE')
call s:H('LineNr',       'line_nr', 'bg',       'NONE')
call s:H('CursorLineNr', 'line_nr_active', 'bg_alt', 'bold')
call s:H('SignColumn',   'line_nr', 'bg',       'NONE')
call s:H('FoldColumn',   'comment', 'bg',       'NONE')
call s:H('Folded',       'comment', 'bg_alt',   'NONE')
call s:H('EndOfBuffer',  'bg',      'bg',       'NONE')
call s:H('VertSplit',    'border',  'bg',       'NONE')
call s:H('Visual',       'NONE',    'bg_visual','NONE')
call s:H('VisualNOS',    'NONE',    'bg_visual','NONE')
call s:H('Search',       'fg',      'bg_search','NONE')
call s:H('IncSearch',    'bg',      'pink',     'NONE')
call s:H('MatchParen',   'pink',    'NONE',     'bold,underline')
call s:H('NonText',      'guide',   'NONE',     'NONE')
call s:H('Whitespace',   'guide',   'NONE',     'NONE')
call s:H('SpecialKey',   'guide',   'NONE',     'NONE')
call s:H('Conceal',      'comment', 'NONE',     'NONE')
call s:H('Directory',    'cyan',    'NONE',     'NONE')
call s:H('Title',        'pink',    'NONE',     'bold')
call s:H('QuickFixLine', 'NONE',    'bg_visual','NONE')
call s:H('WildMenu',     'bg',      'pink',     'NONE')

" Popup menu
call s:H('Pmenu',        'text',    'bg_float', 'NONE')
call s:H('PmenuSel',     'bg',      'pink',     'NONE')
call s:H('PmenuSbar',    'NONE',    'bg_alt',   'NONE')
call s:H('PmenuThumb',   'NONE',    'comment',  'NONE')

" Statusline / tabline
call s:H('StatusLine',   'fg',      'bg_dark',  'NONE')
call s:H('StatusLineNC', 'comment', 'bg_dark',  'NONE')
call s:H('TabLine',      'comment', 'bg',       'NONE')
call s:H('TabLineFill',  'NONE',    'bg_dark',  'NONE')
call s:H('TabLineSel',   'fg',      'bg_alt',   'bold')

" Messages
call s:H('ErrorMsg',     'red',     'NONE',     'bold')
call s:H('WarningMsg',   'orange',  'NONE',     'NONE')
call s:H('ModeMsg',      'fg',      'NONE',     'bold')
call s:H('MoreMsg',      'green',   'NONE',     'NONE')
call s:H('Question',     'cyan',    'NONE',     'NONE')

" Diff
call s:H('DiffAdd',      'NONE',    'diff_add',    'NONE')
call s:H('DiffDelete',   'red',     'diff_delete', 'NONE')
call s:H('DiffChange',   'NONE',    'diff_change', 'NONE')
call s:H('DiffText',     'NONE',    'diff_text',   'NONE')

" Spell
execute 'highlight SpellBad   guisp=' . s:p.red    . ' gui=undercurl cterm=underline guifg=NONE guibg=NONE'
execute 'highlight SpellCap   guisp=' . s:p.orange . ' gui=undercurl cterm=underline guifg=NONE guibg=NONE'
execute 'highlight SpellLocal guisp=' . s:p.teal   . ' gui=undercurl cterm=underline guifg=NONE guibg=NONE'
execute 'highlight SpellRare  guisp=' . s:p.purple . ' gui=undercurl cterm=underline guifg=NONE guibg=NONE'

" Syntax
call s:H('Comment',      'comment', 'NONE', 'italic')
call s:H('Constant',     'constant','NONE', 'NONE')
call s:H('String',       'string',  'NONE', 'NONE')
call s:H('Character',    'string',  'NONE', 'NONE')
call s:H('Number',       'number',  'NONE', 'NONE')
call s:H('Float',        'number',  'NONE', 'NONE')
call s:H('Boolean',      'constant','NONE', 'NONE')
call s:H('Identifier',   'variable','NONE', 'NONE')
call s:H('Function',     'func',    'NONE', 'NONE')
call s:H('Statement',    'blue',    'NONE', 'NONE')
call s:H('Conditional',  'blue',    'NONE', 'NONE')
call s:H('Repeat',       'blue',    'NONE', 'NONE')
call s:H('Label',        'blue',    'NONE', 'NONE')
call s:H('Operator',     'blue',    'NONE', 'NONE')
call s:H('Keyword',      'blue',    'NONE', 'NONE')
call s:H('Exception',    'blue',    'NONE', 'NONE')
call s:H('PreProc',      'green',   'NONE', 'NONE')
call s:H('Include',      'green',   'NONE', 'NONE')
call s:H('Define',       'green',   'NONE', 'NONE')
call s:H('Macro',        'green',   'NONE', 'NONE')
call s:H('PreCondit',    'green',   'NONE', 'NONE')
call s:H('Type',         'purple',  'NONE', 'NONE')
call s:H('StorageClass', 'blue',    'NONE', 'NONE')
call s:H('Structure',    'purple',  'NONE', 'NONE')
call s:H('Typedef',      'purple',  'NONE', 'NONE')
call s:H('Special',      'red',     'NONE', 'NONE')
call s:H('SpecialChar',  'red',     'NONE', 'NONE')
call s:H('Tag',          'pink',    'NONE', 'NONE')
call s:H('Delimiter',    'punct',   'NONE', 'NONE')
call s:H('SpecialComment','comment','NONE', 'bold')
call s:H('Debug',        'red',     'NONE', 'NONE')
call s:H('Underlined',   'cyan',    'NONE', 'underline')
call s:H('Ignore',       'comment', 'NONE', 'NONE')
call s:H('Error',        'red',     'error_bg', 'NONE')
call s:H('Todo',         'bg',      'orange',   'bold')

" Python legacy syntax: 'self' and decorators
highlight link pythonSelf Constant
highlight link pythonDecorator PreProc
highlight link pythonDecoratorName PreProc

" Terminal (:terminal) palette
if s:family ==# 'shhhed' && &background ==# 'light'
  let g:terminal_ansi_colors = ['#1e1a14', '#b84e60', '#2a7848', '#9c7c00', '#0050d8', '#604f73', '#006c83', '#6e685f',
        \ '#797983', '#c06068', '#3a8a55', '#b69000', '#2868e0', '#855290', '#007783', '#645c50']
elseif s:family ==# 'shhhed'
  let g:terminal_ansi_colors = ['#27272c', '#c97279', '#7db277', '#c8a050', '#729bcf', '#a088ac', '#60b1b1', '#c8c8cc',
        \ '#49494e', '#e08088', '#88c880', '#d8b068', '#90bce0', '#b898d8', '#80d0cc', '#dadadf']
elseif &background ==# 'light'
  let g:terminal_ansi_colors = ['#2a2a2a', '#c0504d', '#4f7f2f', '#75702a', '#006ca8', '#b060a0', '#0088cc', '#d5d5d5',
        \ '#666666', '#cc3333', '#5f8f3f', '#8a8230', '#0088cc', '#c070b0', '#2a8a8a', '#f5f5f5']
else
  let g:terminal_ansi_colors = ['#303030', '#d78787', '#afd787', '#d7d787', '#87afd7', '#d7afd7', '#87d7ff', '#d7d7d7',
        \ '#808080', '#ff5555', '#55ff55', '#ffff55', '#5555ff', '#ff55ff', '#55ffff', '#ffffff']
endif
