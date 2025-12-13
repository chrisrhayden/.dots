--------------------------------------------------------------------------------
-- mappings.lua
--------------------------------------------------------------------------------
local set_keys = require("util").set_keys
local add_blank_lines = require("util").add_blank_lines
local command = vim.api.nvim_create_user_command

-- commands {{{
command("W", "w", {})
command("WQ", "wq", {})
command("Q", "q", {})
-- }}}

-- set keys {{{
set_keys {
  -- disable things  {{{
  { "<f1>", "<nop>", mode = { "", "i" }, desc = "disable help" },
  { "<up>", "<nop>", desc = "disable key up" },
  { "<down>", "<nop>", desc = "disable key down" },
  { "<left>", "<nop>", desc = "disable key left" },
  { "<right>", "<nop>", desc = "disable key right" },
  -- }}}
  -- generic {{{
  {
    "<C-g>",
    ":echomsg expand('%:p')<cr>",
    desc = "print full file name in cmd window"
  },

  { "ZA", ":qa!<CR>", desc = "quit all files without saving" },
  -- }}}
  -- add blank lines {{{
  {
    "]<space>",
    function()
      add_blank_lines(0)
    end,
    desc = "add [count] blank lines after line"
  },
  {
    "[<space>",
    function()
      add_blank_lines(-1)
    end,
    desc = "add [count] blank line above line"
  },
  -- }}}
  -- toggle things {{{
  { "<leader>h", ":set hlsearch!<cr>", desc = "toggle highlighting" },

  {
    "<leader>tc",
    function()
      if vim.wo.conceallevel > 0 then
        vim.wo.conceallevel = 0
      else
        vim.wo.conceallevel = 2
      end
    end,
    desc = "toggle conceal level"
  },
  -- }}}
  -- these are all from primeagen {{{
  -- movements {{{
  {
    "j",
    '(v:count > 5 ? "m\'" . v:count : "") . \'j\'',
    expr = true,
    desc = "add movement to jump list if more then 5"
  },
  {
    "k",
    '(v:count > 5 ? "m\'" . v:count : "") . \'k\'',
    expr = true,
    desc = "add movement to jump list if more then 5"
  },
  -- }}}

  -- move lines around {{{
  {
    "J",
    "mzJ`z",
    desc = "keep cursor at the same place when joining lines"
  },


  { "<leader>[", ":m .-2<cr>==", desc = "move line up" },
  { "<leader>]", ":m .+1<cr>==", desc = "move line down" },
  { "<leader>k", ":m .-2<cr>==", desc = "move line up" },
  { "<leader>j", ":m .+1<cr>==", desc = "move line down" },

  {
    "K",
    ":m '<-2<cr>gv=gv",
    mode = "v",
    desc = "move selected text up"
  },
  {
    "J",
    ":m '>+1<cr>gv=gv",
    mode = "v",
    desc = "move selected text down"
  },

  -- }}}

  -- search {{{
  { "n", "nzzzv", desc = "center and open folds for next item" },
  { "N", "Nzzzv", desc = "center and open folds for prev item" },
  -- }}}
  -- }}}
  -- yank to clipboard {{{
  { "gy", '"+y', mode = { "" }, desc = "yank [motion] to clipboard" },
  -- }}}
  -- fold {{{
  {
    "<Leader>f0",
    ":set foldlevel=0<CR>",
    desc = "open all folds"
  },
  {
    "<Leader>f9",
    ":set foldlevel=9<CR>",
    desc = "close all folds"
  },
  -- }}}
  -- buffer {{{
  -- switch buffer
  { "<bs>", "<C-^>", desc = "switch to last buffer" },
  -- { "<Leader>bd", ":bdelete<CR>", desc = "delete a buffer from list" },
  { "<Leader>bn", ":bnext<CR>", desc = "switch to next buffer" },
  { "<Leader>bp", ":bprevious<CR>", desc = "switch to prev buffer" },
  {
    "<Leader>bd", require("util").delete_buffer,
    desc = "delete a buffer from the list"
  },
  -- }}}
  -- tabs {{{
  -- switch buffer
  { "<Leader>tn", ":tabNext<CR>", desc = "switch to next tab" },
  { "<Leader>tp", ":tabprevious<CR>", desc = "switch to previous tab" },
  -- }}}
  -- window {{{
  -- better then i though it would be
  { "<C-j>", ":silent wincmd j<cr>", desc = "move down a window" },
  { "<C-k>", ":silent wincmd k<cr>", desc = "move up a window" },
  { "<C-l>", ":silent wincmd l<cr>", desc = "move left a window" },
  { "<C-h>", ":silent wincmd h<cr>", desc = "move right a window" },
  {
    "<M-h>",
    ":vertical resize -10<cr>",
    desc = "shrink window vertically"
  },
  {
    "<M-k>",
    ":resize -10<cr>",
    desc = "shrink window horizontally"
  },
  {
    "<M-l>",
    ":vertical resize +10<cr>",
    desc = "grow window vertically"
  },
  {
    "<M-j>",
    ":resize +10<cr>",
    desc = "grow window horizontally"
  },

  { "<M-=>", "<C-W><C-=>", desc = "equalize window" },

  { "<leader>C", ":close<CR>", desc = "close current window" },
  { "<leader>O", ":only<CR>", desc = "show only current window" },
  -- }}}
  -- quickfix/local list {{{
  -- i need to use these more
  { "<leader>co", ":copen<CR>", desc = "open quickfix" },
  { "<leader>cc", ":cclose<CR>", desc = "close quickfix" },
  { "<leader>cl", ":colder<CR>", desc = "go to older error" },
  { "<leader>cn", ":cnext<CR>", desc = "go to next error" },
  { "<leader>cp", ":cprevious<CR>", desc = "go to prev error" },

  { "<leader>lo", ":lopen<CR>", desc = "open local list" },
  { "<leader>lc", ":lclose<CR>", desc = "close local list" },
  { "<leader>ll", ":lolder<CR>", desc = "go to older item" },
  { "<leader>ln", ":lnewer<CR>", desc = "go to new item" },
  -- }}}
  -- terminal {{{
  {
    "<Esc>", [[<C-\><C-n>]],
    mode = "t",
    desc = "escape when in the terminal"
  },

  { "<leader>`", ":split <bar> terminal<cr>", desc = "open a terminal" },
  -- }}}
  -- -- gdb term debug debugging {{{
  -- -- i should use gdb more
  -- { "<leader>d<cr>", ":Break<cr>", desc = "set a breakpoint" },
  -- { "<leader>dx", ":Clear<cr>", desc = "delete a breakpoint" },
  -- { "<leader>dc", ":Continue<cr>", desc = "continue cmd" },
  -- { "<leader>dm", ":Finish<cr>", desc = "finish cmd" },
  -- { "<leader>dq", ":Over<cr>", desc = "next cmd" },
  -- { "<leader>dr", ":Run<cr>", desc = "run the program" },
  -- { "<leader>dQ", ":Step<cr>", desc = "step cmd" },
  -- { "<leader>dC", ":Stop<cr>", desc = "interrupt the program" },
  -- -- }}}
}
-- }}}

-- vim: foldmethod=marker
