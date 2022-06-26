--------------------------------------------------------------------------------
-- lsp config
--------------------------------------------------------------------------------

CLIENT_NAMES = {}

local nvim_lsp = require("lspconfig")

-- get lsp info and lsp server name to show in the last status
function LspStatus()
  if #vim.lsp.buf_get_clients() > 0 then
    local progress = vim.lsp.util.get_progress_messages()[1]

    if progress and (progress["done"] == nil or progress["done"] == false) then
      local message = progress["message"] or ""
      local percent = progress["percentage"] or 0
      local name = progress["name"] or ""
      local title = progress["title"] or ""

      return string.format("[%s] %s %s %%%s", name, title, message, tostring(percent))
    else

      return "[" .. table.concat(CLIENT_NAMES, ", ") .. "] "
    end
  end

  return ""
end

-- only show diagnostics if there isn't a popup window
function ShowLineDiagnostics()
  local wins = vim.api.nvim_list_wins()

  for _, win in pairs(wins) do
    local win_type = vim.fn.win_gettype(win)

    if win_type == "popup" then
      return
    end
  end

  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
    border = "rounded",
  })
end

local function on_attach(client, bufnr)
  local function bmap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function bopt(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  bopt("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  local goto_opts = '{ float = { focusable = false, border = "rounded" } }'

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  bmap(
    "n",
    "<leader>n",
    "<cmd>lua vim.diagnostic.goto_next(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap(
    "n",
    "<leader>N",
    "<cmd>lua vim.diagnostic.goto_prev(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  bmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>", opts)
  bmap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  bmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  bmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

  bmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>", opts)

  bmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  bmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

  bmap("n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<cr>", opts)

  if vim.tbl_contains(CLIENT_NAMES, client.name) == false then
    table.insert(CLIENT_NAMES, client.name)
  end

  -- auto format files on save/write
  -- this wont throw an error for file types that dont have an lsp active i guess
  local auto_format_group = vim.api.nvim_create_augroup("AutoFormater", {})

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function() vim.lsp.buf.format() end,
    group = auto_format_group,
  })

  local hold_group = vim.api.nvim_create_augroup("HoldForDiagnostics", {})

  vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = ShowLineDiagnostics,
    group = hold_group,
  })
end

local function basic_settings()
  return {
    -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

local function c_settings()
  local server_settings = basic_settings()

  server_settings["on_attach"] = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader><BS>",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { noremap = true, silent = true }
    )
  end

  server_settings["default_config"] = {
    cmd = {
      "clangd",
      "--background-index",
      "--pch-storage=memory",
      "--clang-tidy",
      "--suggest-missing-includes",
    },
  }

  return server_settings
end

local function c_sharp_settings()
  local server_settings = basic_settings()

  server_settings["cmd"] = {
    "/usr/bin/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  }

  return server_settings
end

local function lua_settings()
  local server_settings = basic_settings()

  -- setup up nvim config files
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  server_settings["cmd"] = {
    "/usr/bin/lua-language-server",
    "-E",
    "/usr/lib/lua-language-server/main.lua",
  }

  server_settings["settings"] = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        -- make "vim" global
        globals = { "vim", "use" },
        neededFileStatus = { ["codestyle-check"] = "Any" }
      },
      workspace = {
        -- add neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",

        }
      },
    },
  }

  return server_settings
end

local function rust_settings()
  local server_settings = basic_settings()

  server_settings["settings"] = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
    },
  }

  return server_settings
end

local function java_settings()
  local server_settings = basic_settings()

  server_settings["cmd"] = { "java-language-server" }

  return server_settings
end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
-- NOTE: i guess this is kinda useless
local servers = {
  omnisharp = c_sharp_settings,
  clangd = c_settings,
  pyright = basic_settings,
  rust_analyzer = rust_settings,
  tsserver = basic_settings,
  sumneko_lua = lua_settings,
  zk = basic_settings,
  java_language_server = java_settings,
}

for lsp, settings_func in pairs(servers) do
  nvim_lsp[lsp].setup(settings_func())
end

-- lsp_status.config({
--   indicator_warnings = "",
--   indicator_info = "",
--   indicator_hint = "",
--   indicator_ok = "",
--   status_symbol = "",
-- })

vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  signs = true,
  update_in_insert = false,
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { focusable = false, border = "rounded" }
)

vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
})
