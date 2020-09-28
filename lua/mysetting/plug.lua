vim.cmd [[packadd packer.nvim]]
vim._update_package_paths()

return require('packer').startup(function()
    use {'wbthomason/packer.nvim'}

    use {'luochen1990/rainbow', setup = function()
        vim.g.rainbow_active = 1
    end}
    use {'itchyny/vim-cursorword'}

    use {'Yggdroot/indentLine', setup = function()
        vim.g.indentLine_fileTypeExclude = {'nerdtree', 'diff', 'tagbar', 'help', 'defx'}
    end}

    -- Lazy loading:
    -- Load on specific commands
    use {'morhetz/gruvbox', opt = true, event = 'VimEnter *', setup = function()
        vim.g.gruvbox_termcolors = 256
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_vert_split = "bg0"
        vim.o.background = "dark"
        vim.cmd [[colorscheme gruvbox]]
    end}

    -- vim text object
    use {'kana/vim-textobj-user'}
    use {'glts/vim-textobj-comment'}
    use {'sgur/vim-textobj-parameter'}


    -- vim operator
    use {'kana/vim-operator-user'}
    use {'kana/vim-operator-replace'}

    use {'ntpeters/vim-better-whitespace', cmd = {'ToggleWhitespace', 'StripWhitespace', 'EnableWhitespace'},
    config = function()
        vim.g.better_whitespace_ctermcolor='3'
        vim.g.better_whitespace_guicolor = '#c8e6c9'
        vim.g.better_whitespace_filetypes_blacklist = {'nerdtree', 'help', 'qf', 'diff'}
        vim.cmd [[nnoremap <silent><expr><F5> exists("g:better_whitespace_enabled") ? ':ToggleWhitespace<cr>' : ':EnableWhitespace<cr>']]
        vim.cmd [[nnoremap <F17> <cmd>StripWhitespace<cr>]]
    end}

    use {'junegunn/vim-easy-align', cmd = 'EasyAlign'}

    use {'ronakg/quickr-cscope.vim', setup = function()
        vim.g.quickr_cscope_keymaps = 0
        vim.cmd [[nmap <C-s>s <Plug>(quickr_cscope_symbols)]]
        vim.cmd [[nmap <C-s>g <Plug>(quickr_cscope_global)]]
        vim.cmd [[nmap <C-s>c <Plug>(quickr_cscope_callers)]]
        vim.cmd [[nmap <C-s>f <Plug>(quickr_cscope_files)]]
        vim.cmd [[nmap <C-s>i <Plug>(quickr_cscope_includes)]]
        vim.cmd [[nmap <C-s>t <Plug>(quickr_cscope_text)]]
        vim.cmd [[nmap <C-s>e <Plug>(quickr_cscope_egrep)]]
        vim.cmd [[nmap <C-s>d <Plug>(quickr_cscope_functions)]]
    end}

    use {'preservim/tagbar', cmd = 'TagbarToggle', setup = function()
        vim.g.tagbar_ctags_bin = vim.fn.systemlist('which ctags')[1]
        vim.cmd [[noremap <F8> <cmd>TagbarToggle<cr>]]
        vim.g.tagbar_sort = 0
        vim.g.tagbar_type_go = {
            ctagstype = 'go',
            kind = {
                'p:package',
                'i:imports:1',
                'c:constants',
                'v:variables',
                't:types',
                'n:interfaces',
                'w:fields',
                'e:embedded',
                'm:methods',
                'r:constructor',
                'f:functions'
            },
            sro = '.',
            kind2scope = {
                t = 'ctype',
                n = 'ntype'
            },
            scope2kind = {
                ctype = 't',
                ntype = 'n'
            },
            ctagsbin = 'gotags',
            ctagsargs = '-sort -silent'
        }
    end}

    use {'justinmk/vim-sneak', setup = function()
        vim.g['sneak#label'] = 1
        vim.cmd [[map f <Plug>Sneak_s]]
        vim.cmd [[map F <Plug>Sneak_S]]
    end}

    use {'dense-analysis/ale', setup = function()
        vim.g.ale_completion_enabled = 0
        vim.g.ale_fix_on_save = 0
        vim.g.ale_linters = {
            javascript = {'eslint'},
        }
        vim.g.ale_fixers = {
            javascript = {'eslint'},
        }
        vim.g.ale_set_quickfix = 1
        vim.g.ale_lint_on_insert_leave = 1
    end}

    use {'nvim-treesitter/nvim-treesitter', config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = "all",
            highlight = {
                enable = true
            },
            incremental_selection = {
                enable = false,
            },
            refactor = {
                highlight_definitions = { enable = true },
                highlight_current_scope = { enable = false },
                smart_rename = { enable = false },
                navigation = { enable = false }
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ic"] = "@class.inner"
                    }
                },
                swap = { enable = false },
                move = { enable = false }
            }
        }
    end}

    use{'andymass/vim-matchup', setup = function()
        vim.g.matchup_matchparen_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_offscreen = {method = 'popup'}
        vim.g.matchup_transmute_enabled = 1
        vim.g.matchup_matchpref = {html =  { tagnameonly = 1}}
    end}

    use{'tpope/vim-endwise', setup = function()
        vim.g.endwise_no_mappings = 1
    end}

    use{'tpope/vim-commentary'}

    use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    use {'tpope/vim-unimpaired'}

    use {'tpope/vim-fugitive'}

    use {'junegunn/fzf', run = 'sh ./install' }
    use {'junegunn/fzf.vim', config = function()
        vim.cmd [[exe 'source' $NVIMRC.'/config/fzf.vim']]
    end}

    use {'vim-airline/vim-airline', setup = function()
        vim.g.airline_extensions = {'tabline', 'quickfix', 'branch'}
        vim.g.airline_powerline_fonts = 1

        vim.g['airline#extensions#tabline#enable'] = 1

        -- show the airline_tab type is tab or buffer (top right)
        vim.g['airline#extensions#tabline#show_tab_type'] = 1

        --  close symbol (top right)
        vim.g['airline#extensions#tabline#close_symbol'] = 'X'

        -- enable displaying buffers with a single tab
        -- it mean airline_tab type is buffer
        vim.g['airline#extensions#tabline#show_buffers'] = 1
        -- Show the buffer order with a single tab
        -- convient to use <leader>n to switch buffer
        vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1

        -- if airline_tab type is tab
        -- convient to use <leader>n to switch tap
        vim.g['airline#extensions#tabline#tab_nr_type'] = 1

        -- disable show split information on top right
        vim.g['airline#extensions#tabline#show_splits'] = 0

        vim.cmd [[nmap <leader>1 <Plug>AirlineSelectTab1]]
        vim.cmd [[nmap <leader>2 <Plug>AirlineSelectTab2]]
        vim.cmd [[nmap <leader>3 <Plug>AirlineSelectTab3]]
        vim.cmd [[nmap <leader>4 <Plug>AirlineSelectTab4]]
        vim.cmd [[nmap <leader>5 <Plug>AirlineSelectTab5]]
        vim.cmd [[nmap <leader>6 <Plug>AirlineSelectTab6]]
        vim.cmd [[nmap <leader>7 <Plug>AirlineSelectTab7]]
        vim.cmd [[nmap <leader>8 <Plug>AirlineSelectTab8]]
        vim.cmd [[nmap <leader>9 <Plug>AirlineSelectTab9]]
    end}

    use {'mhinz/vim-sayonara', cmd = 'Sayonara', setup = function()
        vim.g.sayonara_filetypes = {
            nerdtree = 'NERDTreeClose',
            tagbar = TagbarClose,
            defx = [[call defx#call_action("quit")]]
        }
        vim.cmd [[nnoremap <silent> <leader>c <cmd>Sayonara!<CR>]]
        vim.cmd [[nnoremap <silent> <leader>q <cmd>Sayonara<CR>]]
    end}

    use {'Shougo/defx.nvim', cmd = 'Defx',
    setup = function()
        vim.cmd [[autocmd FileType defx lua require('mysetting.config.defx').keymapping()]]
        vim.cmd [[autocmd BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')]]
        vim.cmd [[noremap <silent><F4> <cmd>Defx -session-file='/tmp/defx_session' -buffer-name="defx"<CR>]]
        vim.cmd [[autocmd FileType defx lua require('mysetting.config.defx')]]
    end,
    config = function()
        require('mysetting.config.defx').setting()
    end}

    use {'Raimondi/delimitMate', event = 'InsertEnter *', setup = function()
        vim.g.delimitMate_expand_space = 1
        vim.g.delimitMate_smart_quotes = 1
        vim.g.delimitMate_nesting_quotes = {[["]], [[']]}
    end}

    use {'haya14busa/vim-asterisk'}
    use {'haya14busa/is.vim', setup = function()
        vim.g['asterisk#keeppos'] = 1
        vim.cmd [[map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)]]
        vim.cmd [[map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)]]
        vim.cmd [[map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)]]
        vim.cmd [[map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)]]

    end}

    use {'Chiel92/vim-autoformat', cmd = 'Autoformat', setup = function()
        vim.cmd [[noremap <F3> <cmd>Autoformat<cr>]]
        vim.g.formatters_python = {'autopep8'}
        vim.g.formatters_rust = {'rustfmt'}
    end}

    use {'mbbill/undotree', cmd = 'UndotreeToggle', setup = function()
        vim.cmd [[nnoremap <F6> <cmd>UndotreeToggle<cr>]]
    end}

    use {'junegunn/goyo.vim', cmd = 'Goyo'}
    use {'junegunn/limelight.vim', cmd = 'Limelight'}

    use {'thinca/vim-qfreplace', cmd = 'Qfreplace'}

    use {'mhinz/vim-signify', setup = function()
        vim.cmd [[exe 'source' $NVIMRC.'/config/signify.vim']]
    end}

    use {'fatih/vim-go', ft = 'go', run = ':GoUpdateBinaries', setup = function()
        vim.g.go_def_mapping_enabled = 0
        vim.cmd [[autocmd Filetype go nmap <buffer> gd <Plug>(go-def)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> gD <Plug>(go-describe)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> gR <Plug>(go-rename)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> gr <Plug>(go-referrers)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> <leader>gm <Plug>(go-metalinter)]]

        vim.g.go_metalinter_command = "golangci-lint"
        vim.g.go_metalinter_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
        vim.g.go_metalinter_autosave_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
        vim.g.go_metalinter_autosave = 0
        vim.g.go_jump_to_error = 0

        vim.g.o_echo_go_info = 0
        vim.g.go_auto_type_info = 1
        vim.g.go_fmt_command = "goimports"
        vim.g.go_fmt_autosave = 1
        vim.g.go_guru_scope = {[[...]]}

        vim.cmd [[autocmd Filetype go nmap <buffer> <f16> <Plug>(go-test)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> <f17> <Plug>(go-build)]]
        vim.cmd [[autocmd Filetype go nmap <buffer> <f18> <Plug>(go-run)]]
    end}


    use {'pangloss/vim-javascript', ft = 'javascript'}
    use {'othree/yajs.vim', ft = 'javascript'}
    use {'HerringtonDarkholme/yats.vim', ft = 'typescript'}
    use {'mhartington/nvim-typescript',ft = 'typescript', run = 'sh ./install.sh',
    setup = function()
        vim.g['nvim_typescript#server_path'] = 'tsserver'
        vim.g['nvim_typescript#javascript_support'] = 1
        vim.g['nvim_typescript#type_info_on_hold'] = 1
    end}

    use {'rust-lang/rust.vim', ft = 'rust', setup = function()
        vim.env.RUST_SRC_PATH = vim.fn.systemlist('rustc --print sysroot')[1] ..
        [[/lib/rustlib/src/rust/src]]
    end}

    use{'racer-rust/vim-racer', ft = 'rust', setup = function()
        vim.g.racer_cmd = vim.fn.systemlist('which racer')[1]
        vim.g.racer_experimental_completer = 1
        vim.cmd [[autocmd FileType rust nmap gd <Plug>(rust-def)]]
        vim.cmd [[autocmd FileType rust nmap gs <Plug>(rust-def-split)]]
        vim.cmd [[autocmd FileType rust nmap gx <Plug>(rust-def-vertical)]]
        vim.cmd [[autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)]]
    end}

    use {'nvim-lua/diagnostic-nvim', setup = function()
        vim.g.diagnostic_show_sign = 1
        vim.g.diagnostic_enable_virtual_text = 1
        vim.g.diagnostic_insert_delay = 1
        vim.g.diagnostic_virtual_text_prefix = '<'
        vim.cmd [[nnoremap <leader>d <cmd>OpenDiagnostic<cr>]]
        vim.cmd [[nnoremap [d <cmd>PrevDiagnostic<cr>]]
        vim.cmd [[nnoremap ]d <cmd>NextDiagnostic<cr>]]
        vim.fn.sign_define("LspDiagnosticsErrorSign", {text = "E", texthl = "GruvboxRedSign"})
        vim.fn.sign_define("LspDiagnosticsWarningSign", {text = "W", texthl = "GruvboxOrangeSign"})
        vim.fn.sign_define("LspDiagnosticsInformationSign", {text = "I", texthl = "GruvboxGreeSign"})
        vim.fn.sign_define("LspDiagnosticsHintSign", {text = "H", texthl = "GruvboxGreeSign"})

    end}

    use {'tjdevries/nlua.nvim'}
    use {'nvim-lua/lsp-status.nvim'}
    use {'neovim/nvim-lspconfig', config = function()
        local lsp_status = require('lsp-status')
        lsp_status.register_progress()

        vim.cmd [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.cmd [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

        local lsp_keymap = function()
            local mapper = function(mode, key, result)
                vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
            end
            mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
            mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
            mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
            mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
            mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
            mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
            mapper('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
            mapper('i', '<c-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        end

        local on_attach = function(client)
            require'completion'.on_attach()
            require'diagnostic'.on_attach()
            lsp_status.on_attach(client)
        end

        local on_attach_vim_js = function(client)
            require'completion'.on_attach()
            lsp_status.on_attach(client)
            vim.fn['ale#toggle#Enable']()
            lsp_keymap()
        end


        local nvim_lsp = require'nvim_lsp'
        nvim_lsp.cssls.setup{
            on_attach=on_attach
        }


        nvim_lsp.html.setup{
            on_attach=on_attach
        }

        nvim_lsp.gopls.setup{
            init_options= { usePlaceholders = true },
            on_attach=on_attach
        }

        nvim_lsp.clangd.setup{
            cmd = {"/usr/local/opt/llvm/bin/clangd", "--background-index"},
            on_attach=on_attach,
            capabilities = {
                textDocument = {
                    completion = {
                        editsNearCursor = true,
                        completionItem = {
                            snippetSupport = true
                        }
                    }
                }
            },
        }

        nvim_lsp.tsserver.setup{
            on_attach=on_attach_vim_js
        }

        vim.cmd [[exe 'source' $NVIMRC.'/config/completion_nvim.vim']]
    end}

    use {'nvim-lua/completion-nvim', event = 'InsertEnter *', setup = function()
        vim.g.completion_auto_change_source = 1
        vim.g.completion_enable_auto_popup = 0
        vim.g.completion_enable_auto_signature = 1
        vim.g.completion_timer_cycle = 200
        vim.g.completion_matching_strategy_list = {'exact'}
        vim.g.completion_enable_snippet = 'vim-vsnip'
        vim.g.completion_chain_complete_list = {
            {complete_items = {'lsp', 'snippet'}},
            {complete_items = {'buffers'}},
        }
    end}
    use {'steelsojka/completion-buffers', event = 'InsertEnter *'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ', setup = function()
        vim.g.vsnip_snippet_dir = vim.env.NVIMRC .. '/vsnippets'
    end}

end)
