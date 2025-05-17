local auto_pairs = {
  -- auto pair plugin
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

local blink_cmp = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  version = "1.*",
  opts = {
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
      }
    },
  }
}

return { auto_pairs, blink_cmp }
