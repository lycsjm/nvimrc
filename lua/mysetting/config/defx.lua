local fn = vim.fn

local mapper = function(mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

local M = {}
M.keymapping = function()
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

    mapper('n', '<Space>', [[defx#do_action('toggle_select')]],
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

    mapper('n', 'm', [[<cmd>lua require('mysetting.config.defx').menu()<cr>]],
    {noremap = true})
end

local reveal = function()
    local open_cmd
    if fn.has('mac') then
        open_cmd = 'open'
    elseif fn.has('unix') then
        open_cmd = 'xdg_open'
    else
        return
    end

    target = fn['defx#get_candidate']()
    local full_path = fn['fnamemodify'](target.word, ':p') -- is directory
    if not target.is_directory then
        full_path = fn['fnamemodify'](target.word, ':p:h') -- is file
    end

    if full_path == nil then
        return
    end
    os.execute(open_cmd .. ' ' .. full_path)
end

M.menu = function()
    local msg = "=========================================================\n"..
                "  (a)dd a childnode\n" ..
                "  (A)dd multiple childnodes\n" ..
                "  (d)elete the current node\n" ..
                "  (m)ove the current node\n" ..
                "  (r)eveal in Finder the current node\n"

    vim.cmd [[call utils#echo_succes_msg("Defx context menu\n")]]
    print(msg)

    local action = fn.nr2char(fn.getchar())

    local action_map = {
        a = {op = 'new_file',
            pre_hook = function()
                print( "Enter the dir/file name to be created. Dirs end with a '/'\n")
            end,
            post_hook = function() end},
        A = {op = 'new_multiple_files',
            pre_hook = function()
                print("Enter the dir/file name seperated by space. Dirs end with a '/'\n")
            end,
            post_hook = function() end},
        d = {op = 'remove', pre_hook = function() end, post_hook = function() end},
        m = {op = 'rename', pre_hook = function() end, post_hook = function() end},
        r = {op = 'reveal', do_thing = reveal}
    }

    local target = action_map[action]
    if target == nil then
        return 
    elseif target.op == 'reveal' then
        target.do_thing()
        return
    end
    target.pre_hook()
    fn['defx#call_action'](target.op)
    target.post_hook()
end

M.setting = function()
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

return M

