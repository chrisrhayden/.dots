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
    change_detection = {
      enable = true,
      notify = false,
    },
    install = {
      colorscheme = { "sourcery" }
    },
    ui = {
      border = "rounded"
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

return M
