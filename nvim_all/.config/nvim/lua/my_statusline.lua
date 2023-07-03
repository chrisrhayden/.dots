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

function MyStatusLine()
  return table.concat({
    "", -- add padding
    -- "%n", -- buffer number
    -- "%{winnr()}", -- window number
    "%t",      -- file name, only the tail
    "%m",      -- buffer state
    "%=",      -- separation
    "%r",      -- if the buffer is read only
    "%{v:lua.LspStatus()}",
    "%=",      -- separation
    "%y",      -- file type
    "[%l/%L]", -- show current line out of all lines
    "",        -- add padding
  }, " ")
end

vim.opt.statusline = MyStatusLine()

local status_line_timer = vim.uv.new_timer()

status_line_timer:start(100, 1000, vim.schedule_wrap(function()
  vim.cmd [[redrawstatus]]
end))
