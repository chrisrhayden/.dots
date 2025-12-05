local auto_pairs = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup()

    npairs.add_rule(
      Rule("<", ">", "rust"):with_pair(cond.before_regex("%a"))
    )
  end,
}

-- switch between header and not header files
local ouroboros = {
  "jakemason/ouroboros",
  requires = { { "nvim-lua/plenary.nvim" } },
  config = function()
    require("util").set_key {
      "<leader><bs>", ":Ouroboros<cr>"
    }
  end
}

local blink_cmp = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  version = "1.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    sources = {
      providers = {
        -- make blink add buffer comp even when lsp is active
        -- defaults to `{ 'buffer' }`
        lsp = { fallbacks = {} },
        snippets = {
          score_offset = -1,
        }
      }
    },
    completion = {
      menu = {
        auto_show = true,
        draw = {
          align_to = "cursor",
          columns = { { "label" }, { "kind" } },
          components = {
            label = {
              width = { fill = false },
              text = function(ctx) return ctx.label end
            }
          }
        }
      },
      list = {
        selection = {
          preselect = false,
        }
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      documentation = {
        auto_show = true
      },
    },
    cmdline = {
      enabled = false,
    }
  }
}

return { auto_pairs, ouroboros, blink_cmp }
