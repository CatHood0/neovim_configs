
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
   'sql',
   'toml',
    'go',
   'gomod',
   'gosum',
   'json',
   'markdown',
   'markdown_inline',
   'tsx',
   'java',
   'fish',
   'php',
   'dockerfile',
   'gitignore',
   'python',
   'csv',
   'yaml',
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
-- require('render-markdown').setup({
--   file_types = { 'markdown', 'vimwiki' },
-- })

vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })

-- require("nvim-treesitter").install {
--   'lua',
--   'vim',
--   'dart',
--   'vimdoc',
--   'regex',
--   'javascript',
--   'typescript',
--   'css',
--   'html',
--   'rust',
--   'kotlin',
--   'c',
--   'cpp',
--   'xml',
--   'sql',
--   'toml',
--   'go',
--   'gomod',
--   'gosum',
--   'json',
--   'markdown',
--   'markdown_inline',
--   'tsx',
--   'java',
--   'fish',
--   'php',
--   'dockerfile',
--   'gitignore',
--   'python',
--   'csv',
--   'yaml',
-- }
--
-- vim.treesitter.language.register('markdown', 'vimwiki')
-- -- require('render-markdown').setup({
-- --   file_types = { 'markdown', 'vimwiki' },
-- -- })
--
-- vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
