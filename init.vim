source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/mapping.vim
source ~/.config/nvim/config/plugins.vim

lua << EOF
require('ultimate-autopair').setup({
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recommended as each new version will have breaking changes
  }
)
EOF

lua << EOF
  require'barbar'.setup {
  animation = true,
  -- Automatically hide the tabline when there are this many buffers left.
  -- Set to any value >=0 to enable.
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
 -- exclude_ft = {'javascript'},
  --exclude_name = {'package.json'},

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'left',

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.

  -- Disable highlighting alternate buffers
  highlight_alternate = true,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = true,

  -- Enable highlighting visible buffers
  highlight_visible = true,
     cons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = true,
    buffer_number = true,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = true, icon = 'x'},
      [vim.diagnostic.severity.INFO] = {enabled = true, icon = '!'},
      [vim.diagnostic.severity.HINT] = {enabled = true, icon = '¶'},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '•'},
      deleted = {enabled = true, icon = 'x'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'slanted',
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 3,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,
 
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
      event = { 'BufWinLeave', text = '', align = 'left'},
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {
      text = 'undotree',
      align = 'left', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
    },
    -- Or, specify the event which the sidebar executes when leaving:
    -- Or, specify all three
    -- ['neo-tree'] = {event = 'BufWipeout'},
    Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = 'Neovim',
  --version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
EOF

lua << EOF
require('color-picker').setup({
	["icons"] = { "", "   " },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
  ["text_highlight_group"] = "Normal", --default
})
vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
EOF

lua require('alpha').setup(require('alpha.themes.theta').config)
lua require('pubspec-assist').setup()
lua << EOF
require('tmux').setup({
 navigation = {
   -- cycles to opposite pane while navigating into the border
   cycle_navigation = true,
   -- enables default keybindings (C-hjkl) for normal mode
   enable_default_keybindings = false,
   -- prevents unzoom tmux when navigating beyond vim border
   persist_zoom = true,
 },
 resize = {
   -- enables default keybindings (A-hjkl) for normal mode
   enable_default_keybindings = false,
   -- sets resize steps for x axis
   resize_step_x = 4,
   -- sets resize steps for y axis
   resize_step_y = 4,
 }
})
EOF
lua << EOF
local cmp = require('cmp')
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
	sources = {
   { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
EOF

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF

lua << EOF
require("nvim-treesitter").setup {}
require("nvim-treesitter.configs").setup({
   ensure_installed = { "lua", "vim", 'dart', "vimdoc", 'regex', "javascript", 'typescript', 'css',"html", "rust", "kotlin", 'c', 'cpp', 'xml' },
   sync_install = true,
   endwise = {
    enable = true,
   },
   highlight = { enable = true },
    rainbow = {
     enable = true,
    },
   indent = {
    enable = false,
    disable = {},
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
EOF

lua << EOF
require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

require("gruvbox").setup({
  terminal_colors = true, 
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

local onedark =require('onedark');
onedark.setup {
    style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'bold',
        strings = 'bold',
        variables = 'italic'
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
onedark.load()

require('github-theme').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath('cache') .. '/github-theme',
    compile_file_suffix = '_compiled', -- Compiled file suffix
    hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
    hide_nc_statusline = true, -- Override the underline style for non-active statuslines
    transparent = false,       -- Disable setting background
    terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,      -- Non focused panes set to alternative background
    module_default = true,     -- Default enable value for modules
    -- Also 'italic,bold' or 'bold' or 'italic'
    styles = {                 
      comments = 'italic',       
      functions = 'bold',
      keywords = 'NONE',
      variables = 'NONE',
      conditionals = 'bold',
      constants = 'NONE',
      numbers = 'bold',
      operators = 'bold',
      strings = 'italic',
      types = 'bold', 
    },
    inverse = {                -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    darken = {                 -- Darken floating windows and sidebar-like windows
      floats = false,
      sidebars = {
        enable = true,
        list = {},             -- Apply dark background to specific windows
      },
    },
    modules = {                -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "macchiato",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { },
        strings = { "italic" },
        variables = {},
        numbers = { "bold" },
        booleans = { "bold" },
        properties = { },
        types = { "bold" },
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        barbar = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})
EOF
" Must be after setup since the options wont be applied
colorscheme catppuccin 
"colorscheme catppuccin-latte
"colorscheme catppuccin-frappe
"colorscheme catppuccin-macchiato
"colorscheme catppuccin-mocha
"colorscheme rose-pine-moon
"colorscheme rose-pine-main
"colorscheme rose-pine-moon
"colorscheme rose-pine-dawn
"colorscheme gruvbox
"colorscheme srcery " most similar to gruvbox
"colorscheme onedark
"colorscheme kanagawa-wave
"colorscheme kanagawa-dragon
"colorscheme kanagawa-lotus
"colorscheme kanagawa
"colorscheme palenight
"colorscheme github_dark
"colorscheme github_dark_default
"colorscheme github_dark_dimmed
"colorscheme github_dark_high_contrast
"colorscheme github_dark_colorblind
"colorscheme github_dark_tritanopia
"
"

lua << EOF

 require('lualine').setup{
   extensions = { 'nvim-tree', 'neo-tree', 'fugitive' },
   sections = {
     lualine_a = { 'mode' },
     lualine_b = { 'filename', 'filesize', 'searchcount' },
     lualine_c = { 'branch', 'diff', 'diagnostics' },
     lualine_x = { 'encoding', 'fileformat', 'filetype' }, 
     lualine_y = { --[["g:coc_status'",]] 'g:coc_progress', 'tabnine' },
     lualine_z = { 'selectioncount', 'location' }
   },
   inactive_sections = {
     lualine_a = {},
     lualine_b = {},
     lualine_c = {'filename'},
     lualine_x = {'location'},
     lualine_y = {},
     lualine_z = {}
   },
} 
EOF

lua << EOF
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  markdown = {
    hover = {
      ["|(%S-)|"] = vim.cmd.help, -- vim help links
      ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
    },
    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },
  health = {
    checker = true, -- Disable if you don't want health checks to run
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
EOF

" Translation 
" TODO: implement more languages
" nnoremap <space>te viw:Translate <locale name><CR>
nnoremap <space>te viw:Translate es<CR>
lua require("translate").setup({})

lua << EOF
local telescope = require('telescope')
telescope.load_extension("notify")
telescope.load_extension("noice")
telescope.setup{
    extensions_list = { "themes", "terms", "fzf" },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    previewer = false,
	defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number", 
        "--column", 
        "--smart-case", 
        "--ignore-file=" .. vim.fn.expand("$HOME") .. "/.fdignore" 
      }, 
      find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }, 
      prompt_prefix = " ", 
      --prompt_prefix = "🔍, ", 
      selection_caret = " ", 
      entry_prefix = "  ", 
      initial_mode = "insert", 
      selection_strategy = "reset", 
      sorting_strategy = "ascending", 
      layout_strategy = "horizontal", -- horizontal, allows preview 
      preview = { 
        treesitter = true 
      }, 
      layout_config = { 
        prompt_position = "top", 
        width = 0.65, 
        height = 0.80, 
        preview_cutoff = 120, 
        horizontal = {mirror = false, preview_cutoff = 1}, 
      }, 
      pickers = { 
        find_files = { 
          hidden = false  
        } 
      }, 
      file_sorter = require("telescope.sorters").get_fuzzy_file, 
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter, 
      path_display = {"truncate"}, -- path_display = {"absolute"}, 
      winblend = 0, -- the opacity of the windows 
      border = {}, 
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}, 
 		  color_devicons = true,
      use_less = false, 
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil, 
      file_previewer = require("telescope.previewers").vim_buffer_cat.new, 
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new, 
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, 
      -- Developer configurations: Not meant for general override 
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker 
  }
}
EOF

lua << EOF
local dap = require('dap')
-- dart
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = "/home/cathood0/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart", 
    flutterSdkPath = "/home/cathood0/development/flutter/bin/flutter",             
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/home/cathood0/development/flutter/bin/flutter/bin/cache/dart-sdk/bin/dart", 
    flutterSdkPath = "/home/cathood0/development/flutter/bin/flutter", 
    program = "${workspaceFolder}/lib/main.dart", 
    cwd = "${workspaceFolder}",
  }
}
-- c++/c/rust
dap.adapters.codelldb = {
  type = "executable",
  command = "/home/cathood0/Descargas/debugger_adapters/codelldb/extension/adapter/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
  -- On windows you may have to uncomment this:
  -- detached = false,
}
-- configs
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
EOF

lua << EOF
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" }) 
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

require 'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { 'terminal', "quickfix" },
                    },
            },
})

