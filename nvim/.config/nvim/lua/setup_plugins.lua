local lazypath = vim.fs.joinpath(
  vim.fn.stdpath("data"),
  "lazy",
  "lazy.nvim"
)

if not vim.loop.fs_stat(lazypath) then
  vim.notify("downloading lazy")

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
      enable = false,
      notify = false,
    },
    install = {
      colorscheme = {
        "sourcery"
      }
    },
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
    },
    rocks = {
      enabled = false,
      hererocks = false
    }
  })
