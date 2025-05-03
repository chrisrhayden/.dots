-- get lsp info and lsp server name to show in the last status
function LspStatus()
  local lsp_clients = vim.lsp.get_clients { bufnr = 0 }

  if #lsp_clients > 0 then
    local status = vim.lsp.status()

    if status and status ~= "" then
      return status
    else
      local names = ""

      for _, lsp_c in pairs(lsp_clients) do
        names = names .. lsp_c["name"] .. ", "
      end

      -- remove trailing `,\s`
      names = names:sub(1, string.len(names) - 2)

      return "[" .. names .. "]"
    end
  else
    return ""
  end
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


if vim.fn.exists("#LspProgress#") then
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
end