require('neogit').setup {
 -- Hides the hints at the top of the status buffer
  disable_hint = false,
  -- Disables changing the buffer highlights based on where the cursor is.
  disable_context_highlighting = false,
  -- Disables signs for sections/items/hunks
  disable_signs = false,
  -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
  -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
  -- normal mode.
  disable_insert_on_commit = "auto",
  -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
  -- events.
  filewatcher = {
    interval = 1000,
    enabled = true,
  },
  -- "ascii"   is the graph the git CLI generates
  -- "unicode" is the graph like https://github.com/rbong/vim-flog
  graph_style = "ascii",
  -- Used to generate URL's for branch popup action "pull request".
  git_services = {
    ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
    ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
    ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
  },
  -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
  -- sorter instead. By default, this function returns `nil`.
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  -- Persist the values of switches/options within and across sessions
  remember_settings = true,
  -- Scope persisted settings on a per-project basis
  use_per_project_settings = true,
  -- Table of settings to never persist. Uses format "Filetype--cli-value"
  ignored_settings = {
    "NeogitPushPopup--force-with-lease",
    "NeogitPushPopup--force",
    "NeogitPullPopup--rebase",
    "NeogitCommitPopup--allow-empty",
    "NeogitRevertPopup--no-edit",
  },
  -- Configure highlight group features
  highlight = {
    italic = true,
    bold = true,
    underline = true
  },
  -- Set to false if you want to be responsible for creating _ALL_ keymappings
  use_default_keymaps = true,
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  -- Value used for `--sort` option for `git branch` command
  -- By default, branches will be sorted by commit date descending
  -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
  -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
  sort_branches = "-committerdate",
  -- Change the default way of opening neogit
  kind = "tab",
  -- Disable line numbers and relative line numbers
  disable_line_numbers = true,
  -- The time after which an output console is shown for slow running commands
  console_timeout = 2000,
  -- Automatically show console if a command takes more than console_timeout milliseconds
  auto_show_console = true,
  -- Automatically close the console if the process exits with a 0 (success) status
  auto_close_console = true,
  status = {
    show_head_commit_hash = true,
    recent_commit_count = 10,
    HEAD_padding = 10,
    HEAD_folded = false,
    mode_padding = 3,
    mode_text = {
      M = "modified",
      N = "new file",
      A = "added",
      D = "deleted",
      C = "copied",
      U = "updated",
      R = "renamed",
      DD = "unmerged",
      AU = "unmerged",
      UD = "unmerged",
      UA = "unmerged",
      DU = "unmerged",
      AA = "unmerged",
      UU = "unmerged",
      ["?"] = "",
    },
  },
  commit_editor = {
    kind = "tab",
    show_staged_diff = true,
    -- Accepted values:
    -- "split" to show the staged diff below the commit editor
    -- "vsplit" to show it to the right
    -- "split_above" Like :top split
    -- "vsplit_left" like :vsplit, but open to the left
    -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
    staged_diff_split_kind = "split"
  },
  commit_select_view = {
    kind = "tab",
  },
  commit_view = {
    kind = "vsplit",
    verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
  },
  log_view = {
    kind = "tab",
  },
  rebase_editor = {
    kind = "auto",
  },
  reflog_view = {
    kind = "tab",
  },
  merge_editor = {
    kind = "auto",
  },
  tag_editor = {
    kind = "auto",
  },
  preview_buffer = {
    kind = "split",
  },
  popup = {
    kind = "split",
  },
  signs = {
    -- { CLOSED, OPENED }
    hunk = { "", "" },
    item = { ">", "v" },
    section = { ">", "v" },
  },
  -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
  integrations = {
    -- If enabled, use telescope for menu selection rather than vim.ui.select.
    -- Allows multi-select and some things that vim.ui.select doesn't.
    telescope =true,
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
    -- The diffview integration enables the diff popup.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    diffview = true,

    -- If enabled, uses fzf-lua for menu selection. If the telescope integration
    -- is also selected then telescope is used instead
    -- Requires you to have `ibhagwan/fzf-lua` installed.
    fzf_lua = nil,
  },
  sections = {
    -- Reverting/Cherry Picking
    sequencer = {
      folded = false,
      hidden = false,
    },
    untracked = {
      folded = false,
      hidden = false,
    },
    unstaged = {
      folded = false,
      hidden = false,
    },
    staged = {
      folded = false,
      hidden = false,
    },
    stashes = {
      folded = true,
      hidden = false,
    },
    unpulled_upstream = {
      folded = true,
      hidden = false,
    },
    unmerged_upstream = {
      folded = false,
      hidden = false,
    },
    unpulled_pushRemote = {
      folded = true,
      hidden = false,
    },
    unmerged_pushRemote = {
      folded = false,
      hidden = false,
    },
    recent = {
      folded = true,
      hidden = false,
    },
    rebase = {
      folded = true,
      hidden = false,
    },
  },
  mappings = {
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"] = "Pick",
      ["r"] = "Reword",
      ["e"] = "Edit",
      ["s"] = "Squash",
      ["f"] = "Fixup",
      ["x"] = "Execute",
      ["d"] = "Drop",
      ["b"] = "Break",
      ["q"] = "Close",
      ["<cr>"] = "OpenCommit",
      ["gk"] = "MoveUp",
      ["gj"] = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"] = "Select",
      ["<c-c>"] = "Close",
      ["<esc>"] = "Close",
      ["<up>"] = "Previous",
      ["<down>"] = "Next",
      ["<tab>"] = "MultiselectToggleNext",
      ["<s-tab>"] = "MultiselectTogglePrevious",
      ["<c-j>"] = "NOP",
    },
    -- Setting any of these to `false` will disable the mapping.
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["D"] = "DiffPopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
      ["b"] = "BranchPopup",
      ["B"] = "BisectPopup",
      ["c"] = "CommitPopup",
      ["f"] = "FetchPopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["p"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["v"] = "RevertPopup",
      ["w"] = "WorktreePopup",
    },
    status = {
      ["k"] = "MoveUp",
      ["j"] = "MoveDown",
      ["q"] = "Close",
      ["o"] = "OpenTree",
      ["I"] = "InitRepo",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["<tab>"] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["K"] = "Untrack",
      ["u"] = "Unstage",
      ["U"] = "UnstageStaged",
      ["$"] = "CommandHistory",
      ["Y"] = "YankSelected",
      ["<c-r>"] = "RefreshBuffer",
      ["<enter>"] = "GoToFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"] = "GoToPreviousHunkHeader",
      ["}"] = "GoToNextHunkHeader",
    },
  },
}
EOF
lua require("mini.cursorword").setup()

