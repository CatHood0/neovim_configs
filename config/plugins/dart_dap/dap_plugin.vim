lua << EOF
local dap = require('dap')
-- dart
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = "/home/cathood0/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart", 
    flutterSdkPath = "/home/cathood0/development/flutter/bin/flutter",             
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/home/cathood0/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart", 
    flutterSdkPath = "/home/cathood0/development/flutter/bin/flutter", 
    program = "${workspaceFolder}/lib/main.dart", 
    cwd = "${workspaceFolder}",
  }
}
-- c++/c/rust
dap.adapters.codelldb = {
  type = "executable",
  command = "/home/cathood0/Descargas/debugger_adapters/codelldb/extension/adapter/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
  -- On windows you may have to uncomment this:
  -- detached = false,
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
EOF

