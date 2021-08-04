--------------------------------------------------------------------------------
-- mappings
--------------------------------------------------------------------------------

local map = vim.api.nvim_set_keymap

local nore_opts = {noremap = true}
local nore_silent_opts = {noremap = true, silent = true}

-- commands {{{
vim.cmd("command W :w")
vim.cmd("command Q :q")
-- }}}

-- disable things  {{{
-- disable EX mode, as I'm a pleb
map("", "Q", "<nop>", {})

-- i never want just the help index page
map("", "<help>", "<nop>", {})
map("", "<f1>",   "<nop>", {})
map("i", "<f1>", "<nop>", {})

-- disable Arrow keys
-- this is still kinda nice as scroll is sometimes arrow keys or something
map("", "<up>",    "<nop>", {})
map("", "<down>",  "<nop>", {})
map("", "<left>",  "<nop>", {})
map("", "<right>", "<nop>", {})
-- }}}

-- toggle highlight {{{
map("n", "<leader>h", ":set hlsearch!<cr>", nore_opts)
-- }}}

-- movements {{{
-- more then 5 to jump list; from primeagen
map("n", "j", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'", {
  noremap = true, expr = true
})

map("n", "k", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'", {
  noremap = true, expr = true
})
-- }}}

-- move lines around {{{
-- these are all from primeagen

-- keep cursor at the same place when joining lines
map("n", "J", "mzJ`z", nore_opts)

-- move lines around in normal mode
map("n", "<leader>[", ":m .-2<cr>==", nore_opts)
map("n", "<leader>]", ":m .+1<cr>==", nore_opts)

map("n", "<leader>j", ":m .-2<cr>==", nore_opts)
map("n", "<leader>k", ":m .+1<cr>==", nore_opts)

map("v", "J", ":m '>+1<cr>gv=gv", nore_opts)
map("v", "K", ":m '<-2<cr>gv=gv", nore_opts)
-- }}}

-- yank to clipboard {{{
-- Yank to the end of line, I think this unused ??? holy shit
map("n", "Y", "y$", nore_opts)
-- yank to clip board {{{
-- yank file
map("n", "<leader>yf", 'gg"+yG``', nore_opts)
-- yank line
map("n", "<leader>yy", '"+yy', nore_opts)
-- yank to end of line
map("n", "<leader>Y",  '"+y$', nore_opts)
-- yank word
map("n", "<leader>yw", '"+yw', nore_opts)
-- }}}

-- }}}

-- search {{{
-- from primeagen
map("n", "n", "nzzzv", nore_opts)
map("n", "N", "Nzzzv", nore_opts)
-- }}}

-- Fold {{{
map("n", "<Leader>f0", ":set foldlevel=0<CR>", nore_opts)
map("n", "<Leader>f1", ":set foldlevel=1<CR>", nore_opts)
map("n", "<Leader>f2", ":set foldlevel=2<CR>", nore_opts)
map("n", "<Leader>f3", ":set foldlevel=3<CR>", nore_opts)
map("n", "<Leader>f4", ":set foldlevel=4<CR>", nore_opts)
map("n", "<Leader>f5", ":set foldlevel=5<CR>", nore_opts)
map("n", "<Leader>f6", ":set foldlevel=6<CR>", nore_opts)
map("n", "<Leader>f7", ":set foldlevel=7<CR>", nore_opts)
map("n", "<Leader>f8", ":set foldlevel=8<CR>", nore_opts)
map("n", "<Leader>f9", ":set foldlevel=9<CR>", nore_opts)
-- }}}

-- buffer {{{
-- switch buffer
map("n", "<bs>", "<C-^>", nore_opts)

-- list buffers
map("n", "<leader>ls", ":ls<cr>", nore_opts)
map("n", "<Leader>bd", ":bdelete<CR>", nore_opts)
-- nnoremap <Leader>bD :bdelete!<CR>
map("n", "<Leader>bf", ":bfirst<CR>", nore_opts)
-- nnoremap <Leader>bw :bw<CR>
map("n", "<Leader>bl", ":blast<CR>", nore_opts)
map("n", "<Leader>bn", ":bnext<CR>", nore_opts)
map("n", "<Leader>bp", ":bprevious<CR>", nore_opts)
-- }}}

-- Window {{{
-- movement
-- move windows with CTRL-{h,j,k,l}
map("n", "<C-J>", ":silent wincmd j<cr>", nore_silent_opts)
map("n", "<C-K>", ":silent wincmd k<cr>", nore_silent_opts)
map("n", "<C-L>", ":silent wincmd l<cr>", nore_silent_opts)
map("n", "<C-H>", ":silent wincmd h<cr>", nore_silent_opts)

-- this is good shit
map("n", "<M-h>", ":vertical resize -10<cr>", nore_opts)
map("n", "<M-k>", ":resize -10<cr>", nore_opts)
map("n", "<M-l>", ":vertical resize +10<cr>", nore_opts)
map("n", "<M-j>", ":resize +10<cr>", nore_opts)
map("n", "<M-=>", "<C-W><C-=>", nore_opts)

-- for anything
map("n", "<leader>C", ":close<CR>", nore_opts)
map("n", "<leader>o", ":only<CR>", nore_opts)

-- quickfix
map("n", "<leader>co", ":copen<CR>", nore_opts)
map("n", "<leader>cc", ":cclose<CR>", nore_opts)
map("n", "<leader>cl", ":colder<CR>", nore_opts)
map("n", "<leader>cn", ":cnext<CR>", nore_opts)
map("n", "<leader>cP", ":cprevious<CR>", nore_opts)

-- for local window
map("n", "<leader>lo", ":lopen<CR>", nore_opts)
map("n", "<leader>lc", ":lclose<CR>", nore_opts)
map("n", "<leader>ll", ":lolder<CR>", nore_opts)
map("n", "<leader>ln", ":lnewer<CR>", nore_opts)
-- }}}

-- tab {{{
map("n", "<leader>tp", ":tabprevious<cr>", nore_opts)
map("n", "<leader>tn", ":tabnext<cr>", nore_opts)
map("n", "<leader>tN", ":tabnew<cr>", nore_opts)
-- -- }}}

-- terminal {{{
-- make ecs escape terminal
-- map("n", "<Esc>", "<C-\><C-n>", nore_opts)

map("n", "<leader>te", ":split <bar> terminal<cr>", nore_opts)
map("n", "<leader>`", ":split <bar> terminal<cr>", nore_opts)
-- }}}

-- gdb termdebug debugging {{{
-- dont overwrite d{motion}
-- this overwrites d<cr>, i dont really use <cr> but it does seem nice
map("n", "d<cr>", ":Break<cr>", nore_opts)
map("n", "dx", ":Clear<cr>", nore_opts)
map("n", "dc", ":Continue<cr>", nore_opts)
map("n", "dm", ":Finish<cr>", nore_opts)
-- this is next in gdb but Next is a vim command
map("n", "dq", ":Over<cr>", nore_opts)
map("n", "dr", ":Run<cr>", nore_opts)
map("n", "dQ", ":Step<cr>", nore_opts)
-- stop debugging
map("n", "dC", ":Stop<cr>", nore_opts)
-- }}}

-- misc {{{
-- overwrite <c-g> to echo the full file path
map("n", "<C-g>", ":echomsg expand('%:p')<cr>", nore_silent_opts)
map("n", "<C-g>", ":echomsg expand('%:p')<cr>", nore_silent_opts)

-- like `ZZ` but will quit all files
map("n", "ZA", ":qa!<CR>", nore_opts)
-- }}}

-- vim: foldmethod=marker
