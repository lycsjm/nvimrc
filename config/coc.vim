let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-dictionary',
            \ 'coc-go',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-lua',
            \ 'coc-python',
            \ 'coc-neosnippet',
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-word',
            \ 'coc-xml',
            \ 'coc-yaml'
            \ ]

" coc keymapping {{{
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:coc_keymapping() abort
    imap <silent><expr> <TAB>
                \ pumvisible() ? "\<Down>" :
                \ (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" :
                \ (<SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()))

    smap <silent><expr> <TAB>
                \ pumvisible() ? "\<Down>" :
                \ (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" :
                \ (<SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()))

    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endfunction
" }}}


call s:coc_keymapping()

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts=4 sta nowrap et :
