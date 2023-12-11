local set_key = require("util").set_key

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false, border = "rounded" }
)

local function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  -- don't use the lsp formatter
  -- this is nice as not all lsp formatters work well with comments
  vim.bo[bufnr].formatexpr = nil

  set_key {
    "gd",
    vim.lsp.buf.definition,
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

  -- auto format files on save/write
  vim.api.nvim_create_autocmd("BufWritePre", {
    -- pattern = "*",
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("AutoFormater", {}),
    -- idk why i have to wrap this function
    callback = function() vim.lsp.buf.format() end,
  })
end

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
    on_attach = function(client, bufnr)
      set_key {
        "<leader><bs>",
        ":ClangdSwitchSourceHeader<cr>",
        buffer = bufnr,
        desc = "switch to source or header files"
      }

      on_attach(client, bufnr)
    end
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        config = true,
      }
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      servers = {
        rust_analyzer = mk_rust_settings(),
        lua_ls = mk_lua_settings(),
        clangd = mk_clang_settings(),
        tsserver = {},
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")

      for server_name, server_opts in pairs(opts.servers) do
        local server_setup =
          vim.tbl_deep_extend("force", {
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          }, server_opts)

        local cmd_name = lsp[server_name].document_config.default_config.cmd[1]

        if vim.fn.executable(cmd_name) ~= 0 then
          lsp[server_name].setup(server_setup)
        end
      end
    end
  },
}
