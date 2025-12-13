local set_keys = require("util").set_keys
local justfile = require("util").justfile


-- return vim.fn.input("path to exe ", vim.fn.getcwd() .. "/", "file")
---@return string
local function exe_path()
  local out = justfile("prog_path")

  if out ~= nil then
    return out
  else
    return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/", "file")
  end
end

local function exe_filter()
  local out = justfile("prog_name")

  if out ~= nil then
    return require("dap.utils").pick_process { filter = out }
  else
    local name = vim.fn.input("Executable name (filter): ")
    return require("dap.utils").pick_process { filter = name }
  end
end


local dap = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local v_text = require("nvim-dap-virtual-text")

    ui.setup()
    v_text.setup {}


    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }
    dap.configurations = {
      c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = exe_path,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "select and attach to process",
          type = "gdb",
          request = "attach",
          program = exe_path,
          pid = exe_filter,
          cwd = "${workspaceFolder}",
        },
      },
    }

    set_keys {
      {
        "<leader>db",
        dap.toggle_breakpoint,
        desc = "toggle break point",
      },
      {
        "<leader>dr",
        dap.run_to_cursor,
        desc = "run to cursor"
      },
      {
        "<F1>",
        dap.continue,
        desc = "continue",
      },
      {
        "<F2>",
        dap.step_into,
        dest = "step into",
      },
      {
        "<F3>",
        dap.step_over,
        dest = "stop over",
      },
      {
        "<F4>",
        dap.step_out,
        dest = "step out",
      },
      {
        "<F5>",
        dap.step_back,
        dest = "step back"
      },
      {
        "<F9>",
        dap.continue,
        desc = "continue"
      },
      {
        "<F12>",
        dap.restart,
        desc = "restart"
      },
      {
        "<leader>de",
        function()
          ui.eval()
        end,
        desc = "eval under cursor"
      },
      {
        "<leader>du",
        ui.open,
        desc = "open dap ui",
      },
      {
        "<leader>dc",
        ui.close,
        desc = "clode dap ui"
      }
    }
  end
}

return { dap }
