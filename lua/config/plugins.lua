return {
  -- For notes
  {
    "jellydn/my-note.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<space>x",
        "<cmd>MyNote<cr>",
        desc = "Open note",
      },
    },
    opts = {
      files = {
        -- Using the parent .git folder as the current working directory
        cwd = function()
          local bufPath = vim.api.nvim_buf_get_name(0)
          local cwd = require("lspconfig").util.root_pattern(".git")(bufPath)

          return cwd
        end,
      },
    },
  },
  -- 1. BASIC CONFIGURATION AND ESSENTIALS
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
  },

  -- 2. USER INTERFACE AND THEMES

  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim",             name = "rose-pine" },
  { "drewtempelmeyer/palenight.vim" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },
  { "navarasu/onedark.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "rebelot/kanagawa.nvim" },
  { "srcery-colors/srcery-vim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "tiagovla/tokyodark.nvim" },
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    init = function()
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value
      vim.g.neominimap = {
        auto_enable = false,
        click = {
          -- Enable mouse click on the minimap
          enabled = true, ---@type boolean
          -- Automatically switch focus to the minimap when clicked
          auto_switch_focus = true, ---@type boolean
        },
      }
    end,
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
    opts = {
      enabled = true,
      highlight = { link = "Visual", default = true },
      match_types = {
        space = true,
        tab = true,
        nbsp = true,
        lead = false,
        trail = false,
      },
      list_chars = {
        space = "·",
        tab = "↦",
        nbsp = "␣",
        lead = "‹",
        trail = "›",
      },
      fileformat_chars = {
        unix = "↲",
        mac = "←",
        dos = "↙",
      },
      ignore = { filetypes = {}, buftypes = {} },
    },
  },
  -- { 'mbbill/undotree' },
  -- This fix an issue with the foldColumn
  {
    "folke/todo-comments.nvim",
    opts = {},
  },
  -- {
  --   "3rd/image.nvim",
  --   event = "VeryLazy",
  -- },
  { "SmiteshP/nvim-navic" },
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
  },
  -- { 'nvim-telescope/telescope-media-files.nvim', dependencies = 'nvim-lua/popup.nvim' },
  -- Status line and dashboard
  {
    "nvim-lualine/lualine.nvim",
  },
  { "goolord/alpha-nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  { "mfussenegger/nvim-dap" },
  { "igorlfs/nvim-dap-view",      version = "1.*" },

  -- 3. NAVIGATION AND SEARCH
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mrbjarksen/neo-tree-diagnostics.nvim",
    },
    config = function()
      -- require('neo-tree').setup()
    end,
  },
  { "ryanoasis/vim-devicons" },

  -- Search tools
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    config = function()
      -- require('telescope').setup()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "junegunn/fzf",
    build = function()
      -- Versión compatible con Lua del comando fzf#install()
      vim.cmd("call fzf#install()")
    end,
    dependencies = {
      "junegunn/fzf.vim",
    },
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        source = diff.gen_source.none(),
      })
    end,
  },

  -- Markdown
  { "MeanderingProgrammer/markdown.nvim" },
  -- We set just markview for codecompanion
  -- since we prefer not using both in markdown files
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  -- { "github/copilot.vim" },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      language = "Spanish",
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
  },

  -- Window management
  {
    "aserowy/tmux.nvim",
    config = function()
      -- require('tmux').setup()
    end,
  },

  -- 4. LANGUAGE AND DEVELOPMENT
  -- LSP and completion
  -- Snippet engine and snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "honza/vim-snippets",
    },
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Require pr
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          require("hover.providers.lsp")
          -- require('hover.providers.dap')
          -- require('hover.providers.diagnostic')
          -- require('hover.providers.highlight')
        end,
        preview_opts = require("plugin.lsp.lsp").hover_opts,
        preview_window = true,
        title = false,
        mouse_providers = {
          "hover.providers.lsp",
          -- 'hover.providers.diagnostic'
        },
        mouse_delay = 1000,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
  },

  -- { 'mfussenegger/nvim-jdtls' },
  -- required for nvim-jdtls
  {
    "nvim-java/nvim-java",
  },
  -- 默认使用 mason 或 ~/.vscode/extensions/vmware.vscode-spring-boot-x.xx.x 中的 jar
  -- {
  --   "JavaHello/spring-boot.nvim",
  --   ft = { "java", "yaml", "jproperties" },
  --   opts = {},
  -- },
  -- see the java section in the README
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
    opts = {},
  },
  { "neovim/nvim-lspconfig" },
  -- we use schemas for jsonls and yamlls
  { "b0o/schemastore.nvim" },
  { "onsails/lspkind.nvim" },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  -- Show virtual lines lenses
  { "VidocqH/lsp-lens.nvim" },
  -- Show hover on CursorHold
  -- Following either your mouse or your cursor, this plugin provides a custom floating (popup) window that displays
  -- any diagnostic (Error, Warning, Hint) returned by the Diagnostic API, along with lsp information returned by the LSP API
  { "soulis-1256/eagle.nvim" },
  {
    "akinsho/flutter-tools.nvim",
    config = true,
  },
  -- { 'Civitasv/cmake-tools.nvim',  opts = {} },
  {
    "folke/trouble.nvim",
    opts = require("core.trouble.trouble_opts"),
    event = "VeryLazy",
    cmd = "Trouble",
  },
  -- TESTING
  {
    "quolpr/quicktest.nvim",
    config = function()
      local qt = require("quicktest")
      qt.setup({
        adapters = {
          require("quicktest.adapters.golang")({}),
          require("quicktest.adapters.vitest")({}),
          require("quicktest.adapters.playwright")({}),
          -- require("quicktest.adapters.pytest")({}),
          -- require("quicktest.adapters.elixir"),
          -- require("quicktest.adapters.criterion"),
          require("quicktest.adapters.dart"),
          require("quicktest.adapters.rspec"),
        },
        -- split or popup mode, when argument not specified
        default_win_mode = "split",
        use_builtin_colorizer = true,
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>tl",
        function()
          local qt = require("quicktest")
          -- current_win_mode return currently opened panel, split or popup
          -- qt.run_line()
          -- You can force open split or popup like this:
          qt.run_line("split")
          -- qt.run_line('popup')
        end,
        desc = "[T]est Run [L]line",
      },
      {
        "<leader>tf",
        function()
          local qt = require("quicktest")

          qt.run_file()
        end,
        desc = "[T]est Run [F]ile",
      },
      {
        "<leader>td",
        function()
          local qt = require("quicktest")

          qt.run_dir()
        end,
        desc = "[T]est Run [D]ir",
      },
      {
        "<leader>ta",
        function()
          local qt = require("quicktest")

          qt.run_all()
        end,
        desc = "[T]est Run [A]ll",
      },
      {
        "<leader>tp",
        function()
          local qt = require("quicktest")

          qt.run_previous()
        end,
        desc = "[T]est Run [P]revious",
      },
      {
        "<leader>tt",
        function()
          local qt = require("quicktest")

          qt.toggle_win("split")
        end,
        desc = "[T]est [T]oggle Window",
      },
      {
        "<leader>tc",
        function()
          local qt = require("quicktest")

          qt.cancel_current_run()
        end,
        desc = "[T]est [C]ancel Current Run",
      },
    },
  },

  -- Snippets
  { "SirVer/Ultisnips" },
  { "natebosch/dartlang-snippets" },
  -- {
  { "Weissle/persistent-breakpoints.nvim" },

  -- },
  -- language injection
  -- { "TheNoeTrevino/roids.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-context"
    },
    lazy = false,
    -- Telescope current_buffer_fuzzy_find
    -- does not work with main branch
    -- branch = "main",
    build = ":TSUpdate",
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
  { "tpope/vim-fugitive" },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      -- require('gitsigns').setup()
    end,
  },
  { "sindrets/diffview.nvim" },

  -- 6. TEXT AND CODE EDITING
  -- Pairs and surrounds
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    config = function()
      -- require('ultimate-autopair').setup()
    end,
  },

  -- Indentation and syntax
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- require('indent_blankline').setup()
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Text manipulation
  {
    "hinell/move.nvim",
    dependencies = {
      "mrjones2014/legendary.nvim", -- Add this dependency
    },
    config = function()
      require("move").setup({
        use_default_keymaps = true, -- Don't rely on legendary
      })
    end,
  },

  -- Cursor highlighting
  {
    "echasnovski/mini.cursorword",
    branch = "stable",
    config = function()
      -- require('mini.cursorword').setup()
    end,
  },
  { "sphamba/smear-cursor.nvim" },
  { "tronikelis/ts-autotag.nvim" },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },

  -- 7. TERMINAL
  {
    "akinsho/toggleterm.nvim",
    config = function()
      -- require('toggleterm').setup()
    end,
  },

  -- 9. UTILITIES AND PRODUCTIVITY
  -- Sessions and project management
  {
    "rmagatti/auto-session",
    config = function()
      -- require('auto-session').setup()
    end,
  },

  -- Notifications and UI
  {
    "folke/noice.nvim",
    config = function()
      -- require('noice').setup()
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      -- require('notify').setup()
    end,
  },

  -- Formatting and linting
  { "nvimtools/none-ls.nvim" },
  { "MunifTanjim/nui.nvim" },
  {
    "ckipp01/stylua-nvim",
    build = "cargo install stylua",
  },

  -- 10. LANGUAGE SPECIFIC
  -- Dart/Flutter
  {
    "akinsho/pubspec-assist.nvim",
    config = function()
      -- require('pubspec-assist').setup()
    end,
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.icons").setup()
      require("mini.comment").setup({
        -- Options which control module behavior
        options = {
          -- Function to compute custom 'commentstring' (optional)
          custom_commentstring = nil,

          -- Whether to ignore blank lines in actions and textobject
          ignore_blank_line = true,

          -- Whether to recognize as comment only lines without indent
          start_of_line = false,

          -- Whether to force single space inner padding for comment parts
          pad_comment_parts = true,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "gc",

          -- Toggle comment on current line
          comment_line = "gcc",

          -- Toggle comment on visual selection
          comment_visual = "gc",

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          -- Works also in Visual mode if mapping differs from `comment_visual`
          textobject = "gc",
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
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   build = 'cd app && npx --yes yarn install'
  -- }
}
