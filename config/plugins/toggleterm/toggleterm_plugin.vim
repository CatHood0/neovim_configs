lua << EOF
require("toggleterm").setup({
   hide_numbers = true, -- hide the number column in toggleterm buffers
   autochdir = false,
   size = 9,
   start_in_insert = true,
   insert_mappings = true, -- whether or not the open mapping applies in insert mode
   direction = 'horizontal', --'vertical' | 'horizontal' | 'tab' | 'float',
   terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
   persist_size = true,
   persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
   close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell
   auto_scroll = true, -- automatically scroll to the bottom on terminal output
   float_opts = {
      -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
      --width = <value>,
      --height = <value>,
      --row = <value>,
      --col = <value>,
      --zindex = <value>,
      border = 'curved', --| 'double' | 'shadow' | 'curved' | ... other options supported by win open
      title_pos = 'center', 
   },
})
EOF
