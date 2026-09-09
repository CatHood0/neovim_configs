local java =  require('java')
local dap, dapui = require("dap"), require("dap-view")
local dapViewConfigs = require("plugin.lsp.configs.dap-view")

local M = {}

local function get_dart_sdk_path()
  -- Intentar encontrar Dart en el PATH primero
  local handle = io.popen("which dart")
  local result = handle:read("*a")
  handle:close()
  if result and result ~= "" then
    return result:gsub("\n", "")
  end

  -- Fallback para Snap
  return "/snap/flutter/current/bin/cache/dart-sdk/bin/dart"
end

local function get_flutter_sdk_path()
  -- Intentar encontrar Flutter en el PATH primero
  local handle = io.popen("which flutter")
  local result = handle:read("*a")
  handle:close()
  if result and result ~= "" then
    return result:gsub("\n", "")
  end

  -- Fallback para Snap
  return "/snap/flutter/current/bin/flutter"
end

function M.setupListeners()
  dap.listeners.before.attach.dapui_config = dapui.open
  dap.listeners.before.launch.dapui_config = dapui.open
  dap.listeners.before.event_terminated.dapui_config = dapui.close
  dap.listeners.before.event_exited.dapui_config = dapui.close
end

function M.setupBreakpointsDesign()
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
end

function M.setupConfigs()
  local dart_sdk = get_dart_sdk_path()
  local flutter_sdk = get_flutter_sdk_path()
  print(dart_sdk)
  print(flutter_sdk)

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch dart",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "dart",
      request = "launch",
      name = "Launch dart (custom)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter (custom)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      flutterMode = "debug",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter app (debug)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      flutterMode = "debug",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter app (release)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      flutterMode = "release",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter linux (package -> debug)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      flutterMode = "debug",
      args = { "-d", "linux" },
      program = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/example/lib/main.dart") == 1 then
          return cwd .. "/example/lib/main.dart"
        end
        return cwd .. "/lib/main.dart"
      end,
      cwd = "${workspaceFolder}/example",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter linux (package -> profile)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      flutterMode = "profile",
      args = { "-d", "linux" },
      program = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/example/lib/main.dart") == 1 then
          return cwd .. "/example/lib/main.dart"
        end
        return cwd .. "/lib/main.dart"
      end,
      cwd = "${workspaceFolder}/example",
    },
    {
      type = "flutter",
      request = "launch",
      name = "Debug Tests (Smart)",
      dartSdkPath = dart_sdk,
      flutterSdkPath = flutter_sdk,
      cwd = "${workspaceFolder}",
      flutterMode = "debug",
      args = { "--plain-name" },
      toolArgs = { "--no-select-device" },
      program = function()
        local file_path = vim.fn.expand("%:p")
        if string.find(file_path, "_test%.dart$") then
          return file_path
        else
          -- Si no es test, ejecutar todos los tests
          return "${workspaceFolder}"
        end
      end,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  ---       ADAPTERS      ---
  -- Dart CLI adapter (recommended)
  dap.adapters.dart = {
    type = "executable",
    command = "dart",
    args = { "debug_adapter" },
    -- windows users will need to set 'detached' to false
    options = {
      detached = true,
    },
  }
  dap.adapters.flutter = {
    type = "executable",
    command = "flutter",
    args = { "debug_adapter" },
    -- windows users will need to set 'detached' to false
    options = {
      detached = true,
    },
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
  -- Setup virtual text to show variable values inline
  -- require("nvim-dap-virtual-text").setup()
  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  M.setupBreakpointsDesign()
  dapui.setup(dapViewConfigs)
  M.setupListeners()
  M.setupConfigs()
end

return {
  setup = M.setup,
}
