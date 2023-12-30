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

    -- vim errors on row 0
    if not SpecialBuffer() and row_col ~= { 0, 0 } then
      vim.api.nvim_win_set_cursor(0, row_col)
    end
  end
})
-- }}}

-- kitty bg change {{{

---get background and opacity from currently running kitty terminal
---
---@return string[]
local get_kitty_data = function()
  local kitty_py = [[
from kitty.cli import create_default_opts

opts = create_default_opts()
bg = opts.background.as_sharp
opacity = opts.background_opacity

print(bg + '\n' + str(opacity), end="")
]]

  local data = vim.system { "kitty", "+runpy", kitty_py }:wait()

  assert(data.code < 1, data.stderr)

  local out = vim.split(data.stdout, "\n")

  assert(out[1], out[2])

  return out
end

local get_nvim_bg = function()
  local normal_color = vim.api.nvim_get_hl(0, { name = "Normal" })

  return "#" .. string.format("%06x", normal_color.bg)
end

local set_kitty_bg = function(settings)
  vim.system {
    "kitty", "@", "set-colors",
    "--to=" .. vim.env.KITTY_LISTEN_ON,
    "background=" .. settings.color
  }

  vim.system {
    "kitty", "@", "set-background-opacity",
    "--to=" .. vim.env.KITTY_LISTEN_ON,
    settings.opacity
  }
end

if vim.env.KITTY_LISTEN_ON then
  local set_kitty_color = create_augroup("SetKittyColor", {})

  create_autocmd("UIEnter", {
    group = set_kitty_color,
    callback = function()
      local data = get_kitty_data()
      vim.g.kitty_bg = data[1]
      vim.g.kitty_opacity = data[2]

      local new_color = get_nvim_bg()
      set_kitty_bg { color = new_color, opacity = 1 }
    end,
  })

  create_autocmd("UILeave", {
    group = set_kitty_color,
    callback = function()
      set_kitty_bg { color = vim.g.kitty_bg, opacity = vim.g.kitty_opacity }
    end
  })
end
-- }}}

create_autocmd("TextYankPost", {
  group = create_augroup("HighlightYanked", {}),
  callback = function() require("vim.highlight").on_yank() end
})

-- end augroups }}}
