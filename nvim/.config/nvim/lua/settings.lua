--------------------------------------------------------------------------------
--- settings.lua
--------------------------------------------------------------------------------

-- setup paths {{{
-- make backup files to ~/.local/state/nvim/backup/ and not to $PWD
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup//"

-- use ~/.config/nvim/words for spelling and thesaurus files
local word_dir = vim.fn.stdpath("config") .. "/words"
vim.fn.mkdir(word_dir, "p")

-- where words added with `zg` are appended to
vim.opt.spellfile = word_dir .. "/code-en.utf-8.add"
vim.opt.thesaurus = word_dir .. "/en_thesaurus.txt"
-- end setup paths }}}

-- ui {{{
-- avoid hit enter prompts and shorten certain messages
-- vim.opt.shortmess = "aTWcCF"
-- use the number column
vim.opt.number = true
-- use relative numbers for the number column
vim.opt.relativenumber = true
-- visually show potential changes
vim.opt.inccommand = "split"
-- whether or not vim will highlight search items
vim.opt.hlsearch = false
-- visually break lines according to `breakat` instead of the last fitting chara
-- cter
vim.opt.linebreak = true
-- visually indent wrapped lines
vim.opt.breakindent = true
-- whether to wrap long lines, i cant decide whether I like this on or not
vim.opt.wrap = false
-- minimum lines to keep above and below the cursor when next to the edge
vim.opt.scrolloff = 4
-- set colors to be very close to gui vim
vim.opt.termguicolors = true
-- set whether syntax with the conceal attribute is shown
vim.opt.conceallevel = 2
-- highlight the line the cursor is on
vim.opt.cursorline = true
-- highlight columns at the given column number
vim.opt.colorcolumn = {
  "81",
  "101",
}
-- list mode will display characters in certain places (e.g. <tab> in to >-)
vim.opt.list = true
-- the characters that `list` will use
vim.opt.listchars = {
  tab = ">-",
  trail = "·",
  extends = "ᐳ",
  precedes = "ᐸ",
  nbsp = "+",
  -- leadmultispace="┊ "
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
-- end ui }}}

-- feel / editing {{{
-- disable mouse support
vim.opt.mouse = ""
-- use screen lines when `wrap` is on
vim.opt.smoothscroll = true
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
-- override `ignorecase` when an upper case letter is used in search
vim.opt.smartcase = true
-- like smartcase but for completion
vim.opt.infercase = true
-- always insert spaces instead of a tab
vim.opt.expandtab = true
-- the number of spaces tabs equate to
vim.opt.tabstop = 4
-- what auto indent uses (e.g. >>), 0 makes it use the `tabstop` value
vim.opt.shiftwidth = 0
-- indent to the same level as the surrounding text
vim.opt.smartindent = true
-- add lines breaks at 80 characters
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
-- define how vim will format text, from tjdevries
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linter's for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in grade school anymore
-- end feel / editing }}}

-- language settings {{{
-- C {{{
-- make vim treat *.h files like c not cpp
-- TODO: this could probably be set somewhere else to also use cpp
vim.g.c_syntax_for_h = 1
-- }}}

-- rust {{{
-- we have rustfmt so let me just type the way i want
vim.g.rust_recommended_style = 0
-- }}}
-- end language settings }}}

-- interpreters {{{
-- turn off support for unneeded interpreters
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- end interpreters }}}

-- built in pkgs {{{
-- use a wide layout for termdebug
vim.g.termdebug_wide = 1
-- end built in pkgs }}}

-- ripgrep instead of grep {{{
-- https://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.cmd.cnoreabbrev "rg grep"
end
-- }}}

-- fold text {{{1
-- just display the first folded line
function MyFoldText()
  local line = vim.fn.getline(vim.v.foldstart)

  -- taken from `help fold-foldtext`, cant be bothered to use gsub
  -- `line` should never be a list
  ---@cast line string
  local sub = vim.fn.substitute(line, [[/\*\|\*/\|{{{\d\=]], " ", "g") or ""

  local start = sub:match("^%s+") or ""

  if start ~= "" then
    start = start:gsub("%s", vim.opt.fillchars:get()["fold"])

    start = start:sub(1, #start - 1) .. " "
  end

  sub = sub:match("^%s*(.-)%s*$") or ""

  return start .. sub .. " "
end

vim.opt.foldtext = "v:lua.MyFoldText()"
-- end fold text }}}1

-- diagnostics {{{
-- might add these to lua/mappings.lua
local set_key = require("util").set_key

set_key {
  "<leader>n",
  vim.diagnostic.goto_next,
  desc = "go to next diagnostic",
}

set_key {
  "<leader>N",
  vim.diagnostic.goto_prev,
  desc = "go to prev diagnostic",
}

set_key {
  "<leader>dl",
  vim.diagnostic.setloclist,
  desc = "set local list with diagnostics"
}

-- how diagnostics will be shown
vim.diagnostic.config {
  virtual_text = false,
  underline = false,
  signs = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    border = "rounded",
  }
}

vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "󰍉",
  texthl = "DiagnosticSignHint",
})
-- end diagnostics }}}

-- vim: foldmethod=marker
