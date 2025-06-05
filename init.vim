" Settings
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/mapping.vim
source ~/.config/nvim/config/plugins.vim
" Plugins
source ~/.config/nvim/config/plugins/autosession/autosession_plugin.vim
source ~/.config/nvim/config/plugins/coc/coc_plugin.vim
source ~/.config/nvim/config/plugins/dart_dap/dap_plugin.vim
source ~/.config/nvim/config/plugins/neotree/neotree_plugin.vim
source ~/.config/nvim/config/plugins/notify/notify_plugin.vim
source ~/.config/nvim/config/plugins/toggleterm/toggleterm_plugin.vim
source ~/.config/nvim/config/plugins/cursors/cursors_plugins.vim
source ~/.config/nvim/config/plugins/barbar/barbar_plugin.vim
source ~/.config/nvim/config/plugins/cmp/cmp_plugin.vim
source ~/.config/nvim/config/plugins/treesitter/treesitter_plugin.vim
source ~/.config/nvim/config/plugins/telescope/telescope_plugin.vim
source ~/.config/nvim/config/plugins/themes/themes_plugin.vim
source ~/.config/nvim/config/plugins/git/git_plugins.vim
source ~/.config/nvim/config/plugins/statusline/statusline_plugin.vim
source ~/.config/nvim/config/plugins/indent_line/indent_line_plugin.vim

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
" nnoremap <space>te viw:Translate <locale name><CR>
nnoremap <space>te viw:Translate es<CR>
lua require("translate").setup({})

lua << EOF
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
EOF

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

" Use <c-space> to trigger completion (optional since by default COC give us this functionality)
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