lua << EOF
-- IA
--[[
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<S-Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
})
]]
EOF

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

lua << EOF
require("neo-tree").setup({
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function()
        vim.cmd("Neotree close")
      end
    },
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd("highlight! Cursor blend=100")
      end,
    },
    {
      event = "neo_tree_buffer_leave",
      handler = function()
        vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
      end,
    },
  },
  hide_root_node = true,
  retain_hidden_root_indent = true,
  filesystem = {
    filtered_items = {
      -- when true, they will just be displayed differently 
      -- than normal items
      visible = true, 
      hide_dotfiles = true,
      hide_gitignored = true,
      -- only works on Windows for hidden files/directories
      hide_hidden = true, 
      show_hidden_count = false,
      never_show = {
       '.DS_Store',
      },
    },
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_default" -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled" -- netrw left alone, neo-tree does not handle opening dirs
    hijack_netrw_behavior = "open_current", 
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["f"] = "filter_on_submit",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
      },
    },
    commands = {} -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    -- the current file is changed while the tree is open.
    follow_current_file = {
      -- This will find and focus the file in the active buffer every time
      enabled = true, 
      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_dirs_open = false,
    },
    -- when true, empty folders will be grouped together
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["."] = "set_root",
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
       ["A"]  = "git_add_all",
       ["gu"] = "git_unstage_file",
       ["ga"] = "git_add_file",
       ["gr"] = "git_revert_file",
       ["gc"] = "git_commit",
       ["gp"] = "git_push",
       ["gg"] = "git_commit_and_push",
       ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
       ["oc"] = { "order_by_created", nowait = false },
       ["od"] = { "order_by_diagnostics", nowait = false },
       ["om"] = { "order_by_modified", nowait = false },
       ["on"] = { "order_by_name", nowait = false },
       ["os"] = { "order_by_size", nowait = false },
       ["ot"] = { "order_by_type", nowait = false },
      },
    },
  },
  diagnostics = {
    auto_preview = { -- May also be set to `true` or `false`
      enabled = false, -- Whether to automatically enable preview mode
      preview_config = {}, -- Config table to pass to auto preview (for example `{ use_float = true }`)
      event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
    },
    bind_to_cwd = true,
    diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
                                     -- "position" means diagnostic items are sorted strictly by their positions.
                                     -- May also be a function.
    follow_current_file = { -- May also be set to `true` or `false`
      enabled = true, -- This will find and focus the file in the active buffer every time
      always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file
      expand_followed = true, -- Ensure the node of the followed file is expanded
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_files_open = false, -- `false` closes auto expanded files, such as with `:Neotree reveal`
    },
    group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    show_unloaded = true, -- show diagnostics from unloaded buffers
    refresh = {
      delay = 100, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
      event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
                                        -- Set to `false` or `"none"` to disable automatic refreshing
      max_items = 10000, -- The maximum number of diagnostic items to attempt processing
                         -- Set to `false` for no maximum
    },
  },
  sources = {
    "filesystem",
    "diagnostics",
  },
  -- Default configs
 	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = true, -- used when sorting files and directories in the tree
  sort_function = nil , -- use a custom function for sorting files and directories in the tree 
	source_selector = {
    -- statusline = true,
	  winbar = false, -- removes the header bar
    statusline = true, 
		content_layout = "center",
		highlight_tab = "NeoTreeTabInactive", -- string
		highlight_tab_active = "NeoTreeTabActive", -- string
		highlight_background = "NeoTreeTabInactive", -- string
		highlight_separator = "ActiveWindow", -- string
		highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
	},
  renderers = {
    file = {
      { "icon" },  
      { "name" }, 
      { "diagnostics" },
    },
    folder = {
      { "icon" },  
      { "name" }, 
      { "diagnostics" },
    },
  },
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      expander_highlight = "NeoTreeExpander",
    },
    diagnostics = {
      symbols = {
        error = "E",  -- Símbolo para errores
        warn = "W",   -- Símbolo para advertencias
        info = "I",   -- Símbolo para información
        hint = "H",   -- Símbolo para sugerencias
      },
      highlights = {
        error = "DiagnosticError",  -- Resaltado para errores
        warn = "DiagnosticWarn",    -- Resaltado para advertencias
        info = "DiagnosticInfo",    -- Resaltado para información
        hint = "DiagnosticHint",    -- Resaltado para sugerencias
      },
    },
    icon = {
     folder_closed = "",
     folder_open = "",
     folder_empty = "󰜌",
     -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
     -- then these will never be used.
     default = "*",
     highlight = "NeoTreeFileIcon"
    },
    modified = {
     symbol = "[✚]",
     highlight = "NeoTreeModified",
    },
    name = {
     trailing_slash = true,
     use_git_status_colors = true,
     highlight = "NeoTreeFileName",
    },
    git_status = {
     symbols = {
     -- Change type
     added  = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
     modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
     deleted   = " ",-- this can only be used in the git_status source
     renamed   = "󰁕",-- this can only be used in the git_status source
     -- Status type
     untracked = "",
     ignored   = "",
     unstaged  = "!",
     staged = "",
     conflict  = "",
     }
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = true,
      required_width = 64, -- min width of window required to show this column
    },
    type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
           ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { 
              "add",
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["<del>"] = "delete",
            ["re"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
        nesting_rules = {}, 
})
EOF

