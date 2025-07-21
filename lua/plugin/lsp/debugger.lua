local dap, dapui = require("dap"), require("dapui")

local M = {}

function M.setupListeners()
  dap.listeners.before.attach.dapui_config = dapui.open
  dap.listeners.before.launch.dapui_config = dapui.open
  dap.listeners.before.event_terminated.dapui_config = dapui.close
  dap.listeners.before.event_exited.dapui_config = dapui.close
end

function M.setupConfigs()
  ---       CONFIGURATIONS      ---
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch dart",
      dartSdkPath = "~/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart",
      flutterSdkPath = "~/development/flutter/bin/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = "~/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart",
      flutterSdkPath = "~/development/flutter/bin/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Debug Tests (Smart)",
      dartSdkPath = "~/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart",
      flutterSdkPath = "~/development/flutter/bin/flutter",
      cwd = "${workspaceFolder}/test/",
      flutterMode = "debug",
      args = { "--plain-name" },
      toolArgs = { "--no-select-device" },
      program = function()
        local file_path = vim.fn.expand('%:p')
        if string.find(file_path, "_test%.dart$") then
          return file_path
        else
          -- if the current file is not a test, execute all the test into the workspace
          return "${workspaceFolder}"
        end
      end,
    },
  }
  -- configs
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  ---       ADAPTERS      ---
  -- Dart CLI adapter (recommended)
  dap.adapters.dart = {
    type = 'executable',
    command = 'dart',
    args = { 'debug_adapter' },
    -- windows users will need to set 'detached' to false
    options = {
      detached = true,
    }
  }
  dap.adapters.flutter = {
    type = 'executable',
    command = 'flutter',
    args = { 'debug_adapter' },
    -- windows users will need to set 'detached' to false
    options = {
      detached = true,
    }
  }
  -- c++/c/rust
  dap.adapters.codelldb = {
    type = "executable",
    command = "~/development/codelldb/extension/adapter/codelldb",
    -- On windows you may have to uncomment this:
    -- detached = false,
  }
end

function M.setup()
  vim.api.nvim_call_function(
    "sign_define",
    { "DapBreakpoint", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
  )

  vim.api.nvim_call_function(
    "sign_define",
    { "DapBreakpointCondition", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
  )

  vim.api.nvim_call_function(
    "sign_define",
    { "DapLogPoint", { linehl = "", text = "", texthl = "diffRemoved", numhl = "" } }
  )

  vim.api.nvim_call_function(
    "sign_define",
    { "DapStopped", { linehl = "GitSignsChangeVirtLn", text = "", texthl = "diffChanged", numhl = "" } }
  )

  vim.api.nvim_call_function(
    "sign_define",
    { "DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" } }
  )
  -- Setup virtual text to show variable values inline
  require("nvim-dap-virtual-text").setup()
  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }
  M.setupListeners()
  M.setupConfigs()
end

return {
  setup = M.setup
}
