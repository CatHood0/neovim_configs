local highlight = {
  "RainbowGreen",
  "RainbowBlue",
  "RainbowYellow",
  "RainbowRed",
  "RainbowOrange",
  "RainbowViolet",
  "RainbowCyan",
}

local backgroundHighlight = {
  "CursorColumn",
  "Whitespace",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require('rainbow-delimiters.setup').setup {
  strategy = {
    [''] = 'rainbow-delimiters.strategy.global',
    vim = 'rainbow-delimiters.strategy.local',
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
    flutter = 'rainbow-delimiters',
    dart = 'rainbow-delimiters',
    cpp = 'rainbow-delimiters',
    hpp = 'rainbow-delimiters',
    h = 'rainbow-delimiters',
    rs = 'rainbow-delimiters',
    js = 'rainbow-delimiters-react',
    ts = 'rainbow-parens',
    go = 'rainbow-delimiters',
    tsx = 'rainbow-tags-react',
    java = 'rainbow-delimiters',
  },
  priority = {
    [''] = 110,
    lua = 210,
    flutter = 310,
    cpp = 330,
    hpp = 350,
    h = 370,
    rs = 390,
    js = 420,
    ts = 440,
    go = 460,
    tsx = 480,
    java = 500,
  },
  highlight = highlight,
}

require("ibl").setup {
  -- avoid adding indent option, since adding this
  -- removes the dynamic colors of every indent line scope
  whitespace = {
    highlight = backgroundHighlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = true, highlight = highlight },
}
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
-- Removes first indent line
--[[hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)]]