lua << EOF
-- Necessary options for autosession
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
local opts = {
  enabled = true, -- Enables/disables auto creating, saving and restoring
  root_dir = "~/.nvim_sessions/", -- Root dir where sessions will be stored
  auto_save = true, -- Enables/disables auto saving session on exit
  auto_restore = true, -- Enables/disables auto restoring session on start
  auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
  suppressed_dirs = nil, -- Suppress session restore/create in certain directories
  allowed_dirs = nil, -- Allow session restore/create in certain directories
  auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
  use_git_branch = false, -- Include git branch name in session name
  lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
  bypass_save_filetypes = nil, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
  close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
  args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
  args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
  continue_restore_on_error = true, -- Keep loading the session even if there's an error
  show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
  cwd_change_handling = false, -- Follow cwd changes, saving a session before change and restoring after
  lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
  restore_error_handler = nil, -- Called when there's an error restoring. By default, it ignores fold errors otherwise it displays the error and returns false to disable auto_save
  log_level = "error", -- Sets the log level of the plugin (debug, info, warn, error).

  session_lens = {
    load_on_setup = true, -- Initialize on startup (requires Telescope)
    theme_conf = { -- Pass through for Telescope theme options
      -- layout_config = { -- As one example, can change width/height of picker
      --   width = 0.8,    -- percent of window
      --   height = 0.5,
      -- },
    },
    previewer = false, -- File preview for session picker
  },
}

require('auto-session').setup(opts)
EOF

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

"lua require('ibl').setup()

" Use <c-space> to trigger completion (optional since by default COC give us this functionality)
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
augroup group_coc 
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

augroup command_window
  function! ReInitCoc()
        execute("CocDisable")
        execute("CocEnable")
    endfunction
    autocmd CmdwinEnter * startinsert
    autocmd CmdwinEnter * call ReInitCoc()
augroup END
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <silent><expr> <C-Space> coc#refresh()
 
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"
" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd BufWritePre *.go :call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.tsx :call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.ts :call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.js :call CocActionAsync('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.jsx :call CocActionAsync('runCommand', 'editor.action.organizeImport')

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

lua << EOF
vim.treesitter.language.register('markdown', 'vimwiki')
require('render-markdown').setup({
    file_types = { 'markdown', 'vimwiki' },
})
EOF
