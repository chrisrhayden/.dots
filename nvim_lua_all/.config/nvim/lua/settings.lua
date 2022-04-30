--------------------------------------------------------------------------------
-- settings
--------------------------------------------------------------------------------

-- NOTE: there is potential that some settings sould be buffer/window local but
-- i haven't run in to any issues so far

local o = vim.opt

-- security {{{
-- mode lines allow per-file settings to be embedded in the file
-- o.modeline = true

-- dont run non standard vimrc, off by default
o.exrc = false

-- disallow certain vim functions from being run in non standard vimrc's
o.secure = true
-- }}}

-- setup paths {{{
local backup_dir = vim.env.XDG_DATA_HOME .. "/nvim/backup//"
-- make sure backup files are made in `$XDG_DATA_HOME/nvim/backup/`
o.backupdir = backup_dir

local word_dir = vim.env.XDG_CONFIG_HOME .. "/nvim/words"
vim.fn.mkdir(word_dir, "p")
-- where to save personal words for spell check, (i.e. words added with zg)
o.spellfile = word_dir .. "/code-en.utf-8.add"
-- thesaurus completion, <C-x><C-t>,
-- this needs to be installed by hand
o.thesaurus = word_dir .. "/en_thesaurus.txt"
-- }}}

-- ui {{{
-- redraw only when the user changes the screen
o.lazyredraw = true
-- use the number column, set below
o.number = true
-- use relative numbers for the number column
o.relativenumber = true
-- visually show potential changes
o.inccommand = "split"
-- visually break lines according to `breakat` instead of the last fitting char
o.linebreak = true
-- whether to wrap long lines
o.wrap = false
-- highlight or underline the line the cursor is on
o.cursorline = true
-- minimum lines to keep above and below the cursor
o.scrolloff = 4
-- minimum characters between the cursor and the sides similar to scrolloff
-- o.sidescrolloff = 4
-- o.colors to be very close to gui vim, set with color scheme
o.termguicolors = true
-- set whether syntax with the conceal attribute is shown
o.conceallevel = 2
-- list mode will display given characters in certain places (e.g. <tab>  = = >-)
o.list = true
-- the characters list mode will use
o.listchars = {
  tab = ">-",
  trail = "·",
  extends = "ᐳ",
  precedes = "ᐸ",
  nbsp = "+",
}
-- characters for certain parts of the ui
o.fillchars = {
  eob = " ",
  fold = "-",
  foldopen = "┌",
  foldclose = "+",
  foldsep = "│",
  diff = "-",
}
-- highlight columns at the given column number
o.colorcolumn = {
  "81",
  "101",
}

-- the status line config
-- check if the LspStatus function exists and if so get the result to print to
-- the status line
-- this kinda sucks but since this is only my status line being generic is
-- pointless
function CheckLspStatus()
  if LspStatus ~= nil then
    return LspStatus()
  else
    return ""
  end
end

o.statusline = table.concat({
  "", -- will add a space from the separator
  -- "%n",      -- buffer number
  "%{winnr()}", -- window number
  "%t", -- file name, only the tail
  "%m", -- buffer state
  "%r", -- if the buffer is read only
  "%=", -- adjust the next items to the left
  "%{v:lua.CheckLspStatus()}",
  "%=", -- adjust the next items to the left
  "%y", -- file type
  "[%l/%L]", -- show current line out of all lines
  "", -- same as the first
}, " ")
-- }}}

