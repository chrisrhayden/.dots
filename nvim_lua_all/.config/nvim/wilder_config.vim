let g:highlighter_conf = wilder#popupmenu_border_theme({
    \   "highlighter": wilder#basic_highlighter(),
    \   "right": [" ", wilder#popupmenu_scrollbar({
    \      "thumb_char": " "
    \   })],
    \ "highlights": {
    \   "border":  "FloatBorder",
    \ },
    \ 'border': 'rounded',
    \ })

call wilder#setup({
      \ "modes": [":", "/", "?"],
      \ "next_key": "<Tab>",
      \ "previous_key": "<S-Tab>",
      \ })

call wilder#set_option("renderer", wilder#wildmenu_renderer({
      \ "highlighter": wilder#basic_highlighter(),
      \ "left": [" ", wilder#wildmenu_spinner(), " "],
      \ "right": [" ", wilder#wildmenu_index()],
      \ }))

call wilder#set_option("renderer", wilder#renderer_mux({
      \ ":": wilder#popupmenu_renderer(g:highlighter_conf),
      \ "/": wilder#popupmenu_renderer(g:highlighter_conf),
      \ "?": wilder#popupmenu_renderer(g:highlighter_conf),
      \ }))
