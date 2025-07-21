require('persistent-breakpoints').setup {
  save_dir = vim.fn.stdpath("cache") .. '/dap',
  -- when to load the breakpoints? "BufReadPost" is recommanded.
  load_breakpoints_event = { "BufReadPost" },
  -- record the performance of different function. 
  -- run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
  perf_record = false,
  -- perform callback when loading a 
  -- persisted breakpoint
  on_load_breakpoint = nil,
  -- set this to true if the breakpoints are not loaded 
  -- when you are using a session-like plugin.
  always_reload = false,
}
