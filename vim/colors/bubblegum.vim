" Bubblegum for Vim (dark + light, follows 'background').
" Palette mirrors nvim/neovim-bubblegum/lua/bubblegum/palette.lua.

highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'bubblegum'
set termguicolors

if &background ==# 'light'
  let s:p = {
    \ 'bg': '#f5f5f5', 'bg_dark': '#e0e0e0', 'bg_alt': '#ececec', 'bg_float': '#ececec',
    \ 'bg_visual': '#d5d5d5', 'bg_search': '#f0dcb5', 'border': '#c8c8c8', 'guide': '#d5d5d5',
    \ 'fg': '#2a2a2a', 'text': '#2a2a2a', 'variable': '#4a4a4a', 'comment': '#888888',
    \ 'line_nr': '#999999', 'line_nr_active': '#2a2a2a', 'punct': '#707070',
    \ 'pink': '#b060a0', 'blue': '#006ca8', 'cyan': '#0088cc', 'purple': '#5f5fa0',
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
    \ 'pink': '#d7afd7', 'blue': '#87afd7', 'cyan': '#87d7ff', 'purple': '#afafd7',
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
call s:H('Function',     'pink',    'NONE', 'NONE')
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
if &background ==# 'light'
  let g:terminal_ansi_colors = ['#2a2a2a', '#c0504d', '#4f7f2f', '#75702a', '#006ca8', '#b060a0', '#0088cc', '#d5d5d5',
        \ '#666666', '#cc3333', '#5f8f3f', '#8a8230', '#0088cc', '#c070b0', '#2a8a8a', '#f5f5f5']
else
  let g:terminal_ansi_colors = ['#303030', '#d78787', '#afd787', '#d7d787', '#87afd7', '#d7afd7', '#87d7ff', '#d7d7d7',
        \ '#808080', '#ff5555', '#55ff55', '#ffff55', '#5555ff', '#ff55ff', '#55ffff', '#ffffff']
endif
