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
  -- This fix an issue with the foldColumn
  { 'mbbill/undotree' },
  { 'luukvbaal/statuscol.nvim' },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
  },
  { "SmiteshP/nvim-navic" },
  {
    'catgoose/nvim-colorizer.lua',
    event = "VeryLazy",
  },
  { 'nvim-telescope/telescope-media-files.nvim', dependencies = 'nvim-lua/popup.nvim' },
  -- Color schemes
  { 'ellisonleao/gruvbox.nvim' },
  { 'rose-pine/neovim',                          name = 'rose-pine' },
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
  { "goolord/alpha-nvim" },
  { 'nvim-tree/nvim-web-devicons' },
  { 'echasnovski/mini.nvim',      version = '*' },
  { 'MunifTanjim/nui.nvim' },

  -- 3. NAVIGATION AND SEARCH
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'mrbjarksen/neo-tree-diagnostics.nvim'
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
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
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
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
  -- Snippet engine and snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = {
      'honza/vim-snippets',
    },
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require pr
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          require("hover.providers.lsp")
          -- require('hover.providers.dap')
          require('hover.providers.diagnostic')
          -- require('hover.providers.highlight')
        end,
        preview_opts = require('plugin.lsp.lsp').hover_opts,
        preview_window = true,
        title = false,
        mouse_providers = { 'LSP' },
        mouse_delay = 1000,
      }
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'tronikelis/ts-autotag.nvim',
      { 'roobert/tailwindcss-colorizer-cmp.nvim' },
    },
  },


  { 'mfussenegger/nvim-jdtls' },
  -- required for nvim-jdtls
  -- see the java section in the README
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    opts = {}
  },
  { 'neovim/nvim-lspconfig' },
  { 'onsails/lspkind.nvim' },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  -- Show virtual lines lenses
  { 'VidocqH/lsp-lens.nvim' },
  -- Show hover on CursorHold
  { "soulis-1256/eagle.nvim" },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = true,
  },
  { 'Civitasv/cmake-tools.nvim',  opts = {} },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    event = 'VeryLazy',
    cmd = "Trouble",
  },

  -- Snippets
  { 'SirVer/Ultisnips' },
  { 'natebosch/dartlang-snippets' },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope-dap.nvim",
      "rcarriga/cmp-dap",
      "Weissle/persistent-breakpoints.nvim",
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "sidlatau/neotest-dart",
        lazy = false,
      },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-dart') {
            command = 'flutter',
            use_lsp = true,
          }
        }
      })
    end
  },

  -- 5. VERSION CONTROL (GIT)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "folke/snacks.nvim",
    },
  },
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      -- require('gitsigns').setup()
    end
  },
  { 'sindrets/diffview.nvim' },

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
      'mrjones2014/legendary.nvim' -- Add this dependency
    },
    config = function()
      require('move').setup({
        use_default_keymaps = true, -- Don't rely on legendary
      })
    end
  },

  -- Cursor and editing UI
  { 'mg979/vim-visual-multi', },

  -- Cursor highlighting
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
    'folke/noice.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      -- require('noice').setup()
    end
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      -- require('notify').setup()
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
    config = function()
      require('mini.icons').setup()
      require('mini.comment').setup({
        -- Options which control module behavior
        options = {
          -- Function to compute custom 'commentstring' (optional)
          custom_commentstring = nil,

          -- Whether to ignore blank lines in actions and textobject
          ignore_blank_line = false,

          -- Whether to recognize as comment only lines without indent
          start_of_line = false,

          -- Whether to force single space inner padding for comment parts
          pad_comment_parts = true,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = 'gc',

          -- Toggle comment on current line
          comment_line = 'gcc',

          -- Toggle comment on visual selection
          comment_visual = 'gc',

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          -- Works also in Visual mode if mapping differs from `comment_visual`
          textobject = 'gc',
        },

        -- Hook functions to be executed at certain stage of commenting
        hooks = {
          -- Before successful commenting. Does nothing by default.
          pre = function() end,
          -- After successful commenting. Does nothing by default.
          post = function() end,
        },
      })
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npx --yes yarn install'
  }
}
