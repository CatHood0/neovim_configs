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
   ensure_installed = { "lua", "vim", 'dart', "vimdoc", 'regex', "javascript", "html" },
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
        functions = 'none',
        strings = 'none',
        variables = 'none'
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
        darker = false, -- darker colors for diagnostic
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
        enabled = true,
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
EOF
" Must be after setup since the options wont be applied
"colorscheme rose-pine-moon
"colorscheme rose-pine-main
"colorscheme rose-pine-moon
"colorscheme rose-pine-dawn
"colorscheme gruvbox
colorscheme onedark
"colorscheme palenight
"colorscheme github_dark
"colorscheme github_dark_default
"colorscheme github_dark_dimmed
"colorscheme github_dark_high_contrast
"colorscheme github_dark_colorblind
"colorscheme github_dark_tritanopia


lua << EOF
 require('lualine').setup{
 sections = {
   lualine_a = { 'mode' },
   lualine_b = { 'filename' },
   lualine_c = { 'branch', 'diff', 'diagnostics' },
   lualine_x = { 'encoding', 'fileformat', 'filetype' }, 
   lualine_y = { 'lsp_progress', 'tabnine' },
   lualine_z = { 'progress' , 'localtion' }
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
-- IA
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<S-e>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
})
EOF



lua << EOF
local telescope = require('telescope')
telescope.load_extension("noice")
telescope.load_extension("notify")
telescope.setup{
    previewer = true,
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
      layout_strategy = "horizontal",
      preview = {
        treesitter = true
      },
      layout_config = {
        prompt_position = "top",
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
        horizontal = {mirror = false, preview_cutoff = 1},
      },
      pickers = {
        find_files = {
          hidden = true
        }
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = {"truncate"}, -- path_display = {"absolute"},
      winblend = 0,
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
    },
}
EOF


lua << EOF
require("action-hints").setup({
     template = {
        	definition = { text = " ⊛", color = "#add8e6" },
        	references = { text = " ↱%s", color = "#ff6666" },
     },
	  sections = {
    		lualine_x = { require("action-hints").statusline },
  	  },
     use_virtual_text = true,
})
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
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
  },
}
EOF
lua require("mini.cursorword").setup()

lua << EOF
require("toggleterm").setup({
   hide_numbers = true, -- hide the number column in toggleterm buffers
   autochdir = false,
   size = '50',
   start_in_insert = true,
   insert_mappings = true, -- whether or not the open mapping applies in insert mode
   direction = 'float',
   terminal_mappings = false, -- whether or not the open mapping applies in the opened terminals
   persist_size = true,
   persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
   close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell
   auto_scroll = true, -- automatically scroll to the bottom on terminal output
   float_opts = {
      border = 'single', 
      title_pos = 'center', 
   },
})
EOF


