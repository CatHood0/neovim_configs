-- CHADTree configuration
-- For more options, see :CHADhelp

-- Disable netrw so chadtree can take over
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set icons
vim.g.chadtree_git_status_signs = {
  added = "✚",
  deleted = "✖",
  modified = "✹",
  renamed = "➜",
  unmerged = "═",
  untracked = "…",
}
vim.g.chadtree_view_open_in_split = "S"
vim.g.chadtree_view_open_in_vsplit = "s"
vim.g.chadtree_view_open_in_tab = "t"

-- Key mappings
vim.g.chadtree_keymap = {
  ["<cr>"] = "CHADopen_vsplit",
  ["o"] = "CHADopen",
  ["a"] = "CHADadd",
  ["d"] = "CHADdelete",
  ["<del>"] = "CHADdelete",
  ["r"] = "CHADrename",
  ["c"] = "CHADcopy",
  ["x"] = "CHADcut",
  ["p"] = "CHADpaste",
  ["<c-r>"] = "CHADrefresh",
  ["."] = "CHADtoggle_hidden",
  ["q"] = "CHADquit",
  ["?"] = "CHADhelp",
}

-- Other settings to mimic neotree
vim.g.chadtree_settings = {
  -- -- Close CHADTree when a file is opened
  -- close_on_open = 1,
  -- -- Use devicons
  -- use_nerd_fonts = 1,
  -- -- Follow current file
  -- follow = 1,
  -- -- Window position and width
  -- width = 40,
  -- -- Don't show gitignored files
  -- show_git_ignored = 0,
  -- -- Hide dotfiles by default
  -- show_hidden = 0,
}
