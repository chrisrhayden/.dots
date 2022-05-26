" info {{{
" based (stolen from) on Apprentice and Sorcerer:
" https://github.com/romainl/Apprentice
" https://www.vim.org/scripts/script.php?script_id=3299

" TODO: do something with term colors
" colors {{{
" #0f0f0f  - darker grey, line number background
" #191919  - dark grey, normal background
" #232323  - less dark grey, for StatusLineNC
" #686858  - olive greenish / greyish, comments
" #6c6c6c  - normal grey, linenum etc
" #bcbcbc  - light grey, normal text
" #819cbe  - light blue
" #50789f  - blue
" #5f875f  - dark green
" #7aa37a  - light green
" #6a9696  - dark teal
" #5fafaf  - light teal
" #896680  - light purple
" #785d92  - dark purple
" #2b242e  - very dark purple
" #af5f5f  - red
" #af5f87  - pink red
" #d88527  - orange
" #ffffaf  - yellow
" }}}
" }}}

" reset highlighting {{{
" despite these settings vim can mess up colors when switching color schemes
" reset all highlighting to the defaults
highlight clear
if exists('syntax_on')
  " if syntax has been enabled reset to defaults
  syntax reset
endif
" this is weird just look it up
set background=dark
" }}}

" internal {{{
" vim ui {{{
hi Normal                      ctermbg=NONE ctermfg=145 cterm=NONE    guibg=#191919 guifg=#bcbcbc gui=NONE
hi LineNr                      ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi FoldColumn                  ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi Folded                      ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi StatusLine                  ctermbg=96 ctermfg=73 cterm=NONE    guibg=#2b242e guifg=#5fafaf gui=NONE
hi StatusLineNC                ctermbg=235 ctermfg=242 cterm=NONE    guibg=#232323 guifg=#6c6c6c gui=NONE
hi Cursor                      ctermbg=145 ctermfg=234 cterm=NONE    guibg=#bcbcbc guifg=#191919 gui=NONE
hi CursorLine                  ctermbg=232 ctermfg=NONE cterm=NONE       guibg=#0f0f0f guifg=NONE gui=NONE
hi CursorLineNr                ctermbg=232 ctermfg=73 cterm=NONE    guibg=#0f0f0f guifg=#5fafaf gui=NONE
hi ColorColumn                 ctermbg=232 ctermfg=NONE cterm=NONE       guibg=#0f0f0f guifg=NONE gui=NONE
hi CursorColumn                ctermbg=232 ctermfg=NONE cterm=NONE       guibg=#0f0f0f guifg=NONE gui=NONE
hi SignColumn                  ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi Visual                      ctermbg=109 ctermfg=232 cterm=NONE    guibg=#819cbe guifg=#0f0f0f gui=NONE
hi VisualNOS                   ctermbg=NONE ctermfg=131 cterm=NONE       guibg=NONE guifg=#af5f5f gui=NONE
hi VertSplit                   ctermbg=232 ctermfg=232 cterm=NONE    guibg=#0f0f0f guifg=#0f0f0f gui=NONE
hi TabLine                     ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi TabLineFill                 ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi TabLineSel                  ctermbg=232 ctermfg=66 cterm=NONE    guibg=#0f0f0f guifg=#6a9696 gui=NONE
hi Pmenu                       ctermbg=232 ctermfg=96 cterm=italic  guibg=#0f0f0f guifg=#785d92 gui=italic
hi PmenuSel                    ctermbg=145 ctermfg=232 cterm=bold    guibg=#bcbcbc guifg=#0f0f0f gui=bold
hi PmenuSbar                   ctermbg=232 ctermfg=145 cterm=NONE    guibg=#0f0f0f guifg=#bcbcbc gui=NONE
hi PmenuThumb                  ctermbg=145 ctermfg=232 cterm=NONE    guibg=#bcbcbc guifg=#0f0f0f gui=NONE
hi WildMenu                    ctermbg=232 ctermfg=96 cterm=NONE    guibg=#0f0f0f guifg=#785d92 gui=NONE
hi NormalFloat                 ctermbg=232 ctermfg=96 cterm=NONE    guibg=#0f0f0f guifg=#785d92 gui=NONE
hi FloatBorder                 ctermbg=232 ctermfg=242 cterm=NONE    guibg=#0f0f0f guifg=#6c6c6c gui=NONE
hi ErrorMsg                    ctermbg=131 ctermfg=234 cterm=NONE    guibg=#af5f5f guifg=#191919 gui=NONE
hi ModeMsg                     ctermbg=NONE ctermfg=65 cterm=NONE       guibg=NONE guifg=#5f875f gui=NONE
hi MoreMsg                     ctermbg=NONE ctermfg=65 cterm=NONE       guibg=NONE guifg=#5f875f gui=NONE
hi WarningMsg                  ctermbg=NONE ctermfg=131 cterm=NONE       guibg=NONE guifg=#af5f5f gui=NONE
hi Question                    ctermbg=NONE ctermfg=66 cterm=NONE       guibg=NONE guifg=#6a9696 gui=NONE
hi Title                       ctermbg=NONE ctermfg=66 cterm=NONE       guibg=NONE guifg=#6a9696 gui=NONE
hi Bold                        ctermbg=NONE ctermfg=NONE cterm=bold          guibg=NONE guifg=NONE gui=bold
hi Italic                      ctermbg=NONE ctermfg=NONE cterm=italic        guibg=NONE guifg=NONE gui=italic
hi Underlined                  ctermbg=NONE ctermfg=NONE cterm=underline     guibg=NONE guifg=NONE gui=underline
hi Search                      ctermbg=109 ctermfg=232 cterm=NONE    guibg=#819cbe guifg=#0f0f0f gui=NONE
hi Substitute                  ctermbg=109 ctermfg=232 cterm=bold    guibg=#819cbe guifg=#0f0f0f gui=bold
hi IncSearch                   ctermbg=109 ctermfg=232 cterm=NONE    guibg=#819cbe guifg=#0f0f0f gui=NONE
hi Directory                   ctermbg=NONE ctermfg=67 cterm=NONE       guibg=NONE guifg=#50789f gui=NONE
hi SpecialKey                  ctermbg=NONE ctermfg=242 cterm=NONE       guibg=NONE guifg=#6c6c6c gui=NONE
hi Conceal                     ctermbg=NONE ctermfg=67 cterm=NONE       guibg=NONE guifg=#50789f gui=NONE
hi NonText                     ctermbg=NONE ctermfg=242 cterm=NONE       guibg=NONE guifg=#6c6c6c gui=NONE
hi QuickFixLine                ctermbg=232 ctermfg=NONE cterm=NONE       guibg=#0f0f0f guifg=NONE gui=NONE
hi MatchParen                  ctermbg=242 ctermfg=232 cterm=bold    guibg=#6c6c6c guifg=#0f0f0f gui=bold
" }}}

