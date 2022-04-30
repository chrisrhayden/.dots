--------------------------------------------------------------------------------
-- mappings
--------------------------------------------------------------------------------

local keymap = vim.keymap.set
local command = vim.api.nvim_create_user_command

-- commands {{{
command("W", 'w', {})
command("WQ", 'wq', {})
command("Q", 'q', {})
-- }}}

-- disable things  {{{
-- i never want just the help index page
keymap("", "<help>", "<nop>", {})
keymap({ "", "i" }, "<f1>", "<nop>", {})

-- disable Arrow keys
-- this is still kinda nice as scroll is sometimes arrow keys or something
keymap("", "<up>", "<nop>", {})
keymap("", "<down>", "<nop>", {})
keymap("", "<left>", "<nop>", {})
keymap("", "<right>", "<nop>", {})
-- }}}

-- toggle highlight {{{
keymap("n", "<leader>h", ":set hlsearch!<cr>")
-- }}}

-- these are all from primeagen {{{
-- movements {{{
-- if movement count is more then 5 then add the movement to the jump list
keymap("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', { expr = true })

keymap("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', { expr = true })
-- }}}

-- move lines around {{{
-- keep cursor at the same place when joining lines
keymap("n", "J", "mzJ`z", {})

-- move lines around in normal mode
keymap("n", "<leader>[", ":m .-2<cr>==", {})
keymap("n", "<leader>]", ":m .+1<cr>==", {})

keymap("n", "<leader>j", ":m .-2<cr>==", {})
keymap("n", "<leader>k", ":m .+1<cr>==", {})

keymap("v", "J", ":m '>+1<cr>gv=gv", {})
keymap("v", "K", ":m '<-2<cr>gv=gv", {})
-- }}}

-- search {{{
keymap("n", "n", "nzzzv", {})
keymap("n", "N", "Nzzzv", {})
-- }}}
-- }}}

-- yank to clipboard {{{
-- yank file
keymap("n", "<leader>yf", 'gg"+yG``', {})
-- yank line
keymap("n", "<leader>yy", '"+yy', {})
-- yank word
keymap("n", "<leader>yw", '"+yw', {})
-- yank `movement` to clipboard
-- weird that this isn't a default
keymap("n", "gy", '"+y', {})
-- }}}

-- Fold {{{
keymap("n", "<Leader>f0", ":set foldlevel=0<CR>", {})
keymap("n", "<Leader>f1", ":set foldlevel=1<CR>", {})
keymap("n", "<Leader>f2", ":set foldlevel=2<CR>", {})
keymap("n", "<Leader>f3", ":set foldlevel=3<CR>", {})
keymap("n", "<Leader>f4", ":set foldlevel=4<CR>", {})
keymap("n", "<Leader>f5", ":set foldlevel=5<CR>", {})
keymap("n", "<Leader>f6", ":set foldlevel=6<CR>", {})
keymap("n", "<Leader>f7", ":set foldlevel=7<CR>", {})
keymap("n", "<Leader>f8", ":set foldlevel=8<CR>", {})
keymap("n", "<Leader>f9", ":set foldlevel=9<CR>", {})
-- }}}

-- buffer {{{
-- switch buffer
keymap("n", "<bs>", "<C-^>", {})

-- list buffers
keymap("n", "<leader>ls", ":ls<cr>", {})
keymap("n", "<Leader>bd", ":bdelete<CR>", {})
-- nnoremap <Leader>bD :bdelete!<CR>
keymap("n", "<Leader>bf", ":bfirst<CR>", {})
-- nnoremap <Leader>bw :bw<CR>
keymap("n", "<Leader>bl", ":blast<CR>", {})
keymap("n", "<Leader>bn", ":bnext<CR>", {})
keymap("n", "<Leader>bp", ":bprevious<CR>", {})
-- }}}

-- Window {{{
-- movement
-- move windows with CTRL-{h,j,k,l}
keymap("n", "<C-J>", ":silent wincmd j<cr>", { silent = true })
keymap("n", "<C-K>", ":silent wincmd k<cr>", { silent = true })
keymap("n", "<C-L>", ":silent wincmd l<cr>", { silent = true })
keymap("n", "<C-H>", ":silent wincmd h<cr>", { silent = true })

-- this is good shit
keymap("n", "<M-h>", ":vertical resize -10<cr>", {})
keymap("n", "<M-k>", ":resize -10<cr>", {})
keymap("n", "<M-l>", ":vertical resize +10<cr>", {})
keymap("n", "<M-j>", ":resize +10<cr>", {})
keymap("n", "<M-=>", "<C-W><C-=>", {})

-- for anything
keymap("n", "<leader>C", ":close<CR>", {})
keymap("n", "<leader>O", ":only<CR>", {})

-- quickfix
keymap("n", "<leader>co", ":copen<CR>", {})
keymap("n", "<leader>cc", ":cclose<CR>", {})
keymap("n", "<leader>cl", ":colder<CR>", {})
keymap("n", "<leader>cn", ":cnext<CR>", {})
keymap("n", "<leader>cP", ":cprevious<CR>", {})

-- for local window
keymap("n", "<leader>lo", ":lopen<CR>", {})
keymap("n", "<leader>lc", ":lclose<CR>", {})
keymap("n", "<leader>ll", ":lolder<CR>", {})
keymap("n", "<leader>ln", ":lnewer<CR>", {})
-- }}}

-- tab {{{
keymap("n", "<leader>tp", ":tabprevious<cr>", {})
keymap("n", "<leader>tn", ":tabnext<cr>", {})
keymap("n", "<leader>tN", ":tabnew<cr>", {})
-- }}}

-- terminal {{{
-- make ecs escape terminal
keymap("t", "<Esc>", [[<C-\><C-n>]], {})

keymap("n", "<leader>`", ":split <bar> terminal<cr>", {})
-- }}}

-- gdb termdebug debugging {{{
-- dont overwrite d{motion}
-- this overwrites d<cr>, i dont really use <cr> but it does seem nice
keymap("n", "d<cr>", ":Break<cr>", {})
keymap("n", "dx", ":Clear<cr>", {})
keymap("n", "dc", ":Continue<cr>", {})
keymap("n", "dm", ":Finish<cr>", {})
-- this is next in gdb but Next is a vim command
keymap("n", "dq", ":Over<cr>", {})
keymap("n", "dr", ":Run<cr>", {})
keymap("n", "dQ", ":Step<cr>", {})
-- stop debugging
keymap("n", "dC", ":Stop<cr>", {})
-- }}}

-- misc {{{
-- overwrite <c-g> to echo the full file path
keymap("n", "<C-g>", ":echomsg expand('%:p')<cr>", { silent = true })
keymap("n", "<C-g>", ":echomsg expand('%:p')<cr>", { silent = true })

-- like `ZZ` but will quit all files
keymap("n", "ZA", ":qa!<CR>", {})
-- }}}

-- vim: foldmethod=marker
