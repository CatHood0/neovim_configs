require("image").setup({
  backend = "kitty",
  processor = "magick_rock",
  max_width = 200,
  max_height = 150,
  max_wi_window_percentage = 50,
  max_height_window_percentage = 50,
  hijack_file_patterns = {
    "*.png",
    "*.jpg",
    "*.jpeg",
    "*.gif",
    "*.webp",
    "*.svg"
  },
  window_overlap_clear_enabled = false,
  window_overlap_clear_ft_ignore = {
    "cmp_menu",
    "cmp_docs",
    "snacks_notif",
    "scrollview",
    "scrollview_sign"
  },
  editor_only_render_when_focused = true,
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = "popup",
      floating_windows = false,              -- if true, images will be rendered in floating markdown windows
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
    typst = {
      enabled = true,
      filetypes = { "typst" },
    },
    html = {
      only_render_image_at_cursor = true,
      clear_in_insert_mode = true,
      enabled = true,
    },
    css = {
      enabled = true,
    },
  },
})