" spelling {{{
hi SpellBad                   ctermbg=NONE ctermfg=NONE cterm=undercurl guibg=NONE guifg=NONE gui=undercurl guisp=NONE
hi SpellLocal                 ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=NONE
hi SpellCap                   ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=NONE
hi SpellRare                  ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=NONE
" }}}

" syntax highlighting {{{
hi Todo                        ctermbg=NONE ctermfg=229 cterm=NONE guibg=NONE guifg=#ffffaf gui=NONE
hi Comment                     ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#686858 gui=NONE
hi Statement                   ctermbg=NONE ctermfg=109 cterm=NONE guibg=NONE guifg=#819cbe gui=NONE
hi Conditional                 ctermbg=NONE ctermfg=132 cterm=NONE guibg=NONE guifg=#af5f87 gui=NONE
hi link Repeat Conditional
hi link Label Conditional
hi Operator                   ctermbg=NONE ctermfg=145 cterm=NONE guibg=NONE guifg=#bcbcbc gui=NONE
" hi Keyword
hi link Exception Conditional

hi Constant                    ctermbg=NONE ctermfg=172 cterm=NONE guibg=NONE guifg=#d88527 gui=NONE
hi String                      ctermbg=NONE ctermfg=108 cterm=NONE guibg=NONE guifg=#7aa37a gui=NONE
hi Character                   ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
" hi Number
" hi Boolean
" hi Float

