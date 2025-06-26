local winbar_opts = require('core.winbar.config')
local M = {
  state = {
    current_path = "",
    buffers = {},
    update_pending = false,
    hl_groups_defined = false
  },
  config = vim.deepcopy(winbar_opts)
}
return M
