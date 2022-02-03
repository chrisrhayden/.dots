" https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
syntax match MyTODOCheckbox "\v\[\s\]" conceal cchar= containedin=ALL
syntax match MyTODOCheckbox "\v\[X\]" conceal cchar= containedin=ALL
syntax match MyTODOCheckbox "\v\[x\]" conceal cchar= containedin=ALL
syntax match MyTODOCheckbox "\v\[-\]" conceal cchar=☒ containedin=ALL
syntax match MyTODOCheckbox "\v\[\.\]" conceal cchar=⊡ containedin=ALL
syntax match MyTODOCheckbox "\v\[o\]" conceal cchar=⬕ containedin=ALL
