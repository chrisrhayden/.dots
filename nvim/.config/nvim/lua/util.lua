-- all these are pretty useless to have here but whatever
local M = {}

function M.add_blank_lines(offset)
  local lines = {}

  for _ = 1, vim.v.count1 do
    table.insert(lines, "")
  end

  vim.api.nvim_buf_set_lines(
    0,
    vim.fn.line(".") + offset,
    vim.fn.line(".") + offset,
    false,
    lines
  )
end

local key_opts = {
  desc = true,
  noremap = true,
  silent = true,
  expr = true,
  unique = true,
  buffer = true,
}

-- this is kinda stupid
function M.set_key(keymap)
  assert(keymap[1] and keymap[2], "needs lhs and rhs")

  local lhs = keymap[1]
  local rhs = keymap[2]

  -- honestly defaulting to normal mode and silent
  -- is the only justifications for this function
  local mode = keymap["mode"] or "n"

  local opts = { silent = true }

  -- filter options and override defaults
  for k, v in pairs(keymap) do
    if key_opts[k] then
      opts[k] = v
    end
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.set_keys(keys)
  for _, v in pairs(keys) do
    M.set_key(v)
  end
end

return M
