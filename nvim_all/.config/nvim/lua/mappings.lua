--------------------------------------------------------------------------------
-- mappings.lua
--------------------------------------------------------------------------------

-- commands {{{
local command = vim.api.nvim_create_user_command

command("W", "w", {})
command("WQ", "wq", {})
command("Q", "q", {})
-- }}}

-- set keys {{{
local set_key = require("util").set_key

-- disable things  {{{
set_key { "<help>", "<nop>", mode = "", desc = "disable help" }
set_key { "<f1>", "<nop>", mode = { "", "i" }, desc = "disable help" }
set_key { "<up>", "<nop>", mode = "", desc = "disable key up" }
set_key { "<down>", "<nop>", mode = "", desc = "disable key down" }
set_key { "<left>", "<nop>", mode = "", desc = "disable key left" }
set_key { "<right>", "<nop>", mode = "", desc = "disable key right" }
-- }}}


-- unimpaired like {{{
local add_blank_lines = require("util").add_blank_lines

set_key {
  "]<space>",
  function()
    add_blank_lines(0)
  end,
  desc = "add [count] blank lines after line"
}

set_key {
  "[<space>",
  function()
    add_blank_lines(-1)
  end,
  desc = "add [count] blank line above line"
}
-- }}}

-- toggle things {{{
set_key { "<leader>h", ":set hlsearch!<cr>", desc = "toggle highlighting" }

set_key {
  "<leader>tc",
  function()
    if vim.wo.conceallevel == 2 then
      vim.wo.conceallevel = 0
    else
      vim.wo.conceallevel = 2
    end
  end,
  desc = "toggle conceal level"
}
-- }}}

-- these are all from primeagen {{{
-- movements {{{
set_key {
  "j",
  '(v:count > 5 ? "m\'" . v:count : "") . \'j\'',
  expr = true,
  desc = "add movement to jump list of more then 5"
}

set_key {
  "k",
  '(v:count > 5 ? "m\'" . v:count : "") . \'k\'',
  expr = true,
  desc = "add movement to jump list of more then 5"
}
-- }}}

-- move lines around {{{
set_key {
  "J",
  "mzJ`z",
  desc = "keep cursor at the same place when joining lines"
}

-- move lines around in normal mode
set_key { "<leader>[", ":m .-2<cr>==", desc = "move line up" }
set_key { "<leader>]", ":m .+1<cr>==", desc = "move line down" }
set_key { "<leader>k", ":m .+1<cr>==", desc = "move line up" }
set_key { "<leader>j", ":m .-2<cr>==", desc = "move line down" }

set_key {
  "J",
  ":m '>+1<cr>gv=gv",
  mode = "v",
  desc = "move selected text down"
}
set_key {
  "K",
  ":m '<-2<cr>gv=gv",
  mode = "v",
  desc = "move selected text up"
}
-- }}}

-- search {{{
set_key { "n", "nzzzv", desc = "center and open folds for next item" }
set_key { "N", "Nzzzv", desc = "center and open folds for next item" }
-- }}}
-- }}}

-- yank to clipboard {{{
set_key { "gy", '"+y', desc = "yank `motion` to clipboard" }
-- }}}

-- fold {{{
set_key {
  "<Leader>f0",
  ":set foldlevel=0<CR>",
  desc = "set fold level to num"
}
set_key {
  "<Leader>f9",
  ":set foldlevel=9<CR>",
  desc = "set fold level to num"
}
-- }}}

-- buffer {{{
-- switch buffer
set_key { "<bs>", "<C-^>", desc = "switch to last buffer" }

-- list buffers
set_key { "<leader>ls", ":ls<cr>" }
set_key { "<Leader>bd", ":bdelete<CR>" }
set_key { "<Leader>bf", ":bfirst<CR>" }
set_key { "<Leader>bl", ":blast<CR>" }
set_key { "<Leader>bn", ":bnext<CR>" }
set_key { "<Leader>bp", ":bprevious<CR>" }
set_key { "<leader>bb", ":ls<cr>:buffer " }
-- }}}

-- Window {{{
set_key { "<C-J>", ":silent wincmd j<cr>", desc = "move down a window" }
set_key { "<C-K>", ":silent wincmd k<cr>", desc = "move up a window" }
set_key { "<C-L>", ":silent wincmd l<cr>", desc = "move left a window" }
set_key { "<C-H>", ":silent wincmd h<cr>", desc = "move right a window" }

set_key {
  "<M-h>",
  ":vertical resize -10<cr>",
  desc = "shrink window vertically"
}

set_key {
  "<M-k>",
  ":resize -10<cr>",
  desc = "shrink window horizontally"
}

set_key {
  "<M-l>",
  ":vertical resize +10<cr>",
  desc = "grow window vertically"
}
set_key {
  "<M-j>",
  ":resize +10<cr>",
  desc = "grow window horizontally"
}

set_key { "<M-=>", "<C-W><C-=>", desc = "equalize window" }

set_key { "<leader>C", ":close<CR>", desc = "close current window" }
set_key { "<leader>O", ":only<CR>", desc = "show only current window" }

-- quickfix
set_key { "<leader>co", ":copen<CR>", desc = "open quickfix" }
set_key { "<leader>cc", ":cclose<CR>", desc = "close quickfix" }
set_key { "<leader>cl", ":colder<CR>", desc = "go to older error" }
set_key { "<leader>cn", ":cnext<CR>", desc = "go to next error" }
set_key { "<leader>cP", ":cprevious<CR>", desc = "go to prev error" }

-- local list
set_key { "<leader>lo", ":lopen<CR>", desc = "open local list" }
set_key { "<leader>lc", ":lclose<CR>", desc = "close local list" }
set_key { "<leader>ll", ":lolder<CR>", desc = "go to older item" }
set_key { "<leader>ln", ":lnewer<CR>", desc = "go to new item" }
-- }}}

-- tab {{{
set_key { "<leader>tp", ":tabprevious<cr>", desc = "go to prev tab" }
set_key { "<leader>tn", ":tabnext<cr>", desc = "go to next tab" }
set_key { "<leader>tN", ":tabnew<cr>", desc = "open new tab" }
-- }}}

-- terminal {{{
set_key {
  "<Esc>", [[<C-\><C-n>]],
  mode = "t",
  desc = "escape when in the terminal"
}

set_key { "<leader>`", ":split <bar> terminal<cr>", desc = "open a terminal" }
-- }}}

-- gdb term debug debugging {{{
set_key { "<leader>d<cr>", ":Break<cr>", desc = "set a breakpoint" }
set_key { "<leader>dx", ":Clear<cr>", desc = "delete a breakpoint" }
set_key { "<leader>dc", ":Continue<cr>", desc = "continue cmd" }
set_key { "<leader>dm", ":Finish<cr>", desc = "finish cmd" }
set_key { "<leader>dq", ":Over<cr>", desc = "next cmd" }
set_key { "<leader>dr", ":Run<cr>", desc = "run the program" }
set_key { "<leader>dQ", ":Step<cr>", desc = "step cmd" }
set_key { "<leader>dC", ":Stop<cr>", desc = "interrupt the program" }
-- }}}

-- misc {{{
set_key {
  "<C-g>",
  ":echomsg expand('%:p')<cr>",
  desc = "print full file name in cmd window"
}

set_key { "ZA", ":qa!<CR>", desc = "quit all files without saving" }
-- }}}
-- }}}

-- vim: foldmethod=marker
