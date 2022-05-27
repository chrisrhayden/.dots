" map [[ ?{<CR>w99[{:nohlsearch<cr>
" map ][ /}<CR>b99]}:nohlsearch<cr>
" map ]] j0[[%/{<CR>:nohlsearch<cr>
" map [] k$][%?}<CR>:nohlsearch<cr>

" nnoremap <leader><backspace> :CocCommand clangd.switchSourceHeader<cr>

setlocal tabstop=2

setlocal foldmethod=expr

setlocal foldexpr=nvim_treesitter#foldexpr()
