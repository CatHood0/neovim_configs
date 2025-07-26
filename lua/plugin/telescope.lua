local telescope = require('telescope')
telescope.load_extension("notify")
telescope.load_extension("flutter")
telescope.load_extension('media_files')
telescope.load_extension('dap')

local dap = require('telescope.builtin')

vim.keymap.set('n', '<leader>db', function() dap.list_breakpoints() end, { desc = "List DAP Breakpoints" })
vim.keymap.set('n', '<leader>dc', function() dap.commands() end, { desc = "DAP Commands" })
vim.keymap.set('n', '<leader>df', function() dap.configurations() end, { desc = "DAP Configurations" })
vim.keymap.set('n', '<leader>dv', function() dap.variables() end, { desc = "DAP Variables" })

telescope.setup {
  extensions_list = { "themes", "terms", "fzf", "dap" },
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
      treesitter = true,
      mime_hook = function(filepath, bufnr, opts)
        require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
      end,
    },
    layout_config = {
      prompt_position = "top",
      width = 0.65,
      height = 0.80,
      preview_cutoff = 120,
      horizontal = { mirror = false, preview_cutoff = 1 },
    },
    pickers = {
      find_files = {
        hidden = false
      }
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" }, -- path_display = {"absolute"},
    winblend = 0,                  -- the opacity of the windows
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = false,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
  }
}
