local notify = require("notify")
local opts = {
  render = "default",           -- | wrapped-compact | simple | default | minimal | compact
  stages = 'slide', -- fade_in_slide_out | fade | slide | static
  max_width = 80,
  animation = {
    enable = true,
    duration = 500,
  },
  colors = {
    ERROR = 'DiagnosticSignError',  -- Rojo oscuro (Gruvbox Dark Red)
    WARNING = 'DiagnosticSignWarn', -- Naranja oscuro (Gruvbox Dark Orange)
    INFO = 'DiagnosticSignInfo',    -- Azul turquesa oscuro (Gruvbox Dark Aqua)
    HINT = 'DiagnosticSignHint',    -- Púrpura oscuro (Gruvbox Dark Purple)
  },
  background_colour = 'FloatShadow',
  timeout = 1500,
  top_down = true,
}
notify.setup(opts)
vim.notify = notify
