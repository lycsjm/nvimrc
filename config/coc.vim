" coc keymapping {{{
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:go_to_definition()
    silent let ret = CocAction('jumpDefinition')
    if ret
        return v:true
    endif
    let ret = execute('silent! tag ' . expand('<cword>'))
    if ret =~ 'Error'
        " Like gD
        call searchdecl(expand('<cword>'))
    endif
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute('help '. expand('<cword>'))
    else
        call CocAction('doHover')
    endif
endfunction

function! s:format()
    silent let ret = CocAction('format')
    if ret
        return v:true
    endif
    if !dein#tap('vim-autoformat')
        return
    endif
    execute('silent Autoformat')
endfunction

function! s:coc_keymapping() abort
    let g:coc_snippet_next = '<tab>'
    let g:coc_snippet_prev = '<s-tab>'
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<Down>" :
          \ coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    noremap <silent> <F3> :call <SID>format()<CR>
    nmap <silent> gd :call <SID>go_to_definition()<CR>
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    autocmd CursorHold * silent call CocActionAsync('highlight')

    echom "coc key_mapping"
endfunction
" }}}

" coc config {{{
function! s:coc_config() abort
    call coc#config('coc.source.around.shortcut',  'A')
    call coc#config('coc.source.buffer.shortcut',  'B')
    call coc#config('coc.source.file.shortcut',  'F')
    call coc#config('suggest', 
                \ {'autoTrigger': 'none',
                \  'noselect': v:false,
                \  'disableMenu': v:false,
                \  'disableKind': v:true,
                \  'completionItemKindLabels': {
                \ "keyword": "\uf1de",
                \ "variable": "\ue79b",
                \ "value": "\uf89f",
                \ "operator": "\u03a8",
                \ "function": "\u0192",
                \ "reference": "\ufa46",
                \ "constant": "\uf8fe",
                \ "method": "\uf09a",
                \ "struct": "\ufb44",
                \ "class": "\uf0e8",
                \ "interface": "\uf417",
                \ "text": "\ue612",
                \ "enum": "\uf435",
                \ "enumMember": "\uf02b",
                \ "module": "\uf40d",
                \ "color": "\ue22b",
                \ "property": "\ue624",
                \ "field": "\uf9be",
                \ "unit": "\uf475",
                \ "event": "\ufacd",
                \ "file": "\uf723",
                \ "folder": "\uf114",
                \ "snippet": "\ue60b",
                \ "typeParameter": "\uf728",
                \ "default": "\uf29c" }
                \})
endfunction
" }}}

" coc lsp {{{
function! s:coc_lsp_golang() abort
    call coc#config('go.goplsOptions', {'usePlaceholders': v:true})
endfunction

function! s:coc_lsp_python() abort
    call coc#config('python', {
                \ 'venvPath': '~/.pyenv',
                \ 'jediEnabled': v:false
                \ })
endfunction

function! s:coc_lsp() abort
    call s:coc_lsp_golang()
    call s:coc_lsp_python()
endfunction

" }}}

call s:coc_lsp()
call s:coc_config()
call s:coc_keymapping()
echom 'coc setting'

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts=4 sta nowrap et :
