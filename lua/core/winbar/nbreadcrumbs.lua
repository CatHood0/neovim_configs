local M = {}
---@module 'core.winbar.config'
---@type WinbarOpts
local winbar_opts = require('core.winbar.config')
local utils = require('core.winbar.utils')
local nativeWinbar = require('core.winbar.native_winbar')
local shared_state = require('core.winbar.state')
local navic = require("nvim-navic")

---@param user_config WinbarOpts
function M.setup(user_config)
  shared_state.config = vim.tbl_deep_extend("force", winbar_opts, user_config or {})

  if not shared_state.config.enabled then
    vim.opt.winbar = nil
    return
  end

  utils.define_hl_groups()
  utils.setup_buffer_cleanup()
  utils.setup_provider()
  if shared_state.config.enabled then
    navic.setup({
      icons = require('plugin.lsp.lsp_symbols').symbols,
      highlight = true,
      separator = " " .. shared_state.config.separator .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = true,
      click = false,
      lsp = {
        auto_attach = true,
        preference = nil,
      }
    })
    local group = vim.api.nvim_create_augroup("WinBarUpdater", {})
    vim.api.nvim_clear_autocmds({ group = group })
    local winbar = nativeWinbar

    for _, event in ipairs(shared_state.config.update_events) do
      vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = winbar.update_winbar
      })
    end

    vim.api.nvim_create_user_command("WinbarToggle", function()
      shared_state.config.enabled = not shared_state.config.enabled
      winbar.update_winbar()
      vim.notify("Winbar " .. (shared_state.config.enabled and "enabled" or "disabled"))
    end, {})

    vim.api.nvim_create_user_command("WinbarRefresh", function()
      winbar.update_winbar()
      vim.notify("Winbar refreshed")
    end, {})

    winbar.update_winbar()
  end
end

return M
