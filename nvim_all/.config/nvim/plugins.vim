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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'lewis6991/spellsitter.nvim'

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
" " coc {{{
" " \ 'coc-pairs'
" let g:coc_global_extensions = [
"       \ 'coc-vimlsp',
"       \ 'coc-rust-analyzer',
"       \ 'coc-clangd',
"       \ 'coc-pyright',
"       \ 'coc-tsserver',
"       \ 'coc-eslint',
"       \ 'coc-sh',
"       \ 'coc-json',
"       \ 'coc-snippets',
"       \ ]

" " mappings {{{
" nmap <silent> <leader>rn <Plug>(coc-rename)

" " move to the next error
" nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
" nmap <silent> <leader>N <Plug>(coc-diagnostic-prev)

" " show where the thing was declared
" nmap <silent> <leader>gr <Plug>(coc-references)

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " TODO: do the same thing as show_documentation maybe
" " switch to the definition
" nmap <silent> gd <Plug>(coc-definition)

" nmap <silent> <leader>gi <Plug>(coc-implementation)
" nmap <silent> <leader>gy <Plug>(coc-type-definition)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" " xmap if <Plug>(coc-funcobj-i)
" " omap if <Plug>(coc-funcobj-i)
" " xmap af <Plug>(coc-funcobj-a)
" " omap af <Plug>(coc-funcobj-a)
" " xmap ic <Plug>(coc-classobj-i)
" " omap ic <Plug>(coc-classobj-i)
" " xmap ac <Plug>(coc-classobj-a)
" " omap ac <Plug>(coc-classobj-a)

" " this isn't bad
" " Remap <C-f> and <C-b> for scroll float windows/popups.
" " Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
" nnoremap <nowait><expr> <C-f> coc#float#has_scroll()
"       \ ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll()
"       \ ? coc#float#scroll(0) : "\<C-b>"

" inoremap <nowait><expr> <C-f> coc#float#has_scroll()
"       \ ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll()
"       \ ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)


" " language specific settings
" " after/ftplugin/
" " c_settings.vim
" " }}}

" " NOTE: this kinda sucks, but its also not so bad
" " show docs {{{
" function! s:show_documentation()
"   if (index(['vim', 'help'], &filetype) >= 0)
"     execute 'h ' . expand('<cword>')

"   elseif (index(['sh', 'bash', 'zsh'], &filetype) >= 0)
"     execute 'Man ' . expand('<cword>')

"   else
"     call CocAction('doHover')

"   endif
" endfunction

" " use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" " }}}
" " }}}

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
"   vimspector debugging {{{
"" dont overwrite d{motion}
"" this overwrites d<cr>, i dont really use <cr> but it does seem nice
"nnoremap d<cr> :Break<cr>
"nnoremap dx :Clear<cr>
"nnoremap dc :Continue<cr>
"nnoremap dm :Finish<cr>
"" this is next in gdb but Next is a vim command
"nnoremap dq :Over<cr>
"nnoremap dr :Run<cr>
"nnoremap dQ :Step<cr>
"" stop debugging
"nnoremap dC :Stop<cr>
"" }}}

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

" fzf.vim {{{
" function MyFzfProjectFiles() abort
"   if trim(system("git rev-parse --is-inside-work-tree")) == 'true'
"     GFiles
"   else
"     Files
"   endif
" endfunction

" nnoremap <leader>ff :call MyFzfProjectFiles()<cr>

" nnoremap <leader>bb :Buffers<cr>
" }}}

" vista {{{
" toggle the vista tag window
nnoremap <f8> :Vista!!<cr>

let g:vista_echo_cursor_strategy = 'floating_win'

let g:vista_close_on_jump = 1

nnoremap <leader>vv :Vista finder<cr>
" }}}

" telescope {{{
nnoremap <leader>ff :Telescope find_files<cr>
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
