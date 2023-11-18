-- auto cmds {{{

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- show diagnostics on cursor hold {{{
create_autocmd("CursorHold", {
  group = create_augroup("HoldForDiagnostics", {}),
  -- only show diagnostics if there isn't a popup window
  -- i fucking hate diagnostics taking the spot for docs
  callback = function()
    local wins = vim.api.nvim_list_wins()

    for _, win in pairs(wins) do
      if vim.fn.win_gettype(win) == "popup" then
        return
      end
    end

    vim.diagnostic.open_float(nil, {
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
    })
  end,
})
-- }}}

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

create_autocmd("WinEnter", {
  group = cursor_line_group,
  command = "setlocal cursorline",
})

create_autocmd("WinLeave", {
  group = cursor_line_group,
  command = "setlocal nocursorline",
})
-- }}}

-- restore cursor {{{
-- if a buffer is special, (i.e. `help`, `gitcommit`)
-- this feels like something i would use in other places but i don't
function SpecialBuffer()
  local special_filetypes = { "gitcommit" }

  -- if not empty then the buffer is a `special-buffer` like help
  if vim.bo.buftype ~= "" then
    return true

    -- if the buffer is not listed then its a special buffer
    -- if a plugin doesn't use buftype well i doubt it will use buflisted
  elseif vim.bo.buflisted == false then
    return true

    -- the given file types are special
  elseif vim.list_contains(special_filetypes, vim.bo.filetype) then
    return true
  end

  -- else its a normal file
  return false
end

create_autocmd("BufWinEnter", {
  group = create_augroup("RestoreCursor", {}),
  callback = function()
    local row_col = vim.api.nvim_buf_get_mark(0, '"')

    -- nvim errors on setting row grater then the last line
    -- but its fine to set column to whatever I guess
    if row_col[1] > vim.api.nvim_buf_line_count(0) then
      row_col[1] = vim.api.nvim_buf_line_count(0)
    end

    if not SpecialBuffer() and row_col ~= { 0, 0 } then
      vim.api.nvim_win_set_cursor(0, row_col)
    end
  end
})
-- }}}

-- force file type options {{{
-- this is kinda bad but there isn't a better way
-- a bunch of language files distributed with vim set formatoptions.
-- so this will reset it. it would be nice if they didn't.
create_autocmd("FileType", {
  group = create_augroup("ResetFileType", {}),
  command = "set formatoptions<"
})
-- }}}


-- cmdheight 0 {{{
local cmd_hight_change = create_augroup("CmdHightChange", {})

vim.opt.cmdheight = 0
vim.cmd.cnoreabbrev "w silent write"

create_autocmd("CmdlineEnter", {
  group = cmd_hight_change,
  callback = function()
    vim.opt.cmdheight = 1
  end
})
create_autocmd("CmdlineLeave", {
  group = cmd_hight_change,
  callback = function()
    vim.opt.cmdheight = 0
  end
})
-- }}}

-- kitty bg change {{{
local get_kitty_bg = function()
  local kitty_color_cmd = {
    "kitty", "@", "get-colors", "--to=" .. vim.env.KITTY_LISTEN_ON
  }

  local kitty_out = vim.system(kitty_color_cmd, { text = true }):wait().stdout

  if not kitty_out or type(kitty_out) ~= "string" then
    return
  end

  -- get just the hex numbers without the `#` symbol
  return string.match(kitty_out, "background%s-#(%d+)")
end

local get_nvim_bg = function()
  local normal_color = vim.api.nvim_get_hl(0, {
    name = "Normal"
  })

  return string.format("%06x", normal_color.bg)
end

local set_kitty_bg = function(settings)
  vim.system {
    "kitty", "@", "set-colors",
    "--to=" .. vim.env.KITTY_LISTEN_ON,
    "background=#" .. settings.color }
    :wait()

  vim.system {
    "kitty", "@", "set-background-opacity",
    "--to=" .. vim.env.KITTY_LISTEN_ON,
    settings.opacity }
    :wait()
end

local function setup_kitty_bg()
  if vim.env.KITTY_LISTEN_ON == "" or vim.env.KITTY_LISTEN_ON == nil then
    return
  end

  local set_kitty_color = create_augroup("SetKittyColor", {})

  create_autocmd("UIEnter", {
    group = set_kitty_color,
    callback = function()
      vim.g.kitty_bg = get_kitty_bg()
      local new_color = get_nvim_bg()

      set_kitty_bg { color = new_color, opacity = 1 }
    end,
  })

  create_autocmd("UILeave", {
    group = set_kitty_color,
    callback = function()
      set_kitty_bg { color = vim.g.kitty_bg, opacity = 0.9 }
    end
  })
end

setup_kitty_bg()
-- }}}

-- end augroups }}}
