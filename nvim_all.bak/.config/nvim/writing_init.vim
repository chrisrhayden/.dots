" source the default settings and plugins
runtime init.vim

" writing specific settings

" some settings will be changed or overwritten where they dont make sense for
" writing text files or markdown

" unset textwidth
set textwidth=0
" unset colorcolumn
set colorcolumn=

" unset smartindent as its mostly useful for c like syntax and is annoying for
" normal text or markdown
"
" smartindent is what stops lines staring with # to not be indented
set nosmartindent

" make j k move over visual lines
nnoremap j gj
nnoremap k gk
