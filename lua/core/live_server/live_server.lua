---@type integer? the current active job
local live_server_term = nil
local M = {}

function M.get_command()
  local current_file = vim.api.nvim_buf_get_name(0)
  local dir_path = vim.fn.expand('%:p:h')
  local file_name = vim.fn.expand('%:t')

  local command = string.format(
    "npx live-server %s --open=%s --wait=500",
    vim.fn.shellescape(dir_path),
    vim.fn.shellescape("/" .. file_name)
  )

  if not current_file:match("%.html$") then
    command = string.format("npx live-server")
  end

  return command
end

function M.force_update()
  if live_server_term ~= nil then
    vim.api.nvim_chan_send(live_server_term, "\r")
  end
end

function M.end_live_server()
  if live_server_term ~= nil then
    vim.fn.jobstop(live_server_term)
  end
end

function M.toggle_live_server()
  if live_server_term ~= nil then
    M.end_live_server()
  else
    M.start_live_server(M.get_command(), false)
  end
end

---@param command string?
---@param close_if_active boolean
function M.start_live_server(command, close_if_active)
  if not command or command == nil then
    command = M.get_command()
  end
  if live_server_term ~= nil and close_if_active then
    M.end_live_server()
  end
  live_server_term = vim.fn.jobstart(command, {
    on_exit = function()
      if live_server_term ~= nil then
        vim.schedule(function()
          print("[Live-server] id:" .. live_server_term .. " => ended")
          live_server_term = nil
        end)
      end
    end,
  })
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.html", "*.htmlx", "*.jsx", "*.tsx" },
    callback = function()
      if live_server_term ~= nil then
        M.force_update()
      end
    end
  })
end

vim.api.nvim_create_user_command("LiveServerToggle", M.toggle_live_server, {})
vim.api.nvim_create_user_command("LiveServerStart", function()
  M.start_live_server(nil, true)
end, {})
vim.api.nvim_create_user_command("LiveServerClose", M.end_live_server, {})
vim.api.nvim_create_user_command("LiveServerUpdate", M.force_update, {})

return M
