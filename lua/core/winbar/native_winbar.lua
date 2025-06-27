local M = {}

local utils = require("core.winbar.utils")
local shared_state = require('core.winbar.state')

function M.update_winbar()
  vim.schedule(function()
    if vim.api.nvim_get_mode().mode == 'i' and not shared_state.config.update_in_insert then
      return
    end

    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    if not vim.api.nvim_buf_is_loaded(buf) or not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
      return
    end

    local buftype = vim.bo[buf].buftype
    local filetype = vim.bo[buf].filetype

    if shared_state.config.exclude_winbar_from and #shared_state.config.exclude_winbar_from > 0 then
      for _, exclude in ipairs(shared_state.config.exclude_winbar_from) do
        if exclude == buftype or exclude == filetype then
          return
        end
      end
    end

    local new_winbar = M.generate_winbar()

    --[[print(vim.inspect({
      current_buffer = buf - 1,
      win = win,
      ---@diagnostic disable-next-line: param-type-mismatch
      args = new_winbar == nil and " " or string.sub(new_winbar, 60, nil),
    }))
    ]] --

    -- Get the current winbar of the window
    ---@diagnostic disable-next-line: deprecated
    local current_visible_winbar = vim.api.nvim_win_get_option(win, 'winbar') or ''

    -- Update if:
    -- 1. The content is different from the cached one
    -- 2. The winbar is empty
    -- 3. The winbar is different from the new generated one
    if new_winbar ~= shared_state.state.buffers[buf] or
        current_visible_winbar == '' or
        current_visible_winbar ~= new_winbar then
      shared_state.state.buffers[buf] = new_winbar
      ---@diagnostic disable-next-line: deprecated
      vim.api.nvim_win_set_option(win, 'winbar', new_winbar or '')
    end
  end)
end

-- Format every each element by its own way
function M.format_element(part, ext, is_file, is_last, is_part_break, mode)
  if is_part_break and not is_file then return "" end
  if shared_state.config.on_format_element then
    local formatted = shared_state.config.on_format_element(part, ext, is_file, is_last)
    if formatted then return formatted end
  end

  local icon, icon_color
  if is_file then
    icon, icon_color = utils.get_file_icon(part)
    icon = icon or shared_state.config.file_icon.fallback_icon
    icon_color = icon_color or shared_state.config.file_icon.hl_group
  else
    icon, icon_color = utils.get_folder_icon(part)
    icon = icon or shared_state.config.folder_icon.icon
    icon_color = icon_color or shared_state.config.folder_icon.hl_group
  end
  local element = ""
  local useCommentMode = mode ~= nil and type(mode) == "string" and mode == "Comment"

  if icon and icon ~= "" and icon_color ~= "" then
    element = string.format("%%#%s#%s %%*", useCommentMode and "Comment" or icon_color, icon)
  end
  local color = not icon_color and "" or is_file and shared_state.config.file_hl_color or
      shared_state.config.folder_hl_group
  if is_last and is_file then
    local diag = utils.get_diagnostic()
    color = diag ~= nil and diag or shared_state.config.file_hl_color
  end
  element = element .. string.format("%%#%s#%s", useCommentMode and "Comment" or color, part)

  return element
end

-- Núcleo de generación de winbar
function M.generate_winbar(mode)
  if not shared_state.config.enabled then return "" end
  shared_state.state.current_path = ""

  local file_path = vim.fn.expand('%:p:~:.')
  if file_path == "" then return "" end

  local parts = {}
  for part in file_path:gmatch("[^/]+") do
    table.insert(parts, part)
  end

  if shared_state.config.exclude_winbar_from and #shared_state.config.exclude_winbar_from >= 1 then
    for _, exclusion in ipairs(shared_state.config.exclude_winbar_from) do
      if exclusion == parts[#parts - 1] then
        return nil
      end
    end
  end

  local partBreak = false
  if shared_state.config.depth and shared_state.config.depth.limit and #parts > shared_state.config.depth.limit then
    partBreak = true
    parts = { "…", unpack(parts, #parts - shared_state.config.depth.limit + 1) }
  end

  local winbar_parts = {}
  for i, part in ipairs(parts) do
    shared_state.state.current_path = shared_state.state.current_path .. (i > 1 and "/" or "") .. part
    local is_file = (i == #parts)
    local ext = part:match(".+%.(.*)$") or ""
    local element = M.format_element(part, ext, is_file, i == #parts, partBreak, mode)
    table.insert(winbar_parts, element)
    if partBreak then
      partBreak = false
      table.insert(winbar_parts,
        string.format("%%#%s#%s", shared_state.config.separator_hl_color,
          "…  " .. (shared_state.config.depth.separator ~= nil and shared_state.config.depth.separator or "") .. "  "))
    else
      if i < #parts then
        if mode ~= nil and type(mode) == "string" then
          table.insert(winbar_parts, string.format("%%#%s#%s", mode, " " .. shared_state.config.separator .. " "))
        else
          table.insert(winbar_parts,
            string.format("%%#%s#%s", shared_state.config.separator_hl_color, " " .. shared_state.config.separator .. " "))
        end
      end
    end
  end
  return "  " .. table.concat(winbar_parts, "")
end

return M
