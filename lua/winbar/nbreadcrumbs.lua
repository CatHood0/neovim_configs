local M = {}
local winbar_opts = require('winbar.config')
local utils = require('winbar.utils')
local nativeWinbar = require('winbar.native_winbar')
local shared_state = require('winbar.nbreadcrumb_state')

function M.setup(user_config)
  shared_state.config = vim.tbl_deep_extend("force", winbar_opts, user_config or {})
  utils.define_hl_groups()
  utils.setup_buffer_cleanup()

  vim.schedule(function()
    if not pcall(require, 'nui') then
      vim.notify("[nui] is not installed. We will show the native winbar (does not support most of the features)", vim.log.levels.WARN)
      shared_state.config.use_nui = false
    else
      shared_state.config.use_nui = true
    end
  end)

  if shared_state.config.enabled then
    local group = vim.api.nvim_create_augroup("WinBarUpdater", {})
    vim.api.nvim_clear_autocmds({ group = group })

    for _, event in ipairs(shared_state.config.update_events) do
      vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = nativeWinbar.update_winbar
      })
    end

    -- Comandos personalizados
    vim.api.nvim_create_user_command("WinbarToggle", function()
      shared_state.config.enabled = not shared_state.config.enabled
      nativeWinbar.update_winbar()
      vim.notify("Winbar " .. (shared_state.config.enabled and "enabled" or "disabled"))
    end, {})

    vim.api.nvim_create_user_command("WinbarRefresh", function()
      nativeWinbar.update_winbar()
      vim.notify("Winbar refreshed")
    end, {})

    nativeWinbar.update_winbar()
  end
end

return M
