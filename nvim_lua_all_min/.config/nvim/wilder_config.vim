set wildcharm=<Tab>

call wilder#enable_cmdline_enter()

cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

call wilder#set_option('modes', ['/', '?', ':'])

" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#cmdline_pipeline(),
"       \     wilder#search_pipeline(),
"       \   ),
"       \ ])

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

let g:highlighter_conf = {
    \       'highlighter': wilder#basic_highlighter(),
    \       'right': [' ', wilder#popupmenu_scrollbar({
    \           'thumb_char': ' '
    \       })]
    \ }

call wilder#set_option('renderer', wilder#renderer_mux({
    \ ':': wilder#popupmenu_renderer(g:highlighter_conf),
    \ '/': wilder#popupmenu_renderer(g:highlighter_conf),
    \ }))
