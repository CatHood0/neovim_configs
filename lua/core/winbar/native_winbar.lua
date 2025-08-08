local M = {}

require("core.utils.strings_splitter")
local utils = require("core.winbar.utils")
local shared_state = require('core.winbar.state')
local navic = require("nvim-navic")
local whitespace = " "
local truncate_indicator = "…"
---@type string|number
local file_part_separator = "[^/]+";

---@param shouldForceGeneration? boolean
---@return string?
function M.update_winbar(shouldForceGeneration)
  if shouldForceGeneration == nil then
    shouldForceGeneration = false
  end
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

    local new_winbar, full_path = M.generate_winbar(nil, buf)

    -- Get the current winbar of the window
    ---@diagnostic disable-next-line: deprecated
    local current_visible_winbar = vim.api.nvim_win_get_option(win, 'winbar')

    -- Update if:
    -- 1. The content is different from the cached one
    -- 2. The winbar is empty
    -- 3. The winbar is different from the new generated one
    if shouldForceGeneration or
        (not shared_state.state.buffers[buf] or
          new_winbar ~= shared_state.state.buffers[buf].winbar or
          current_visible_winbar == '' or
          current_visible_winbar ~= new_winbar) then
      shared_state.state.buffers[buf] = {}
      shared_state.state.buffers[buf].winbar = new_winbar
      shared_state.state.buffers[buf].path = full_path
      vim.api.nvim_set_option_value("winbar", new_winbar, {
        win = win,
      })
    end
  end)
end

--- Format every each element by its own way
---@param part string
---@param ext string?
---@param is_file boolean
---@param is_part_break boolean
---@param mode string?
function M.format_element(part, ext, is_file, is_last, is_part_break, mode)
  if is_part_break and not is_file then return "" end
  if shared_state.config.on_format_element then
    local formatted = shared_state.config.on_format_element(part, ext, is_file, is_last)
    if formatted then return formatted end
  end

  local icon, icon_color
  if is_file then
    icon, icon_color = utils.get_file_icon(part)
    icon = icon or shared_state.config.file_icon.icon
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

---Winbar str generator
---@param mode string?
---@param buf integer
---@return string?, string?
function M.generate_winbar(mode, buf)
  if not shared_state.config.enabled then return "" end
  shared_state.state.current_path = ""

  local file_path = vim.fn.expand('%:p:~:.')
  if file_path == "" then return "" end

  local parts = {}
  local curPartPath = ""
  for part in file_path:gmatch(file_part_separator) do
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
    local start_idx = #parts - shared_state.config.depth.limit + 1
    local sub_parts = { unpack(parts, start_idx, #parts) }
    parts = vim.list_extend({ truncate_indicator }, sub_parts)
    curPartPath = vim.fs.joinpath("~/", table.concat(sub_parts, "/"))
  end

  local winbar_parts = {}
  for i, part in ipairs(parts) do
    curPartPath = vim.fs.joinpath(curPartPath, part)
    shared_state.state.current_path = shared_state.state.current_path .. (i > 1 and "/" or "") .. part
    local is_file = (i == #parts)
    local ext = part:match(".+%.(.*)$") or ""
    local element = truncate_indicator
    if shared_state.config.max_string_length and
        shared_state.config.max_string_length >= 2 and
        #part > shared_state.config.max_string_length then
      local effectivePart = string.sub(part, 1, shared_state.config.max_string_length) ..
          truncate_indicator ..
          (is_file and "." .. ext or "")

      element = M.format_element(
        effectivePart,
        ext,
        is_file,
        i == #parts,
        partBreak,
        mode
      )
    else
      element = M.format_element(
        part,
        ext,
        is_file,
        i == #parts,
        partBreak,
        mode
      )
    end

    table.insert(winbar_parts, element)
    if partBreak then
      partBreak = false
      local shouldAddWhitespaces = shared_state.config.depth.separator ~= nil or
          shared_state.config.depth.separator == ""
      local effectiveLimitSeparator = whitespace .. shared_state.config.depth.separator .. whitespace
      table.insert(winbar_parts,
        string.format("%%#%s#%s", shared_state.config.separator_hl_color,
          truncate_indicator .. (shouldAddWhitespaces and effectiveLimitSeparator or "")
        )
      )
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

  if shared_state.config.lsp_enabled and (navic.is_available(buf)) then
    local locationStr = navic.get_location({}, buf)
    if locationStr then
      if #winbar_parts > 0 then
        table.insert(winbar_parts,
          string.format("%%#%s#%s", shared_state.config.separator_hl_color, " " .. shared_state.config.separator .. " "))
      end
      if string.len(locationStr) >= 1 then
        table.insert(winbar_parts, locationStr)
      else
        table.insert(winbar_parts,
          string.format("%%#%s#%s", shared_state.config.separator_hl_color, "" .. truncate_indicator .. " "))
      end
    end
  end

  if #winbar_parts < 1 then
    return nil
  end

  return "  " .. table.concat(winbar_parts, ""), file_path
end

return M
