--------------------------------------------------------------------------------
--- settings.lua
--------------------------------------------------------------------------------

-- security {{{
-- mode lines allow per-file settings to be embedded in the file
vim.opt.modeline = true

-- don't run non standard vimrc, off by default
vim.opt.exrc = false
-- end security }}}

-- setup paths {{{
-- make backup files to ~/.local/state/nvim/backup/ and not to $PWD
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup//"

-- use ~/.config/nvim/words for spelling a thesaurus files
local word_dir = vim.fn.stdpath("config") .. "/words"
vim.fn.mkdir(word_dir, "p")

vim.opt.spellfile = word_dir .. "/code-en.utf-8.add"
vim.opt.thesaurus = word_dir .. "/en_thesaurus.txt"
-- end setup paths }}}

-- ui {{{
-- avoid hit enter prompts and shorten certain messages
vim.opt.shortmess = "ao"
-- use the number column
vim.opt.number = true
-- use relative numbers for the number column
vim.opt.relativenumber = true
-- visually show potential changes
vim.opt.inccommand = "split"
-- do not highlight search things
vim.opt.hlsearch = false
-- visually break lines according to `breakat` instead of the last fitting char
vim.opt.linebreak = true
-- whether to wrap long lines, i cant decide whether I like this or not
vim.opt.wrap = false
-- underline or highlight the line the cursor is on
vim.opt.cursorline = true
-- minimum lines to keep above and below the cursor when next to the edge
vim.opt.scrolloff = 4
-- set colors to be very close to gui vim
vim.opt.termguicolors = true
-- set whether syntax with the conceal attribute is shown
vim.opt.conceallevel = 2
-- list mode will display characters in certain places (e.g. <tab> in to >-)
vim.opt.list = true
-- the characters list mode will use
vim.opt.listchars = {
  tab = ">-",
  trail = "·",
  extends = "ᐳ",
  precedes = "ᐸ",
  nbsp = "+",
}
-- characters for certain parts of the ui
vim.opt.fillchars = {
  eob = "~",
  fold = "-",
  foldopen = "┌",
  foldclose = "+",
  foldsep = "│",
  diff = "-",
}
-- highlight columns at the given column number
-- i keep forgetting i set this to 81 and not 80
vim.opt.colorcolumn = {
  "81",
  "101",
}
-- end ui }}}

-- feel / editing {{{
vim.opt.smoothscroll = true
-- disable mouse support
vim.opt.mouse = nil
-- how completions work in insert mode
vim.opt.completeopt = {
  "menuone",
  "noselect",
}
-- disable the swapfile
vim.opt.swapfile = false
-- time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 500
-- this is the count for CursorHold and writing out to the swap file
vim.opt.updatetime = 500
-- turn on spell checking
vim.opt.spell = true
-- don't flag uncapitalised words as misspelled
vim.opt.spellcapcheck = nil
-- search case insensitive
vim.opt.ignorecase = true
-- override `ignorecase` when an upper case letter is used
vim.opt.smartcase = true
-- always insert spaces instead of a tab
vim.opt.expandtab = true
-- the number of spaces tabs equate to
vim.opt.tabstop = 4
-- what auto indent uses (e.g. >>), 0 makes it use the `tabstop` value
vim.opt.shiftwidth = 0
-- indent to the same level as the surrounding text
vim.opt.smartindent = true
-- physically break lines as 80 characters
vim.opt.textwidth = 80
-- text folding method
vim.opt.foldmethod = "indent"
-- what level to start folds (0 = all closed, 99 = all open)
vim.opt.foldlevelstart = 99
-- max nested folds
vim.opt.foldnestmax = 5
-- split below or right by default
vim.opt.splitbelow = true
vim.opt.splitright = true
-- save these settings when making views
vim.opt.viewoptions = {
  "folds",
  "cursor",
}
-- save these settings when making sessions
vim.opt.sessionoptions = {
  "buffers",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "sesdir",
}
-- define how vim will format text
-- from tjdevries
-- vim.opt.formatoptions = vim.opt.formatoptions
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
-- end feel /editing }}}

