-- all these are pretty useless but whatever
local M = {}

function M.setup_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    print "downloading lazy"

    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)

  require "lazy".setup("plugins", {
    defaults = {
      version = false,
    },
    change_detection = {
      enable = true,
      notify = false,
    },
    install = {
      colorscheme = { "sourcery" }
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
          "logiPat",
        }
      }
    }
  })
end

-- this is kinda stupid
function M.set_key(keymap)
  assert(keymap[1] and keymap[2], "needs lhs and rhs")

  local key_opts = {
    desc = true,
    noremap = true,
    silent = true,
    expr = true,
    unique = true,
    buffer = true,
  }

  local lhs = keymap[1]
  local rhs = keymap[2]

  local mode = keymap["mode"] or "n"

  local opts = { noremap = true, silent = true }

  for k, v in pairs(keymap) do
    if key_opts[k] then
      opts[k] = v
    end
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- -- get lsp info and lsp server name to show in the last status
-- function LspStatus()
--   -- TODO: maybe handle multiple servers
--   local lsp_client = vim.lsp.get_active_clients { bufnr = 0 }[1]
--
--   local ret = ""
--
--   if lsp_client then
--     local status = vim.lsp.status()
--
--     if status and status ~= "" then
--       ret = status
--     else
--       ret = "[" .. lsp_client["name"] .. " | " .. lsp_client["id"] .. "]"
--     end
--   end
--
--   return ret
-- end
--
-- local function my_status_line()
--   return table.concat({
--     "", -- add padding
--     -- "%n", -- buffer number
--     -- "%{winnr()}", -- window number
--     "[%t]",    -- file name, only the tail
--     "%m",      -- buffer state
--     "%r",      -- if the buffer is read only
--     "%=",      -- separation
--     "%{v:lua.LspStatus()}",
--     "%=",      -- separation
--     "%y",      -- file type
--     "[%l/%L]", -- show current line out of all lines
--     "",        -- add padding
--   }, " ")
-- end
--
-- function M.make_status_line()
--   vim.opt.statusline = my_status_line()
--
--   local redraw_status = vim.api.nvim_create_augroup("RedrawStatus", {})
--
--   vim.api.nvim_create_autocmd("LspProgress ", {
--     group = redraw_status,
--     command = "redrawstatus"
--   })
-- end

return M
