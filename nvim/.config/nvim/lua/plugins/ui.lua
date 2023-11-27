return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  -- enabled = false,
  opts = {
    lsp = {
      progress = {
        enabled = false
      },
      message = {
        enabled = false,
      },
      hover = {
        enabled = false,
      }
    },
    cmdline = {
      format = {
        -- cmdline = { icon = "/" },
        search_down = {
          view = "cmdline",
          icon = "/",
        },
        search_up = {
          view = "cmdline",
          icon = "/",
        },

      }
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    views = {
      cmdline = {
        border = {
          -- style = "rounded",
          style = "none",
          -- padding = { 0, 1 }
        },
        win_options = {
          winhighlight = {
            Normal = "StatusLine"
          }
        }
      }
    }
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end
}
