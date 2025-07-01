---@class State
---@field state TempState the state of the nbreadcrumbs
---@field config WinbarOpts? the configs of the nbreadcrumbs

---@class TempState
---@field current_path string the full path of the current buffer
---@field use_full_paths boolean determines if we will use the full path each time that we try to get the icons 
---@field buffers table<integer, table> the current active buffers where the winbar was configured
---@field hl_groups_defined boolean determines if the hl groups are configured already
---@field get_file_icon fun(name: string, ext: string)?:string,string? Custom folder icon/color
---@field get_folder_icon fun(name: string)?:string,string? Custom file icon/color

---@module 'core.winbar.config'
---@type WinbarOpts
local winbar_opts = require('core.winbar.config')

local M = {
  state = {
    current_path = "",
    buffers = {},
    hl_groups_defined = false,
    get_file_icon = nil,
    get_folder_icon = nil,
    use_full_paths = false,
  },
  config = vim.deepcopy(winbar_opts)
}
return M
