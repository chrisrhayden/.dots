""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" security {{{
" mode lines allow per-file settings to be embedded in the file
" set nomodeline

" disallow certain vim functions from being run in non standard vimrc's
set secure
" dont run non standard vimrc
set noexrc
" }}}

" setup paths {{{
" make sure backup files are made in `$XDG_DATA_HOME/nvim/backup/`
set backupdir=$XDG_DATA_HOME/nvim/backup//
" where to save personal words for spell check, (i.e. words added with zg)
set spellfile=$XDG_CONFIG_HOME/nvim/words/code-en.utf-8.add
" thesaurus completion, <C-x><C-t>
set thesaurus=$XDG_CONFIG_HOME/nvim/words/en_thesaurus.txt
" }}}

" ui {{{
" redraw only when the user changes the screen
" set lazyredraw
" use the number column
set number
" use relative numbers for the number column
set relativenumber
" highlight columns at the given column number
set colorcolumn=81,101
" the status line config, lol
set statusline=%!'\ %n\ %t\ %m\ %r\ %{coc#status()}\ %=\ %y\ \ [%l/%L]\ '
" list mode will display given characters in certain places (e.g. <tab> == >-)
set list
" the characters list mode will use
set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:+
" visually show potential changes
set inccommand=split
" visually break lines according to `breakat` instead of the last fitting char
set linebreak
" highlight or underline the line the cursor is on
set cursorline
" minimum lines to keep above and below the cursor
set scrolloff=2
" minimum characters between the cursor and the sides similar to scrolloff
set sidescrolloff=2
" set colors to be very close to gui vim
set termguicolors
" use this color scheme
colorscheme sourcery
" }}}

" feel / editing {{{
" time in milliseconds to wait for a mapped sequence to complete
set timeoutlen=500
" save these settings when making views
set viewoptions=folds,cursor
" save these settings when making sessions
set sessionoptions=buffers,folds,help,tabpages,winsize,sesdir
" settings for the shada file
set shada='100,s10,h,f1
" turn on spell checking
set spell
" search case insensitive
set ignorecase
" override `ignorecase` when an upper case letter is used
set smartcase
" always insert spaces instead of a tab
set expandtab
" the number of spaces tabs equate to
set tabstop=4
" what auto indent uses (e.g. >>), 0 makes it use the `tabstop` value
set shiftwidth=0
" indent to the same level as the surrounding text
set smartindent
" physically break lines as 80 characters
set textwidth=80
" define how vim will format text
set formatoptions=tcqjron
" text folding method
set foldmethod=indent
" what level to start folds (0 = all closed, 99 = all open)
set foldlevelstart=99
" max nested folds
set foldnestmax=5
" set horizontal splits to below by default
set splitbelow
" set vertical splits to right by default
set splitright
" }}}

" language specific settings {{{
" make vim treat *.h files like c not cpp
let g:c_syntax_for_h = 1
" }}}

" toggle relativenumber {{{
" from https://github.com/jeffkreeftmeijer/vim-numbertoggle/
augroup RelativizeNum
  autocmd!
  autocmd InsertLeave * if &number | set relativenumber  | endif
  autocmd InsertEnter * if &number | set norelativenumber | endif
augroup END
" }}}

" only show cursorline in current window cursorline {{{
" https://stackoverflow.com/questions/14068751/
" how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
augroup CursorLine
    autocmd!
    autocmd VimEnter * setlocal cursorline
    autocmd WinEnter * setlocal cursorline
    " autocmd BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" }}}

" ripgrep instead of grep {{{
" https://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  cnoreabbrev rg grep
endif
" }}}

" built in pkgs {{{
" debug with vim
packadd! termdebug

" use a wide layout for termdebug
let g:termdebug_wide = 1

" disable the built in python style so vim keeps the global default for python
let g:python_recommended_style = 0
" }}}

" interpreters {{{
" use the VIRTUAL_ENV path if it exists else just use the system default
if exists("$VIRTUAL_ENV")
  let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python3'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

" turn off support for unneeded interpreters
let g:loaded_python_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
" }}}

" file short cuts {{{
" can use these in cmd mode (e.g. `:e $doc/new_email.txt`)
let $doc = "~/Documents"
let $note = "~/notebook"
" }}}