hi Identifier                 ctermbg=NONE ctermfg=96 cterm=NONE guibg=NONE guifg=#785d92 gui=NONE
hi Function                   ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#6a9696 gui=NONE

hi Type                       ctermbg=NONE ctermfg=96 cterm=NONE guibg=NONE guifg=#785d92 gui=NONE
" hi StorageClass
" hi Structure
" hi Typedef

hi PreProc                     ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#6c6c6c gui=NONE
hi Include                     ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#6a9696 gui=NONE
" hi PreCondit
" hi link Define Include
hi link Macro Include

hi Special                     ctermbg=NONE ctermfg=67 cterm=NONE guibg=NONE guifg=#50789f gui=NONE
hi SpecialChar                 ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#6c6c6c gui=NONE
" hi Tag
" hi Delimiter
hi link SpecialComment SpecialChar
" hi Debug

" idk what uses this
hi Error                      ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
" }}}

" diff {{{
" this is better for sure
hi DiffAdd                     ctermbg=NONE ctermfg=65 cterm=NONE guibg=NONE guifg=#5f875f gui=NONE
hi DiffChange                  ctermbg=NONE ctermfg=242 cterm=NONE guibg=NONE guifg=#6c6c6c gui=NONE
hi DiffDelete                  ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
hi DiffText                    ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#6a9696 gui=NONE
hi DiffAdded                   ctermbg=NONE ctermfg=65 cterm=NONE guibg=NONE guifg=#5f875f gui=NONE
hi DiffFile                    ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
hi DiffNewFile                 ctermbg=NONE ctermfg=65 cterm=NONE guibg=NONE guifg=#5f875f gui=NONE
hi DiffLine                    ctermbg=NONE ctermfg=66 cterm=NONE guibg=NONE guifg=#6a9696 gui=NONE
hi DiffRemoved                 ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
" }}}

" misc {{{
hi link htmlLink Special
" }}}
"
" neovim {{{
hi NvimInternalError          ctermbg=NONE ctermfg=131 cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE

augroup HighlightYanked
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
" }}}
" }}}

" coc vim / language servers {{{
hi CocErrorFloat                ctermbg=232 ctermfg=131 cterm=NONE guibg=#0f0f0f guifg=#af5f5f gui=NONE
hi CocErrorSign                 ctermbg=234 ctermfg=131 cterm=NONE guibg=#191919 guifg=#af5f5f gui=NONE
hi CocHintSign                  ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=#5fafaf gui=NONE

hi LspDiagnosticsDefaultHint ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=#6c6c6c gui=NONE
hi LspDiagnosticsDefaultError ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=#af5f5f gui=NONE
hi LspDiagnosticsDefaultInformation ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=#5fafaf gui=NONE
hi LspDiagnosticsDefaultWarning ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=#d88527 gui=NONE

hi LspDiagnosticsUnderlineError cterm=underline gui=underline guisp=#af5f5f
hi LspDiagnosticsUnderlineWarning cterm=underline gui=underline guisp=#d88527
" }}}

" debug {{{
hi debugBreakpoint              ctermbg=66 ctermfg=232 cterm=NONE guibg=#6a9696 guifg=#0f0f0f gui=NONE
hi debugPC                      ctermbg=66 ctermfg=232 cterm=NONE guibg=#6a9696 guifg=#0f0f0f gui=NONE
" }}}

" rust {{{
" this is weird, i guess it kinda makes sense, or at least it stands out
hi link rustQuestionMark Constant
hi link rustAssert Macro
hi link rustPanic Macro
" hi link rustEnumVariant Type

