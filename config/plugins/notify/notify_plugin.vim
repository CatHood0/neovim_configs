lua << EOF
require("notify").setup({
	render = "minimal", -- default | minimal | compact 
	stages = 'fade_in_slide_out', -- fade_in_slide_out | fade | slide | static 
  max_width = 80,
  animation = {
    enable = true,
    duration = 300,
  },
  colors = {
        ERROR = '#cc241d',    -- Rojo oscuro (Gruvbox Dark Red)
        WARNING = '#d79921',  -- Naranja oscuro (Gruvbox Dark Orange)
        INFO = '#458588',     -- Azul turquesa oscuro (Gruvbox Dark Aqua)
        HINT = '#b16286',     -- Púrpura oscuro (Gruvbox Dark Purple)
  },
	background_colour = 'FloatShadow', 
	timeout = 1500,
	top_down = false,
})
EOF
