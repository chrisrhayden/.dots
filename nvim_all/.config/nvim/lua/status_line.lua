-- get lsp info and lsp server name to show in the last status
function LspStatus()
  -- TODO: maybe handle multiple servers
  local lsp_client = vim.lsp.get_active_clients { bufnr = 0 }[1]

  local ret = ""

  if lsp_client then
    local status = vim.lsp.status()

    if status and status ~= "" then
      ret = status
    else
      ret = "[" .. lsp_client["name"] .. " | " .. lsp_client["id"] .. "]"
    end
  end

  return ret
end

local function my_status_line()
  return table.concat({
    "", -- add padding
    -- "%n", -- buffer number
    -- "%{winnr()}", -- window number
    "[%t]",    -- file name, only the tail
    "%m",      -- buffer state
    "%r",      -- if the buffer is read only
    "%=",      -- separation
    "%{v:lua.LspStatus()}",
    "%=",      -- separation
    "%y",      -- file type
    "[%l/%L]", -- show current line out of all lines
    "",        -- add padding
  }, " ")
end

vim.opt.statusline = my_status_line()

local redraw_status = vim.api.nvim_create_augroup("RedrawStatus", {})

vim.api.nvim_create_autocmd("LspProgress ", {
  group = redraw_status,
  command = "redrawstatus"
})