-- feel / editing {{{
-- o.shortmess = "a"
-- how completions work in insert mode
o.completeopt = {
  "menuone",
  "noselect",
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
  "cursor",
}
-- save these settings when making sessions
o.sessionoptions = {
  "buffers",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "sesdir",
}
-- settings for the shada file
o.shada = {
  "'100",
  "s10",
  "h",
  "f1",
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

-- language specific settings {{{
-- make vim treat *.h files like c not cpp
-- TODO: this could probably be set somewhere else to also use cpp
vim.g.c_syntax_for_h = 1
-- }}}

-- interpreters {{{
-- use the VIRTUAL_ENV path if it exists else just use the system default
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. "/bin/python3"
else
  vim.g.python3_host_prog = "/usr/bin/python3"
end

-- turn off support for unneeded interpreters
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
-- }}}

-- built in pkgs {{{
-- debug with vim
vim.cmd("packadd! termdebug")

-- use a wide layout for termdebug
vim.g.termdebug_wide = 1
-- }}}

-- augroups {{{
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- relativenumber {{{
-- from https://github.com/jeffkreeftmeijer/vim-numbertoggle/
function ToggleRelNumber()
  if vim.g.use_relnumber == true then
    vim.g.use_relnumber = false

    vim.opt.relativenumber = false
  else
    vim.g.use_relnumber = true

    vim.opt.relativenumber = true
  end
end

vim.api.nvim_create_user_command("ToggleRelNumber", ToggleRelNumber, {})

local relative_group = create_augroup("RelativeGroup", {})

-- toggle relativenumber
local set_relative = {
  "BufEnter",
  "InsertLeave",
  "WinEnter",
  "CmdlineLeave",
  "FocusGained",
}
local set_norelative = {
  "BufLeave",
  "InsertEnter",
  "WinLeave",
  "CmdlineEnter",
  "FocusLost",
}

vim.g.use_relnumber = true

-- "if &number | set relativenumber | endif",
create_autocmd(set_relative, {
  pattern = "*",
  group = relative_group,
  callback = function()
    if vim.wo.number == true and vim.g.use_relnumber == true then
      vim.opt.relativenumber = true
    end
  end,
})

create_autocmd(set_norelative, {
  pattern = "*",
  group = relative_group,
  callback = function()
    if vim.g.use_relnumber == true then
      vim.opt.relativenumber = false
    end
  end,
})
-- }}}

-- show/hide cursorline {{{
-- https://stackoverflow.com/questions/14068751/
-- how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
local cursor_line_group = create_augroup("CursorLineGroup", { clear = true })

local set_cursorline = { "VimEnter", "BufEnter", "WinEnter" }
local set_nocursorline = { "BufLeave", "WinLeave" }

create_autocmd(set_cursorline, {
  command = "setlocal cursorline",
  group = cursor_line_group
})

create_autocmd(set_nocursorline, {
  command = "setlocal nocursorline",
  group = cursor_line_group
})
-- }}}

-- ripgrep instead of grep {{{
-- https://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --no-heading"
  o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.cmd("cnoreabbrev rg grep")
end
-- }}}

-- auto save views {{{
-- https://vim.fandom.com/wiki/Make_views_automatic
-- this is sort of a last resort to ignore buffers that are special but still
-- are treated like normal files
local skip_filetypes = { "gitcommit" }

function SpecialBuffer()
  -- if not empty then the buffer is a `special-buffer` like help and plugins
  -- that use this as well like tagbar
  if vim.bo.buftype ~= "" then
    return true

    -- if the buffer is not listed then its a special buffer
    -- if a plugin doesn't use buftype well i doubt it will use buflisted but idk
  elseif vim.bo.buflisted == false then
    return true

    -- skip the given file types
  elseif vim.tbl_contains(skip_filetypes, vim.bo.filetype) == true then
    return true
  end

  -- else its a normal file
  return false
end

local auto_save_view_group = create_augroup("AutoSaveView", {})

local save_view = {
  "BufWritePost",
  "BufLeave",
  "WinLeave",
  "InsertLeave",
}

create_autocmd(save_view, {
  group = auto_save_view_group,
  pattern = "*",
  callback = function()
    if SpecialBuffer() == false then
      vim.cmd("mkview")
    end
  end,
})

create_autocmd("BufWinEnter", {
  group = auto_save_view_group,
  pattern = "*",
  callback = function()
    if SpecialBuffer() == false then
      vim.cmd("silent! loadview")
    end
  end
})
-- }}}
-- }}}

-- vim: foldmethod=marker
