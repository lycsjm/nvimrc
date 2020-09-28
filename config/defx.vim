function! DefxContextMenu() abort
    call utils#echo_succes_msg("Defx context menu\n")
    let l:msg =  "=========================================================\n".
                \ "  (a)dd a childnode\n".
                \ "  (A)dd multiple childnodes\n".
                \ "  (d)elete the current node\n".
                \ "  (m)ove the current node\n".
                \ "  (r)eveal in Finder the current node\n"

    echo l:msg
    let l:ans = nr2char(getchar())
    let l:actions = {
                \ 'a':{'op':'call', 'args':['DefxNewNode']},
                \ 'A': {'op':'call',   'args':['DefxNewMultiNode']},
                \ 'd':{'op':'remove',  'args':[]},
                \ 'm':{'op':'rename',  'args':[]},
                \ 'r':{'op': 'call',   'args':['DefxOpenFinder']}
                \ }
    if !(has_key(l:actions, l:ans))
        silent exe 'redraw'
        return
    endif
    echo "=========================================================\n"
    let l:action = get(l:actions, l:ans)
    call defx#call_action(action.op, action.args)
endfunction

function! DefxNewNode(context) abort
    echo "Enter the dir/file name to be created. Dirs end with a '/'\n"
    call defx#call_action('new_file')
endfunction

function! DefxNewMultiNode(context) abort
    echo "Enter the dir/file name seperated by space. Dirs end with a '/'\n"
    call defx#call_action('new_multiple_files')
endfunction

function! DefxOpenFinder(context) abort
    if has('mac')
        let l:open = 'open'
    elseif has('unix')
        let l:open = 'xdg-open'
    endif

    for path in a:context.targets
        if defx#is_directory()
            let l:full_path = fnamemodify(path, ':p')
        else
            let l:full_path = fnamemodify(path, ':p:h')
        endif
        let l:open_folder = printf("%s '%s'", l:open, l:full_path)
        echo l:open_folder
        call system(l:open_folder)
    endfor
endfunction

