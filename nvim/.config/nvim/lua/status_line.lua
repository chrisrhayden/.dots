-- get lsp info and lsp server name to show in the last status
function LspStatus()
  -- TODO: maybe handle multiple servers
  local lsp_client = vim.lsp.get_clients { bufnr = 0 }[1]

  if lsp_client then
    local status = vim.lsp.status()

    if status and status ~= "" then
      return status
    else
      return "[" .. lsp_client["name"] .. "]"
    end
  end
end

local function my_status_line()
  return table.concat({
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
end

vim.opt.statusline = my_status_line()

if vim.fn.exists("#LspProgress#") then
  vim.api.nvim_create_autocmd("LspProgress", {
    group = vim.api.nvim_create_augroup("RedrawStatus", {}),
    command = "redrawstatus"
  })
end
