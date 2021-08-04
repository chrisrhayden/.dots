""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" commands {{{
"
command W :w
command Q :q

cabbrev man Man
" }}}

" disable things  {{{
" disable EX mode, as I'm a pleb
nnoremap Q <nop>

" i never want just the help index page
map <help> <nop>
map <f1>   <nop>
imap <f1>  <nop>

" disable Arrow keys
" this is still kinda nice as scroll is sometimes arrow keys or something
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>
" }}}

" toggle highlight {{{
" https://stackoverflow.com/a/26504944/11972458
nnoremap <silent><expr> <Leader>h
      \ (&hlsearch && v:hlsearch ? ':nohlsearch' : ':set hlsearch')."\r"
" }}}

" tab {{{
nnoremap <Leader>tp :tabprevious <CR>
nnoremap <Leader>tn :tabnext <CR>
nnoremap <Leader>tN :tabnew <CR>
" }}}

" buffer   {{{
" switch buffer
nnoremap <bs> <C-^>

" list buffers
nnoremap <leader>ls :ls<CR>
nnoremap <Leader>bd :bdelete<CR>
" nnoremap <Leader>bD :bdelete!<CR>
nnoremap <Leader>bf :bfirst<CR>
" nnoremap <Leader>bw :bw<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
" }}}

" Window {{{
" movement
" move windows with CTRL-{h,j,k,l}
nnoremap <silent> <C-J> :silent wincmd j<cr>
nnoremap <silent> <C-K> :silent wincmd k<cr>
nnoremap <silent> <C-L> :silent wincmd l<cr>
nnoremap <silent> <C-H> :silent wincmd h<cr>

nnoremap <leader>= <C-W><C-=>

" this is barely better then default
" nnoremap <Leader>ww <C-W>w
" nnoremap <Leader>ws <C-W>s
" nnoremap <Leader>wr <C-W>r
" nnoremap <Leader>wc <C-W>c
" nnoremap <Leader>wq <C-W>q

" this is good shit
nnoremap <M-h> :vertical resize -10<cr>
nnoremap <M-k> :resize -10<cr>
nnoremap <M-l> :vertical resize +10<cr>
nnoremap <M-j> :resize +10<cr>
nnoremap <M-=> <C-W><C-=>

" for anything
nnoremap <leader>C :close<CR>
nnoremap <leader>o :only<CR>

" quickfix
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cl :colder<CR>
" nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cP :cprevious<CR>

" for local window
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>ll :lolder<CR>
nnoremap <leader>ln :lnewer<CR>
" }}}

" Fold {{{
nnoremap <Leader>f0 :set foldlevel=0<CR>
nnoremap <Leader>f1 :set foldlevel=1<CR>
nnoremap <Leader>f2 :set foldlevel=2<CR>
nnoremap <Leader>f3 :set foldlevel=3<CR>
nnoremap <Leader>f4 :set foldlevel=4<CR>
nnoremap <Leader>f5 :set foldlevel=5<CR>
nnoremap <Leader>f6 :set foldlevel=6<CR>
nnoremap <Leader>f7 :set foldlevel=7<CR>
nnoremap <Leader>f8 :set foldlevel=8<CR>
nnoremap <Leader>f9 :set foldlevel=9<CR>
" }}}

" terminal {{{
" make ecs escape terminal
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>te :split <bar> terminal<cr>
nnoremap <leader>` :split <bar> terminal<cr>
" }}}

" yank to clipboard {{{
" Yank to the end of line, I think this unused ??? holy shit
nnoremap Y y$
" yank to clip board {{{
" yank file
nnoremap <leader>yf gg"+yG``
" yank line
nnoremap <leader>yy "+yy
" yank to end of line
nnoremap <leader>Y  "+y$
" yank word
nnoremap <leader>yw "+yw
" }}}
" }}}

"  gdb termdebug debugging {{{
" dont overwrite d{motion}
" this overwrites d<cr>, i dont really use <cr> but it does seem nice
nnoremap d<cr> :Break<cr>
nnoremap dx :Clear<cr>
nnoremap dc :Continue<cr>
nnoremap dm :Finish<cr>
" this is next in gdb but Next is a vim command
nnoremap dq :Over<cr>
nnoremap dr :Run<cr>
nnoremap dQ :Step<cr>
" stop debugging
nnoremap dC :Stop<cr>
" }}}

" misc {{{
" like `ZZ` but will quit all files
nnoremap ZA  :qa!<CR>

" overwrite <c-g> to echo the full file path
nnoremap <silent> <c-g> :echomsg expand('%:p')<cr>

" }}}
