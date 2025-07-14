local bufferline = require('bufferline')
bufferline.setup {
  options = {
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    diagnostics = "nvim_lsp", -- | "nvim_lsp"
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    themable = true, -- | false, -- allows highlight groups to be overriden i.e. sets highlights as default
    numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'underline', -- | 'underline' | 'none',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '● ',
    close_icon = ' ',
    left_trunc_marker = ' ',
    right_trunc_marker = ' ',
    --- count is an integer representing total count of errors
    --- level is a string "error" | "warning"
    --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
    --- this should return a string
    --- Don't get too fancy as this function will be executed a lot
    diagnostics_indicator = function(___, __, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "  "
            or (e == "warning" and "  " or "  ")
        s = s .. n .. sym
      end
      return s
    end
  },
}
