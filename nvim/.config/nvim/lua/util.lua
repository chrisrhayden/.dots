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

---delete a buffer fully
---@param bufnr number|nil
---@param force boolean|nil
---@return boolean
function M.delete_buffer(bufnr, force)
  bufnr = bufnr or 0
  force = force or false

  -- buffer does not exist
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  if not force and vim.bo[bufnr].modified then
    vim.notify("buffer has unsaved changes", vim.log.levels.WARN)
    return false
  end

  vim.api.nvim_buf_delete(bufnr, { force = force })
  return true
end

---@param cmd string
---@return string|nil
function M.justfile(cmd)
  if not vim.fn.filereadable("justfile") then
    vim.notify("no just file to use", vim.log.levels.INFO)
    return nil
  end


  local out
  if cmd and cmd ~= "" then
    out = vim.system { "just", cmd }:wait(1000)
  else
    out = vim.system { "just" }:wait(1000)
  end

  if out == nil then
    return nil
  elseif out.code ~= 0 then
    vim.notify("just error: " .. out.stderr, vim.log.levels.ERROR)
    return nil
  end

  if out.stdout or out.stdout ~= "" then
    return vim.trim(out.stdout)
  else
    return nil
  end
end

return M