lua << EOF
require("neo-tree").setup({
-- Diagnostics configs
sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
    -- ...and any additional source
  },
  -- These are the defaults
  diagnostics = {
    auto_preview = { -- May also be set to `true` or `false`
      enabled = true, -- Whether to automatically enable preview mode
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
-- Default configs
    	  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = true, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 

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
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
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
            symbol = "[+]",
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
              added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "󰁕",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "!",
              staged    = "",
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
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_default",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
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
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
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
            }
          }
        },
   source_selector = {
            winbar = true,
            statusline = true , 
  },
})
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
local opts = {
  log_level = 'info',
  auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = true,
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

lua require('ibl').setup()

" COC

" Use <c-space> to trigger completion (optional since by default COC give us this functionality)
""if has('nvim')
""  inoremap <silent><expr> <c-space> coc#refresh()
""else
""  inoremap <silent><expr> <c-@> coc#refresh()
""endif
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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
nnoremap <silent> <space>w :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> <space>ca <Plug>(coc-codeaction-cursor)
nnoremap <silent> <space>cs <Plug>(coc-codeaction-source)
nnoremap <silent> <space>cf  <Plug>(coc-fix-current)
"nnoremap <silent> <space>cc  <Plug>(coc-codeaction-cursor)
" nmap <silent><leader>g <Plug>(coc-definition)
"    nmap <leader>t <Plug>(coc-type-definition)
"    nmap <leader>i <Plug>(coc-implementation)
 nmap <leader>w <Plug>(coc-references)
"    nmap <leader>r <Plug>(coc-rename)
"Remap keys for applying codeAction to the current buffer.
"    nmap <leader>d  <Plug>(coc-codeaction)
"    nmap <leader>u  <Plug>(coc-codeaction-source)
"    nmap <leader>k  <Plug>(coc-codeaction-selected)w
"    nmap <leader>j  <Plug>(coc-codeaction-line)
"    nmap <leader>h  <Plug>(coc-codeaction-cursor)
nnoremap <silent> <space>fi <CMD>:CocDiagnostics<CR> 
nnoremap <silent> <C-d>d <Plug>(coc-definition)
" Remove CMP key to search in CMP autocomplete instead Coc

imap  <C-n> <Nop>
imap  <C-p> <Nop>



lua << EOF
-- Just works with LSP native 
-- Formatter
--[[local null_ls = require("null-ls") 
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function get_class_node()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "class_definition" then
      return node
    end
    node = node:parent()
  end
  return nil
end

local function get_constructor(class_node)
    for child in class_node:iter_children() do
        if child:type() == "constructor_signature" then
        return child;
        end
    end
end

local function get_class_attributes(class_node, bufnr)
    local attributes = {}

    -- Iterar sobre los hijos del nodo de la clase
    for child in class_node:iter_children() do
        if child:type() == "class_body" then
            -- Iterar sobre las declaraciones dentro del class_body
            for declaration in child:iter_children() do
                local isNullable = false
                -- Solo procesar nodos de tipo "declaration"
                if declaration:type() == "declaration" then
                local type_node, type_arguments,identifier_nodes = nil, nil,{}
                -- Iterar sobre los hijos de la declaración para encontrar type_node e identifier_nodes
                for node in declaration:iter_children() do
                if node:type() == 'type_arguments' then
                   type_arguments = node 
                elseif node:type() == "type_identifier" or node:type() == "inferred_type" then 
                    type_node = node
                elseif node:type() == "initialized_identifier_list" then
                    -- Iterar sobre los identificadores inicializados dentro de initialized_identifier_list
                    for  identifier_node in node:iter_children() do
                        if identifier_node:type() == "initialized_identifier" then
                          table.insert(identifier_nodes, identifier_node:child(0))
                        end
                    end
                end
            end

                -- Verificar que se hayan encontrado nodos válidos para tipo y nombre
                if type_node and #identifier_nodes > 0 then
                    -- Obtener el texto del tipo
                    local type_text = vim.treesitter.get_node_text(type_node, bufnr)
                    local arguments = '' 
                    if type_arguments~=nil then
                      arguments = vim.treesitter.get_node_text(type_arguments, bufnr)
                    end
                    -- Obtener los textos de los nombres de los identificadores
                    local names = {}
                    for _, id_node in ipairs(identifier_nodes) do
                        local name_text = vim.treesitter.get_node_text(id_node, bufnr)
                        if name_text then
                            table.insert(names, name_text)
                        end
                    end
                    -- Añadir los atributos a la lista de atributos
                    if type_text and #names > 0 then
                        for _, name_text in ipairs(names) do
                            table.insert(attributes, {
                                type = type_text,
                                name = name_text,
                                arguments = arguments,
                            })
                        end
                    end
                end
            end
        end
    end
end

    return attributes
end

local function generate_to_json(class_name, attributes)
  if type(attributes) ~= "table" then return {"// No attributes found", attributes} end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { 'import "dart:convert";' })
  local lines = { '' }
  table.insert(lines, 'Map<String, dynamic> toMap() {')
  table.insert(lines, "  return {")
  for _, attr in ipairs(attributes) do
    table.insert(lines, string.format('    "%s": %s,', attr.name, attr.name))
  end
  table.insert(lines, "  };")
  table.insert(lines, "}")
  table.insert(lines, " ")
  -- fromMap
  table.insert(lines, string.format("factory %s.fromMap(Map<String,dynamic> map) {", class_name))
  table.insert(lines, "   throw UnimplementedError('No implemented fromMap');")
  table.insert(lines, "}")
  table.insert(lines, " ")
  --fromJson
  table.insert(lines, string.format("factory %s.fromJson(String source) => %s.fromMap(json.decode(source) as Map<String,dynamic>);", class_name, class_name))
  table.insert(lines, " ")
  --toJson
  table.insert(lines, "String toJson() => json.encode(toMap());")
  table.insert(lines, " ")
  return lines
end

local function generate_copy_with(class_name, attributes)
  local method_body = {}

    -- Construir el encabezado del método
    table.insert(method_body, string.format("%s copyWith({", class_name))

    -- Construir los parámetros del método
    for idx, attr in ipairs(attributes) do
        -- Determinar si el parámetro es nullable
        local invalidNullable = attr.type == 'var' or attr.type == 'dynamic'
        -- Construir la línea del parámetro con tipo y nombre
        local param_line = string.format("  %s%s%s %s%s",
            attr.type:gsub("[?]",''),  -- Remover el "?" para obtener el tipo base
            attr.arguments, 
            invalidNullable==false and '?' or '',
            attr.name,
            idx < #attributes and "," or ""  -- Añadir coma si no es el último parámetro
        )
        table.insert(method_body, param_line)
    end

    -- Construir el cuerpo del método
    table.insert(method_body, "}) {")
    table.insert(method_body, "   throw UnimplementedError('No implemented copyWith');")
    table.insert(method_body, "}")

    return method_body
end


local function generate_equals(class_name, attributes)
if type(attributes) ~= "table" then return {"// No attributes found"} end
  local lines = { "bool operator ==(Object other) {" }
  table.insert(lines, "  if (identical(this, other)) return true;")
  table.insert(lines, string.format("  return other is %s &&", class_name))
  for i, attr in ipairs(attributes) do
    if i == #attributes then
      table.insert(lines, string.format("    other.%s == %s;", attr.name, attr.name))
    else
      table.insert(lines, string.format("    other.%s == %s &&", attr.name, attr.name))
    end
  end
  table.insert(lines, "}")
  table.insert(lines, "")
  return lines
end

local function generate_hash_code(class_name,attributes)
if type(attributes) ~= "table" then return {"// No attributes found"} end
  local lines = { "@override" }
  table.insert(lines, "int get hashCode =>")
  for i, attr in ipairs(attributes) do
    if i == #attributes then
      table.insert(lines, string.format("    %s.hashCode;", attr.name))
    else
      table.insert(lines, string.format("    %s.hashCode ^", attr.name))
    end
  end
  table.insert(lines, " ")
  return lines
end

local function generate_method_action(params, generator_function)
  local node = get_class_node()
  if not node then
    return
  end

  local bufnr = params.bufnr
  local class_name_node = node:field("name")[1]
  if not class_name_node then
    return
  end
  local class_name = vim.treesitter.get_node_text(class_name_node, bufnr)
  local attributes = get_class_attributes(node, bufnr)
  local constructor = get_constructor(node) 
  local method_lines = generator_function(class_name, attributes,node,constructor)
  if #method_lines > 0 then
    vim.api.nvim_buf_set_lines(bufnr, params.row, params.row, false, method_lines)
  end
end


null_ls.register({
  name = 'tojson',
  method = null_ls.methods.CODE_ACTION,
  filetypes =  { 'dart' },
  generator = {
    fn = function(params)
      return {
        {
          title = "Generate toJson",
          action = function() generate_method_action(params, generate_to_json) end,
        }
      }
    end,
  }
})

null_ls.register({
  name = 'copywith',
  method = null_ls.methods.CODE_ACTION,
  filetypes =  { 'dart' },
  generator = {
    fn = function(params)
      return {
        {
          title = "Generate copyWith",
          action = function() generate_method_action(params, generate_copy_with) end,
        }
      }
    end,
  },
})

null_ls.register({
  name = 'equals-and-hashcode',
  filetypes =  { 'dart' },
  method = null_ls.methods.CODE_ACTION,
  generator = {
    fn = function(params)
      return {
        {
          title = "Generate equals and hashcode",
          action = function() 
            generate_method_action(params, generate_equals) 
            generate_method_action(params, generate_hash_code)
          end,
        }
      }
    end,
  },
})

null_ls.register({
  name = 'equals',
  filetypes =  { 'dart' },
  method = null_ls.methods.CODE_ACTION,
  generator = {
    fn = function(params)
      return {
        {
          title = "Generate equals",
          action = function() generate_method_action(params, generate_equals) end,
        }
      }
    end,
  },
})
null_ls.register({
  name = 'hashcode',
  method = null_ls.methods.CODE_ACTION,
  filetypes =  { 'dart' },
  generator = {
    fn = function(params)
      return {
        {
          title = "Generate hashCode",
          action = function() generate_method_action(params, generate_hash_code) end,
        }
      }
    end,
  },
})

null_ls.setup({
  debug = false,
  sources = {
    -- If you wanna dart_format services, active it, but, it could have issues with dartls and doesn't show widget actions
    --formatting.dart_format,
  },
    border = nil,
    cmd = { "nvim" },
    debounce = 250,
    debug = false,
    default_timeout = 20000,
    diagnostic_config = {
    },
    diagnostics_format = "#{m}",
    fallback_severity = vim.diagnostic.severity.ERROR,
    log_level = "warn",
    notify_format = "[null-ls] %s",
    on_attach = nil,
    on_init = nil,
    on_exit = nil,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
    should_attach = nil,
    temp_dir = '~/.config/nvim/null-ls-temp',
    update_in_insert = false,
  -- To format on save (can be slow with large files)
 --[[ on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
 
})
]]
EOF