" rust.vim is right but this way it stays consistent with the while derive lien
hi link rustDeriveTrait PreProc
" }}}

" vim {{{
" idk why this isn't the fucking default
hi link vimFunction Function
hi link vimUserFunc Function
" }}}

" sh / shell {{{
" why does this link to preproc
hi link shShellVariables Identifier
" }}}

" python {{{
hi link pythonOperator Special
" }}}

" git {{{
hi gitcommitOverflow          ctermbg=NONE ctermfg=131 cterm=NONE      guibg=NONE guifg=#af5f5f gui=NONE
hi gitcommitSummary           ctermbg=NONE ctermfg=65 cterm=NONE      guibg=NONE guifg=#5f875f gui=NONE
hi gitcommitComment           ctermbg=NONE ctermfg=242 cterm=NONE      guibg=NONE guifg=#6c6c6c gui=NONE
hi gitcommitUntracked         ctermbg=NONE ctermfg=242 cterm=NONE      guibg=NONE guifg=#6c6c6c gui=NONE
hi gitcommitDiscarded         ctermbg=NONE ctermfg=242 cterm=NONE      guibg=NONE guifg=#6c6c6c gui=NONE
hi gitcommitSelected          ctermbg=NONE ctermfg=242 cterm=NONE      guibg=NONE guifg=#6c6c6c gui=NONE
hi gitcommitHeader            ctermbg=NONE ctermfg=132 cterm=NONE      guibg=NONE guifg=#af5f87 gui=NONE
hi gitcommitSelectedType      ctermbg=NONE ctermfg=66 cterm=NONE      guibg=NONE guifg=#6a9696 gui=NONE
hi gitcommitUnmergedType      ctermbg=NONE ctermfg=66 cterm=NONE      guibg=NONE guifg=#6a9696 gui=NONE
hi gitcommitDiscardedType     ctermbg=NONE ctermfg=66 cterm=NONE      guibg=NONE guifg=#6a9696 gui=NONE
hi gitcommitBranch            ctermbg=NONE ctermfg=172 cterm=bold      guibg=NONE guifg=#d88527 gui=bold
hi gitcommitUntrackedFile     ctermbg=NONE ctermfg=229 cterm=NONE      guibg=NONE guifg=#ffffaf gui=NONE
hi gitcommitUnmergedFile      ctermbg=NONE ctermfg=131 cterm=bold      guibg=NONE guifg=#af5f5f gui=bold
hi gitcommitDiscardedFile     ctermbg=NONE ctermfg=131 cterm=bold      guibg=NONE guifg=#af5f5f gui=bold
hi gitcommitSelectedFile      ctermbg=NONE ctermfg=65 cterm=bold      guibg=NONE guifg=#5f875f gui=bold
hi GitGutterAdd               ctermbg=232 ctermfg=65 cterm=NONE   guibg=#0f0f0f guifg=#5f875f gui=NONE
hi GitGutterChange            ctermbg=232 ctermfg=66 cterm=NONE   guibg=#0f0f0f guifg=#6a9696 gui=NONE
hi GitGutterDelete            ctermbg=232 ctermfg=131 cterm=NONE   guibg=#0f0f0f guifg=#af5f5f gui=NONE
hi GitGutterChangeDelete      ctermbg=232 ctermfg=132 cterm=NONE   guibg=#0f0f0f guifg=#af5f87 gui=NONE
" }}}

" terminal colors {{{
" see terminal-configuration
let g:terminal_color_0 = '#0f0f0f'
let g:terminal_color_1 = '#af5f5f'
let g:terminal_color_2 = '#7aa37a'
let g:terminal_color_3 = '#ffffaf'
let g:terminal_color_4 = '#50789f'
let g:terminal_color_5 = '#896680'
let g:terminal_color_6 = '#5fafaf'
let g:terminal_color_7 = '#bcbcbc'
" }}}
