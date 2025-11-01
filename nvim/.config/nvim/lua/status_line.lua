-- get lsp info and lsp server name to show in the last status
function LspStatus()
  local status = vim.lsp.status()

  if status ~= "" then
    return "[" .. status .. "]"
  end

  -- thanks neovim
  local names = vim.iter(vim.lsp.get_clients())
    :map(function(client) return client["name"] end)
    :join(", ")

  -- this is so dumb
  return ((names ~= "") and "[" .. names .. "]" or "")
end

vim.opt.statusline = table.concat({
  "",                     -- add padding
  "[%t]",                 -- file name, only the tail
  "%m",                   -- buffer state
  "%r",                   -- if the buffer is read only
  "%=",                   -- separation
  "%{v:lua.LspStatus()}", -- lsp status if there is one
  "%=",                   -- separation
  "%y",                   -- file type
  "[%l/%L]",              -- show current line out of all lines
  "",                     -- add padding
}, " ")


local lsp_redraw_status = vim.api.nvim_create_augroup("RedrawStatus", {})
vim.api.nvim_create_autocmd("LspProgress", {
  group = lsp_redraw_status,
  pattern = "begin,report",
  command = "redrawstatus"
})

vim.api.nvim_create_autocmd("LspProgress", {
  group = lsp_redraw_status,
  pattern = "end",
  callback = function()
    vim.cmd.redrawstatus()

    -- wait a second then redraw the status since LspProgress will stop
    -- triggering after the end pattern and the last message will hang there
    vim.defer_fn(function()
      vim.cmd.redrawstatus()
    end, 1000)
  end,
})
