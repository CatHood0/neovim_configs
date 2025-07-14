---@diagnostic disable: missing-fields
require("nvim-treesitter").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    'lua',
    'vim',
    'dart',
    'vimdoc',
    'regex',
    'javascript',
    'typescript',
    'css',
    'html',
    'rust',
    'kotlin',
    'c',
    'cpp',
    'xml',
    'go',
    'gomod',
    'gosum',
    'json',
    'markdown',
    'markdown_inline',
    'tsx',
    'java',
    "toml",
    "fish",
    "php",
    "yaml",
  },
  sync_install = true,
  endwise = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']]'] = '@function.outer',
      [']m'] = '@class.outer',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
      [']['] = '@class.outer',
    },
    goto_previous_start = {
      ['[['] = '@function.outer',
      ['[m'] = '@class.outer',
    },
    goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[]'] = '@class.outer',
    },
  },
})

vim.treesitter.language.register('markdown', 'vimwiki')
require('render-markdown').setup({
  file_types = { 'markdown', 'vimwiki' },
})
