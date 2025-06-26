local M = {}

function M.setup()
  vim.cmd([[
    " This avoid an issue where, when we confirm a suggestion selection
    " this action breaks the completion, and add weird new lines after the
    " change (unnecessarily)
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " =========== COC keys definition ===========
    " These need to be here since are overrided by other plugins
    " Make possible scroll into the suggestion menu using CTRL+J/K
    " JUST INSERT MODE
    inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
    inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
    
    " Make possible show the suggestion menu just pressing CTRL+Spacekey
    imap <silent><expr> <C-Space> coc#refresh()
    " Add `:Format` command to format current buffer
    command! -nargs=0 Format :call CocActionAsync('format')
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)
    " Add `:OR` command for organize imports of the current buffer
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
    " Highlight the symbol and its references when holding the cursor
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Add background highlighting for cursor holding
    highlight CocHighlightText guibg=#4F4451 ctermbg=239 " Gris oscuro

    " Set the vim global library to lua diagnostics
    if !exists('g:lua_coc_library_configured')
      augroup LuaCocLibrary
        autocmd!
        autocmd FileType lua call s:SetLuaLibrary()
      augroup END
    endif

    function! s:SetLuaLibrary() abort
      let g:lua_coc_library_configured = 1
      call coc#config('Lua.workspace.library', nvim_get_runtime_file('', 1))
    endfunction

    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction
]])
end

return M
