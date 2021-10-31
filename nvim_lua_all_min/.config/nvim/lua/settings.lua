--------------------------------------------------------------------------------
-- settings
--------------------------------------------------------------------------------
-- short cut to set options
local o = vim.opt

-- make a directory if it does not exist
local function mkdir_if_missing(dir_path)
  if vim.fn.isdirectory(dir_path) == 0 then
    vim.cmd("silent !mkdir " .. dir_path)
  end
end

-- security {{{
-- mode lines allow per-file settings to be embedded in the file
-- o.modeline = true

-- dont run non standard vimrc, off by default
o.exrc = false

-- disallow certain vim functions from being run in non standard vimrc's
o.secure = true
-- }}}

-- setup paths {{{
-- make sure backup files are made in `$XDG_DATA_HOME/nvim/backup/`
o.backupdir = vim.env.XDG_DATA_HOME .. "/nvim/backup//"
-- make the backup directory
mkdir_if_missing(vim.o.backupdir)

local word_dir = vim.env.XDG_CONFIG_HOME .. "/nvim/words"
-- where to save personal words for spell check, (i.e. words added with zg)
o.spellfile = word_dir .. "/code-en.utf-8.add"
-- thesaurus completion, <C-x><C-t>
o.thesaurus = word_dir .. "/en_thesaurus.txt"
-- make the word directory
mkdir_if_missing(word_dir)
-- }}}

-- ui {{{
-- redraw only when the user changes the screen
-- o.lazyredraw = true
-- use the number column, set below
o.number = true
-- use relative numbers for the number column
o.relativenumber = true
-- visually show potential changes
o.inccommand = "split"
-- visually break lines according to `breakat` instead of the last fitting char
o.linebreak = true
-- highlight or underline the line the cursor is on
-- o.cursorline = true
-- minimum lines to keep above and below the cursor
o.scrolloff = 2
-- minimum characters between the cursor and the sides similar to scrolloff
o.sidescrolloff = 2
-- o.colors to be very close to gui vim
o.termguicolors = true
-- list mode will display given characters in certain places (e.g. <tab>  = = >-)
o.list = true
-- the characters list mode will use
o.listchars = {
  tab      = ">-",
  trail    = "·",
  extends  = ">",
  precedes = "<",
  nbsp     = "+"
}
-- highlight columns at the given column number
o.colorcolumn = {
  "81",
  "101"
}
-- the status line config
o.statusline = table.concat({
  "",           -- will add a space from the separator
  -- "%n",      -- buffer number
  "%{winnr()}",
  "%t",         -- file name, only the tail
  "%m",         -- buffer state
  "%r",         -- if the buffer is read only
  "%=",         -- adjust the next items to the left
  "%y",         -- file type
  "[%l/%L]",    -- show current line out of all lines
  ""         -- same as the first
}, " ")
-- }}}

-- feel / editing {{{
o.completeopt = {
  "menuone",
  "noselect"
}
-- disable the swapfile
o.swapfile = false
-- time in milliseconds to wait for a mapped sequence to complete
o.timeoutlen = 500
-- this is the count for CursorHold and writing out to the swap file
o.updatetime = 500
-- turn on spell checking
o.spell = true
-- search case insensitive
o.ignorecase = true
-- override `ignorecase` when an upper case letter is used
o.smartcase = true
-- always insert spaces instead of a tab
o.expandtab = true
-- the number of spaces tabs equate to
o.tabstop = 4
-- what auto indent uses (e.g. >>), 0 makes it use the `tabstop` value
o.shiftwidth = 0
-- indent to the same level as the surrounding text
o.smartindent = true
-- physically break lines as 80 characters
o.textwidth = 80
-- text folding method
o.foldmethod = "indent"
-- what level to start folds (0 = all closed, 99 = all open)
o.foldlevelstart = 99
-- max nested folds
o.foldnestmax = 5
-- o.horizontal splits to below by default
o.splitbelow = true
-- o.vertical splits to right by default
o.splitright = true
-- save these settings when making views
o.viewoptions = {
  "folds",
  "cursor"
}
-- save these settings when making sessions
o.sessionoptions = {
  "buffers",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "sesdir"
}
-- settings for the shada file
o.shada = {
  "'100",
  "s10",
  "h",
  "f1"
}
-- define how vim will format text
-- vim.opt.formatoptions = "tcqjron"
-- from tjdevries
o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
-- }}}

-- relativenumber {{{
-- from https://github.com/jeffkreeftmeijer/vim-numbertoggle/
-- toggle relativenumber

local set_relative = "BufEnter,InsertLeave,WinEnter,CmdlineLeave,FocusGained"
local set_norelative = "BufLeave,InsertEnter,WinLeave,CmdlineEnter,FocusLost"

-- local set_relative = "BufEnter,InsertLeave,WinEnter,CmdlineLeave"
-- local set_norelative = "BufLeave,InsertEnter,WinLeave,CmdlineEnter"

vim.api.nvim_exec([[
augroup RelativizeNum
  autocmd!
  autocmd ]] .. set_relative .. [[ * if &number | set relativenumber | endif
  autocmd ]] .. set_norelative .. [[ * if &number | set norelativenumber | endif
augroup END
]], false)
-- }}}

-- only show cursorline in current window cursorline {{{
-- https://stackoverflow.com/questions/14068751/
-- how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
local set_cursorline = "VimEnter,BufEnter,WinEnter"
local set_nocursorline = "BufLeave,WinLeave"

vim.api.nvim_exec([[
augroup CursorLine
    autocmd!
    autocmd ]] .. set_cursorline .. [[ * setlocal cursorline
    autocmd ]] .. set_nocursorline .. [[ * setlocal nocursorline
augroup END
]], false)
-- }}}

-- ripgrep instead of grep {{{
-- https://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if vim.fn.executable('rg') == 1 then
  o.grepprg = "rg --vimgrep --no-heading"
  o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.cmd("cnoreabbrev rg grep")
end
-- }}}

-- built in pkgs {{{
-- debug with vim
vim.cmd("packadd! termdebug")

-- use a wide layout for termdebug
vim.g.termdebug_wide = 1
-- }}}

-- language specific settings {{{
-- make vim treat *.h files like c not cpp
vim.g.c_syntax_for_h = 1

-- disable the built in python style so vim keeps the global default for python
-- vim.g.python_recommended_style = 0
-- }}}

-- interpreters {{{
-- use the VIRTUAL_ENV path if it exists else just use the system default
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. '/bin/python3'
else
  vim.g.python3_host_prog = '/usr/bin/python3'
end

-- turn off support for unneeded interpreters
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
-- }}}

-- vim: foldmethod=marker
