local fn = vim.fn

local mapper = function(mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end



local keymapping = function()
    mapper('n', '<CR>',
        [[defx#is_directory()?]]..
        [[defx#do_action('open_or_close_tree'):]]..
        [[defx#do_action('drop')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'o',
        [[defx#is_opened_tree()?]]..
        [[defx#do_action('close_tree'):]]..
        [[defx#do_action('open_tree')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'O',
        [[defx#is_opened_tree()?]]..
        [[defx#do_action('close_tree'):]]..
        [[defx#async_action('open_tree_recursive')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'R', [[defx#do_action('redraw')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', '>',
        [[defx#is_directory()?]]..
        [[defx#do_action('open'):]]..
        [['<Nop>']],
        {noremap = true, expr = true, silent = true})

    mapper('n', '<', [[defx#do_action('cd', ['..'])]],
        {noremap = true, expr = true, silent = true})

    mapper('n', '~', [[defx#do_action('cd', [getcwd()])]],
        {noremap = true, expr = true, silent = true})


    mapper('n', 'cd',
        [[:call defx#call_action('open') <bar>]]..
        [[:call defx#call_action('change_vim_cwd')<bar>]]..
        [[:call utils#echo_succes_msg("Defx: CWD is now: ".getcwd())<cr>]],
        {noremap = true})


    mapper('n', 'I', [[defx#do_action('toggle_ignored_files')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', '<Space>', [[defx#do_action('toggle_select')]] .. 'j',
        {noremap = true, expr = true, silent = true})

    mapper('n', '<Esc>', [[defx#do_action('clear_select_all')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'j', [[line('.') == line('$') ? 'gg' : 'j']],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'k', [[line('.') == 1 ? 'G' : 'k']],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'p', [[defx#do_action('paste')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'dd', [[defx#do_action('move')]],
        {noremap = true, expr = true, silent = true})

    mapper('n', 'yy', [[defx#do_action('copy')]],
        {noremap = true, expr = true, silent = true})


    mapper('n', 'q', [[defx#do_action('quit')]],
        {noremap = true, expr = true, silent = true})


    mapper('n', '!', [[defx#do_action('execute_command')]],
        {noremap = true, expr = true, silent = true})
end

local setting = function()
    fn['defx#custom#column']('icon', {
            directory_icon = '▸',
            opened_icon =  '▾',
            root_icon = '📁 '
        })

    fn['defx#custom#column']('mark', {
            readonly_icon = '✗',
            selected_icon = '✓',
        })


    fn['defx#custom#column']('filename', {
            min_width = 128,
            max_width = 128,
        })

    fn['defx#custom#option']('_', {
            columns = 'git:mark:indent:icon:filename:type',
            split = 'vertical',
            winwidth = 35,
            direction = 'topleft',
            resume = false,
            toggle = true
        })
end

keymapping()
setting()


