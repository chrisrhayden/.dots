local set_keys = require("util").set_keys
-- local set_key = require("util").set_key

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end

    local bufnr = args.buf

    -- don't use the lsp formatter
    -- this is nice as not all lsp formatters work well with comments
    vim.bo[bufnr].formatexpr = nil
    vim.bo[bufnr].formatprg = nil
    -- vim.bo[args.buf].omnifunc = nil


    set_keys {
      {
        "gd",
        function() vim.lsp.buf.definition() end,
        buffer = bufnr,
        desc = "go to definition"
      },
      {
        "gi",
        vim.lsp.buf.implementation,
        buffer = bufnr,
        desc = "show implementations in quick fix"
      },
      {
        "<leader>rn",
        vim.lsp.buf.rename,
        buffer = bufnr,
        desc = "rename with lsp"
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        buffer = bufnr,
        desc = "code action"
      },
      {
        "<leader>df",
        function() vim.lsp.buf.format() end,
        desc = "do format",
      },
    }

    -- auto format files on save/write
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("AutoFormater", { clear = false }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
      })
    end

    -- if client:supports_method("textDocument/completion") then
    --   vim.bo.completeopt = "menuone,popup"
    --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    --
    --   local function feedkeys(keys)
    --     vim.api.nvim_feedkeys(
    --       vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
    --   end
    --
    --   set_key {
    --     "<C-n>",
    --     function()
    --       if tonumber(vim.fn.pumvisible()) ~= 0 then
    --         feedkeys("<C-n>")
    --       else
    --         if next(vim.lsp.get_clients { bufnr = 0 }) then
    --           vim.lsp.completion.get()
    --         else
    --           feedkeys("<C-x><C-o>")
    --         end
    --       end
    --     end,
    --     mode = { "i" }
    --
    --   }
    -- end
    -- vim.lsp.completion(true, client.id, bufnr, { autotrigger = true })

    -- vim.api.nvim_create_autocmd("LspTokenUpdate", {
    --   -- group = vim.api.nvim_create_augroup("CppLowerTokenHI", {}),
    --   callback = function(t_args)
    --     vim.inspect(">>>>>>>>")
    --     vim.inspect(t_args)
    --
    --     local token = t_args.data.token
    --     if token.type == "macro" and not token.modifiers.readonly then
    --       vim.lsp.semantic_tokens.highlight_token(
    --         token, t_args.buf, t_args.data.client_id,
    --         "@lsp.macro.cpp",
    --         { priority = 90 }
    --       )
    --     end
    --   end
    -- })
  end
})

local function mk_rust_settings()
  local rust_analyzer_cmd = vim.fn.system { "rustup", "which", "rust-analyzer" }

  if rust_analyzer_cmd == "" or rust_analyzer_cmd == nil then
    error("rustup did not find rust-analyzer")
  end

  rust_analyzer_cmd = rust_analyzer_cmd:gsub("[\r\n]", "")

  if rust_analyzer_cmd == "" or rust_analyzer_cmd == nil then
    error("could not find rust-analyzer from rust up output")
  end

  return {
    cmd = { rust_analyzer_cmd },
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy"
        }
      }
    }
  }
end

local function mk_lua_settings()
  return {
    settings = {
      Lua = {
        diagnostics = {
          neededFileStatus = {
            ["codestyle-check"] = "Any"
          }
        },
        telemetry = {
          enable = false
        }
      }
    }
  }
end

local servers = {
  rust_analyzer = mk_rust_settings(),
  lua_ls = mk_lua_settings(),
  clangd = {},
  qmlls = {
    cmd = { "qmlls6" }
  },
  pyright = {},
}

local lsp = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            "nvim-dap-ui"
          }
        },
      },
      {
        "pmizio/typescript-tools.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        },
        opts = {
          settings = {
            jsx_close_tag = {
              enable = true,
              filetypes = { "javascriptreact", "typescriptreact" },
            }
          }
        }
      },
    },
    config = function()
      local default_capabilities = require("blink.cmp").get_lsp_capabilities

      for server_name, server_setup in pairs(servers) do
        local setup = default_capabilities(server_setup)
        -- vim.lsp.config(server_name, server_setup)
        vim.lsp.config(server_name, setup)
        vim.lsp.enable(server_name)
      end
    end
  },
}

local none = {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.black
      }
    }
  end
}

return { lsp, none }
