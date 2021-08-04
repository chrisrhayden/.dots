""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" start Plug and use the given path as the plugin path
call plug#begin('~/.local/share/nvim/plugged')

" utils (only used for telescope atm) {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" }}}

" lsp {{{
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" }}}

" completion {{{
" an adapter for vscode plugins (e.g. language servers)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}

" editor functionality {{{
" treesitter {{{
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" }}}

" the tpope collection {{{
" a set of good key bindings
Plug 'tpope/vim-unimpaired'
" change surrounding object in a very vim like way, (e.g. cs<from><to> cs'")
Plug 'tpope/vim-surround'
" [un]comment stuff with gc as expected
Plug 'tpope/vim-commentary'
" add ending keywords where it can, (e.g. fi and endif)
Plug 'tpope/vim-endwise'
" repeat plugin commands like surround
Plug 'tpope/vim-repeat'
" a git wrapper
Plug 'tpope/vim-fugitive'
" run cmds like make async and attach at anytime
Plug 'tpope/vim-dispatch'
" work with variants of words for abbreviations
Plug 'tpope/vim-abolish'
" readline bindings in insert mode
Plug 'tpope/vim-rsi'
" }}}

" thanks junegunn {{{
" fzf wrapper for vim
Plug 'junegunn/fzf'
" commands and functions to work with fzf, most plugins that use fzf use this
Plug 'junegunn/fzf.vim'
" align a group of text like, useful every now and then
Plug 'junegunn/vim-easy-align'
" }}}

Plug 'windwp/nvim-autopairs'
" Plug 'steelsojka/pears.nvim'

" A multi language graphical debugger for Vim -- from its readme
" it takes a lot to to set this up
" Plug 'puremourning/vimspector'

" view and search lsp symbols & tags in vim/neovim with a tagbar or fzf
" NOTE: this is less useful with telescope but ill keep it for now
Plug 'liuchengxu/vista.vim'

" fuzzy thing
Plug 'nvim-telescope/telescope.nvim'

" vim like access to the file system, idk how to explain shortly
Plug 'justinmk/vim-dirvish'

" show undo's in a tree so you can see the divergent paths
" this is really nice when i need it
Plug 'mbbill/undotree'

" additions that are close enough to plugins to not want in my rc
Plug 'chrisrhayden/my_vim_utils'
" }}}

" language addons and settings {{{
Plug 'rust-lang/rust.vim'
Plug 'pest-parser/pest.vim'
Plug 'ron-rs/ron.vim'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

Plug 'vim-python/python-syntax'

Plug 'plasticboy/vim-markdown'

Plug 'kevinoid/vim-jsonc'

Plug 'cespare/vim-toml'

Plug 'PotatoesMaster/i3-vim-syntax'

Plug 'tikhomirov/vim-glsl'
" }}}

" misc {{{
Plug 'lervag/wiki.vim'

" render markdown in a browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" a very fast, multi-syntax context-sensitive color name highlighter, #5fafaf
Plug 'ap/vim-css-color'

" }}}

call plug#end()

" }}}

" plug in settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" languages {{{
" rust.vim {{{
" dont overwrite settings, the auto formatter will take care of bad formating
let g:rust_recommended_style = 0

" use vim's conceal and symbols like ⟶  and ⟹  to style code
" the unicode char size depends on the terminal supporting double wide chars
let g:rust_conceal = 1
let g:rust_conceal_mod_path = 1
" }}}

" python-syntax {{{
let g:python_highlight_all = 1

" this is just annoying
let g:python_highlight_space_errors = 0
" }}}

" vim-markdown {{{
let g:vim_markdown_no_default_key_mappings = 1

" indent by the given amount of spaces when hitting `o` and `O`, its annoying
let g:vim_markdown_new_list_item_indent = 0

" so you can follow internal anchors
let g:vim_markdown_follow_anchor = 1

" let g:vim_markdown_conceal = 1

let g:vim_markdown_conceal_code_blocks = 0

" buffer local settings, (e.g. mappings, conceallevel, etc)
" after/ftplugin/markdown.vim
" after/syntax/markdown.vim
" }}}
" }}}

" added functionality {{{
" git {{{
nnoremap <leader>gs :Gstatus<cr>

" after/ftplugin/fugitive.vim
" }}}

" dispatch {{{
" run ctags in pwd
command CTags :Start! ctags -R .
" this is for rust / cargo
nnoremap <leader>mr :Make! run<cr>
" }}}

" easy align {{{
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" this and it conflicts with ga, but its just to print the ascii value
nmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode
xmap <leader>a <Plug>(EasyAlign)
" }}}

" vista {{{
" toggle the vista tag window
nnoremap <f8> :Vista!!<cr>

let g:vista_echo_cursor_strategy = 'floating_win'

let g:vista_close_on_jump = 1

nnoremap <leader>vv :Vista finder<cr>
" }}}

" undo tree {{{
nnoremap <F5> :UndotreeToggle<CR>

" make undo pop up on the right
let g:undotree_WindowLayout = 3
" }}}

" wiki {{{
" the wiki root
let g:wiki_global_load = 0

let g:wiki_root = '~/notebook'

let g:wiki_filetypes = ["md"]

let g:wiki_link_target_type = "md"
let g:wiki_link_extension = ".md"

function MyCleanLinkText(text) abort
  " lower case and replace all spaces with a `_`
  return substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction

let g:wiki_map_link_create = 'MyCleanLinkText'

" ~/.config/nvim/after/ftplugin/markdown.vim
" }}}
" }}}

" }}}
