vim.cmd([[
  nnoremap <silent> <space>tt <CMD>:ToggleTerm<CR>
]])

require("toggleterm").setup({
  hide_numbers = false, -- hide the number column in toggleterm buffers
  autochdir = true,
  size = 9,
  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  direction = 'horizontal', --'vertical' | 'horizontal' | 'tab' | 'float',
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
  -- NOTE: this option takes priority over highlights specified so if you
  -- specify Normal highlights you should set this to false
  shade_terminals = true,
  -- the percentage by which to lighten dark terminal background, default: -30
  shading_factor = '-30',
  -- the ratio of shading factor for light/dark terminal background, default: -3
  shading_ratio = '-3',
  start_in_insert = true,
  close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell
  auto_scroll = true,   -- automatically scroll to the bottom on terminal output
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

-- Set a new way to go out of the terminal windows
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
