require("mini.cursorword").setup()

require('smear_cursor').setup({
  cursor_color = '#ff8800',
  transparent_bg_fallback_color = "#303030",
  enabled = true,
  -- Smear cursor when switching buffers or windows.
  smear_between_buffers = true,
  -- Smear cursor when moving within line or to neighbor lines.
  -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
  smear_between_neighbor_lines = true,
  -- Draw the smear in buffer space instead of screen space when scrolling
  scroll_buffer_space = true,
  -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  -- Smears will blend better on all backgrounds.
  legacy_computing_symbols_support = true,
  -- Smear cursor in insert mode.
  -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
  smear_insert_mode = true,
  stiffness = 0.8,                      -- 0.6      [0, 1]
  trailing_stiffness = 0.5,             -- 0.4      [0, 1]
  stiffness_insert_mode = 0.6,          -- 0.4      [0, 1]
  trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
  distance_stop_animating = 0.5,        -- 0.1      > 0
})
