-- all these are pretty useless to have here but whatever
local M = {}

function M.setup_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    print("downloading lazy")

    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup("plugins",
    {
      change_detection = {
        enable = true,
        notify = false,
      },
      install = { colorscheme = { "sourcery" } },
      ui = {
        border = "rounded"
      },
      performance = {
        rtp = {
          disabled_plugins = {
            "matchit",
            "netrwPlugin",
            "tohtml",
            "tutor",
            -- "matchparen",
            -- "tarPlugin",
            -- "zipPlugin",
            -- "gzip",
          }
        }
      }
    })
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

return M
