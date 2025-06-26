return {
  -- 1. BASIC CONFIGURATION AND ESSENTIALS
  { 'tpope/vim-sensible' },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
     -- require('bufferline').setup()
    end
  },
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup()
    end
  },

  -- 2. USER INTERFACE AND THEMES
  -- Color schemes
  { 'ellisonleao/gruvbox.nvim' },
  { 'rose-pine/neovim',             name = 'rose-pine' },
  { 'drewtempelmeyer/palenight.vim' },
  { 'navarasu/onedark.nvim' },
  { 'projekt0n/github-nvim-theme' },
  { 'rebelot/kanagawa.nvim' },
  { 'srcery-colors/srcery-vim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
     -- require('catppuccin').setup()
    end
  },

  -- Status line and dashboard
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      --  require('lualine').setup()
    end
  },
  {
    'nvimdev/dashboard-nvim',
    config = function()
      -- require('dashboard').setup()
    end
  },
  { 'nvim-tree/nvim-web-devicons' },

  -- 3. NAVIGATION AND SEARCH
  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      'mrbjarksen/neo-tree-diagnostics.nvim'
    },
    config = function()
      -- require('neo-tree').setup()
    end
  },
  { 'ryanoasis/vim-devicons' },

  -- Search tools
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      -- require('telescope').setup()
    end
  },
  {
    'junegunn/fzf',
    build = function()
      -- Versión compatible con Lua del comando fzf#install()
      vim.cmd('call fzf#install()')
    end,
    dependencies = {
      'junegunn/fzf.vim'
    }
  },
  {
    'junegunn/fzf.vim',
    dependencies = {
      'junegunn/fzf'
    }
  },

  -- Window management
  {
    'aserowy/tmux.nvim',
    config = function()
      -- require('tmux').setup()
    end
  },

  -- 4. LANGUAGE AND DEVELOPMENT
  -- LSP and completion
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'yarn install --frozen-lockfile'
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path'
    }
  },

  -- Snippets
  { 'SirVer/Ultisnips' },
  { 'natebosch/dartlang-snippets' },

  -- Debugging
  { 'mfussenegger/nvim-dap' },

  -- 5. VERSION CONTROL (GIT)
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      -- require('gitsigns').setup()
    end
  },
  { 'sindrets/diffview.nvim' },
  { 'mhinz/vim-signify' },

  -- 6. TEXT AND CODE EDITING
  -- Pairs and surrounds
  {
    'altermo/ultimate-autopair.nvim',
    branch = 'v0.6',
    config = function()
      -- require('ultimate-autopair').setup()
    end
  },

  -- Indentation and syntax
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- require('indent_blankline').setup()
    end
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- require('nvim-treesitter.configs').setup({})
    end
  },
  { 'mtdl9/vim-log-highlighting' },

  -- Text manipulation
  {
    'hinell/move.nvim',
  dependencies = {
    'mrjones2014/legendary.nvim'  -- Add this dependency
  },
    config = function()
      require('move').setup({
        use_default_keymaps = true,  -- Don't rely on legendary
      })
    end
  },
  { 'mg979/vim-visual-multi' },

  -- Cursor and editing UI
  {
    'echasnovski/mini.cursorword',
    branch = 'stable',
    config = function()
      -- require('mini.cursorword').setup()
    end
  },
  { 'sphamba/smear-cursor.nvim' },

  -- 7. TERMINAL
  {
    'akinsho/toggleterm.nvim',
    tag = '2.*',
    config = function()
      -- require('toggleterm').setup()
    end
  },

  -- 8. TESTING
  { 'vim-test/vim-test' },

  -- 9. UTILITIES AND PRODUCTIVITY
  -- Sessions and project management
  {
    'rmagatti/auto-session',
    config = function()
      -- require('auto-session').setup()
    end
  },

  -- Notifications and UI
  {
    'rcarriga/nvim-notify',
    config = function()
      -- require('notify').setup()
    end
  },
  {
    'folke/noice.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      -- require('noice').setup()
    end
  },

  -- Formatting and linting
  { 'nvimtools/none-ls.nvim' },
  { 'MunifTanjim/nui.nvim' },
  {
    'ckipp01/stylua-nvim',
    build = 'cargo install stylua'
  },

  -- 10. LANGUAGE SPECIFIC
  -- Dart/Flutter
  {
    'akinsho/pubspec-assist.nvim',
    config = function()
      -- require('pubspec-assist').setup()
    end
  },

  -- Markdown
  { 'MeanderingProgrammer/markdown.nvim' },
  {
    'echasnovski/mini.nvim',
    name = 'render-markdown',
    config = function()
      -- require('mini.render-markdown').setup()
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npx --yes yarn install'
  }
}
