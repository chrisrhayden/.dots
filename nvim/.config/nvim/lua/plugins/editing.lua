local function expand_or_jump()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  -- if completion menu is visible
  if cmp.visible() then
    cmp.confirm()
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  end
end

local function next_or_complete()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
  end
end


local function prev_or_complete()
  local cmp = require("cmp")

  if cmp.visible() then
    cmp.select_prev_item()
  else
    cmp.complete()
  end
end

local cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate")
          .lazy_load { paths = { "~/.config/nvim/snippets" } }
      end,
    }
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")

    local doc_window = cmp.config.window.bordered()

    doc_window.winhighlight =
    "Normal:NormalFLoat,FloatBorder:NormalFLoat,CursorLine:Visual,Search:None"

    cmp.setup {
      sources = cmp.config.sources {
        { name = "buffer", },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "orgmode" },
        { name = "nvim_lsp", },
      },
      formatting = {
        expandable_indicator = true,
        fields = { "abbr", "kind", "menu" },
        format = function(_, vim_item)
          vim_item.menu = nil

          vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
          return vim_item
        end
      },
      window = {
        documentation = doc_window,
        completion = {
          border = "rounded"
        },
      },
      mapping = {
        ["<C-p>"] = cmp.mapping(prev_or_complete),
        ["<C-n>"] = cmp.mapping(next_or_complete),
        ["<C-y>"] = cmp.mapping(expand_or_jump, { "i", "c" }),
      },
      completion = {
        completeopt = "menuone,noselect",
      },
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      }
    }
  end,
}

local blink_cmp = {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
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

return { auto_pairs, blink_cmp }
