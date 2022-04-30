let g:highlighter_conf = wilder#popupmenu_border_theme({
    \   "highlighter": wilder#basic_highlighter(),
    \   "left": [" ", wilder#popupmenu_devicons()],
    \   "right": [" ", wilder#popupmenu_scrollbar({
    \      "thumb_char": " "
    \   })],
    \ "highlights": {
    \   "border":  "FloatBorder",
    \ },
    \ 'border': 'rounded',
    \ })

call wilder#set_option("renderer", wilder#renderer_mux({
      \ ":": wilder#popupmenu_renderer(g:highlighter_conf),
      \ "/": wilder#popupmenu_renderer(g:highlighter_conf),
      \ "?": wilder#popupmenu_renderer(g:highlighter_conf),
      \ }))

call wilder#setup({
      \ "modes": [":", "/", "?"],
      \ })
