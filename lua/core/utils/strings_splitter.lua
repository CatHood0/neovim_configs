---Split a string by the delimiter <string.find>
---
---@param str string
---@param delimiter string
---@return table delimiter
function _G.splitString(str, delimiter)
  local result_table = {}
  for part in string.gmatch(str, "([^" .. delimiter .. "]+)") do
    table.insert(result_table, part)
  end
  return result_table
end
