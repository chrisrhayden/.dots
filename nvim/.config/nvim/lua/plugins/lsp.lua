local set_key = require("util").set_key

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil

    if client == nil then
      return
    end

    local bufnr = args.buf

    -- client.server_capabilities.semanticTokensProvider = nil

    -- don't use the lsp formatter
    -- this is nice as not all lsp formatters work well with comments
    vim.bo[bufnr].formatexpr = nil
    vim.bo[bufnr].formatprg = nil

    set_key {
      "gd",
      function()
        vim.lsp.buf.definition()
      end,
      buffer = bufnr,
      desc = "go to definition"
    }

    set_key {
      "gi",
      vim.lsp.buf.implementation,
      buffer = bufnr,
      desc = "show implementations in quick fix"
    }

    set_key {
      "<leader>rn",
      vim.lsp.buf.rename,
      buffer = bufnr,
      desc = "rename with lsp"
    }

    set_key {
      "<leader>ca",
      vim.lsp.buf.code_action,
      buffer = bufnr,
      desc = "code action"
    }

    set_key {
      "<leader>df",
      function() vim.lsp.buf.format() end,
      desc = "do format",
    }

    -- auto format files on save/write
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = vim.api.nvim_create_augroup("AutoFormater", { clear = false }),
        callback = function() vim.lsp.buf.format() end,
      })
    end
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

local function mk_clang_settings()
  return {
    on_attach = function(_, bufnr)
      set_key {
        "<leader><bs>",
        ":ClangdSwitchSourceHeader<cr>",
        buffer = bufnr,
        desc = "switch to source or header files"
      }
    end
  }
end

local servers = {
  rust_analyzer = mk_rust_settings(),
  lua_ls = mk_lua_settings(),
  clangd = mk_clang_settings(),
  -- ts_ls = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        opts = {},
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
      -- local default_capabilities = require("cmp_nvim_lsp").default_capabilities
      local default_capabilities = require("blink.cmp").get_lsp_capabilities

      for server_name, server_setup in pairs(servers) do
        local setup = default_capabilities(server_setup)
        vim.lsp.config(server_name, setup)
        vim.lsp.enable(server_name)
      end
    end
  },
}
