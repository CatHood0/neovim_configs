local M = {}
local SymbolKind = vim.lsp.protocol.SymbolKind

function M.setup()
  require 'lsp-lens'.setup({
    enable = true,
    include_declaration = false, -- Reference include declaration
    sections = {                -- Enable / Disable specific request, formatter example looks 'Format Requests'
      definition = function(count)
        if count <= 1 then
          return ""
        end
        return "Definitions: " .. count
      end,
      references = function(count)
        return "References: " .. count
      end,
      implements = function(count)
        if count < 1 then
          return ""
        end
        return "Implementations: " .. count
      end,
      git_authors = function(latest_author, count)
        if count < 1 then
          return ""
        end
        return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
      end,
    },
    { LspLens = { link = "Comment" } },
    ignore_filetype = {
      -- "prisma",
    },
    -- Target Symbol Kinds to show lens information
    target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
    -- Symbol Kinds that may have target symbol kinds as children
    wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
  })
end

return M
