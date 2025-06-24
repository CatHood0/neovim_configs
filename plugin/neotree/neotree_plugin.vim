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
  hide_root_node = false,
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
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
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
  sources = {
    "filesystem",
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
	  winbar = true, -- removes the header bar
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
      { "diagnostics" },
      { "icon" },  
      { "name" }, 
    },
    folder = {
      { "diagnostics" },
      { "icon" },  
      { "name" }, 
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
      enabled = true,
      symbols = {
        error = " ",  -- Símbolo para errores
        warn = " ",   -- Símbolo para advertencias
        info = " ",   -- Símbolo para información
        hint = "󰌵 ",   -- Símbolo para sugerencias
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