-- language settings {{{
-- C {{{
-- make vim treat *.h files like c not cpp
-- TODO: this could probably be set somewhere else to also use cpp
vim.g.c_syntax_for_h = 1
-- }}}
--
-- rust {{{
-- we have rustfmt so let me just type the way i want
vim.g.rust_recommended_style = 0
-- }}}
-- end language settings }}}

-- interpreters {{{
-- use the VIRTUAL_ENV path if it exists else just use the system default
if vim.env.VIRTUAL_ENV then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. "/bin/python3"
else
  vim.g.python3_host_prog = "/usr/bin/python3"
end

-- turn off support for unneeded interpreters
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- end interpreters }}}

-- built in pkgs {{{
-- use a wide layout for termdebug
vim.g.termdebug_wide = 1
-- }}}

-- ripgrep instead of grep {{{
-- https://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.cmd [[cnoreabbrev rg grep]]
end
-- }}}

-- augroups {{{
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- relative number {{{
vim.g.use_relnumber = true

-- toggle relative number if undesired
vim.api.nvim_create_user_command("ToggleRelNumber", function()
    if vim.g.use_relnumber == true then
      vim.g.use_relnumber = false

      vim.opt.relativenumber = false
    else
      vim.g.use_relnumber = true

      vim.opt.relativenumber = true
    end
  end,
  {}
)

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

create_autocmd(set_relative, {
  group = relative_group,
  callback = function()
    if vim.wo.number == true and vim.g.use_relnumber == true then
      vim.opt.relativenumber = true
    end
  end,
})

create_autocmd(set_norelative, {
  group = relative_group,
  callback = function()
    vim.opt.relativenumber = false
  end,
})
-- }}}

-- show/hide cursorline {{{
-- https://stackoverflow.com/questions/14068751/
-- how-to-hide-cursor-line-when-focus-in-on-other-window-in-vim
local cursor_line_group = create_augroup("CursorLineGroup", {})

-- local cursorline_envt = { "BufWinEnter", "WinEnter" }
-- local nocursorline_envt = { "BufLeave", "WinLeave" }

local cursorline_envt = { "WinEnter" }
local nocursorline_envt = { "WinLeave" }

create_autocmd(cursorline_envt, {
  command = "setlocal cursorline",
  group = cursor_line_group
})

create_autocmd(nocursorline_envt, {
  command = "setlocal nocursorline",
  group = cursor_line_group
})
-- }}}

-- save cursor {{{
local skip_filetypes = { "gitcommit" }

-- this might not be necessary
function SpecialBuffer()
  -- if not empty then the buffer is a `special-buffer` like help and plugins
  -- that use this as well like tagbar
  if vim.bo.buftype ~= "" then
    return true

    -- if the buffer is not listed then its a special buffer
    -- if a plugin doesn't use buftype well i doubt it will use buflisted
  elseif vim.bo.buflisted == false then
    return true

    -- skip the given file types
  elseif vim.tbl_contains(skip_filetypes, vim.bo.filetype) == true then
    return true
  end

  -- else its a normal file
  return false
end

local restore_cursor = create_augroup("RestoreCursor", {})

create_autocmd("BufReadPost", {
  group = restore_cursor,
  pattern = "*",
  callback = function()
    local row_col = vim.api.nvim_buf_get_mark(0, '"')
    if SpecialBuffer() == false and
      row_col ~= { 0, 0 } and row_col[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, row_col)
    end
  end
})
-- }}}

-- force file type options {{{
local file_type_group = create_augroup("ResetFileType", {})

-- this is kinda bad but there isn't a better way
-- a bunch of language files distributed with vim set formatoptions and more
-- so this will reset it, it would be nice if they didn't
create_autocmd({ "FileType" }, {
  group = file_type_group,
  command = "set formatoptions<"
})
-- }}}

-- end augroups }}}

-- vim: foldmethod=marker
