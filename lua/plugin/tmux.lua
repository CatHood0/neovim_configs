---@diagnostic disable-next-line: redundant-parameter
require('tmux').setup({
  navigation = {
    cycle_navigation = true,
    enable_default_keybindings = false,
    persist_zoom = true,
  },
  resize = {
    enable_default_keybindings = false,
    resize_step_x = 4,
    resize_step_y = 4,
  }
})
