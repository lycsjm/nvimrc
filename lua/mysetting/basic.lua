vim.g.python_host_prog = vim.fn.systemlist('pyenv which python2')[1]
vim.g.python3_host_prog = vim.fn.systemlist('pyenv which python3')[1]

vim.env.NVIMRC = vim.fn.fnamemodify(vim.fn.expand('<sfile>'), ':h')
vim.env.CACHE = vim.fn.expand('$HOME/.cache')



vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'


vim.o.history = 500

-- Set to auto read when a file is changed from the outside
vim.o.autoread = true

-- Switch buffer without casuing error when file is edited
vim.o.hidden = true

vim.o.report = 0

vim.cmd [[inoremap jk <esc>]]
vim.cmd [[tnoremap <esc> <C-\><C-n>]]
vim.cmd [[command! W w !sudo tee % > /dev/null]]

vim.g.mapleader = ','

vim.o.path = vim.o.path .. [[**]]

vim.o.diffopt = [[filler,vertical,algorithm:patience,context:3,foldcolumn:0]]

--Remember cursor position between vim sessions
vim.cmd [[
    autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
]]


-- center buffer around cursor when opening files
vim.cmd [[autocmd BufRead * normal zz]]

vim.o.grepprg = [[grep -inH]]

vim.cmd [[nnoremap <Left> <Nop>]]
vim.cmd [[nnoremap <Right> <Nop>]]
vim.cmd [[nnoremap <Up> <Nop>]]
vim.cmd [[nnoremap <Down> <Nop>]]

vim.cmd [[nnoremap j gj]]
vim.cmd [[nnoremap k gk]]

vim.o.updatetime = 500

-- Don't yank to default register when changing something
vim.cmd [[xnoremap c "xc]]
vim.cmd [[nnoremap c "xc]]

-- After block yank and paste, move cursor to the end of operated text and don't override register
vim.cmd [[vnoremap y y`]]
vim.cmd [[vnoremap p "_dP`]]
vim.cmd [[nnoremap p p`]]


-- Cursor always in vertical center on the screen
vim.o.scrolloff = 999

-- Height of the command bar
vim.o.cmdheight = 2


-- show command
vim.o.showcmd = true
vim.o.showmode = true


-- Ignore case when searching
vim.o.ignorecase = true


-- When searching try to be smart about cases
vim.o.smartcase = true


-- Configure backspace so it acts as it should act
vim.o.backspace = [[indent,eol,start]]
vim.o.whichwrap = [[b,s,<,>,h,l]]
vim.o.wrap = true

-- show special character
vim.wo.list = true
vim.o.listchars = [[eol:¬,tab:▸\ ,trail:.]]

-- search as characters are entered
vim.o.incsearch = true
-- highlight matches
vim.o.hlsearch = true

vim.o.inccommand=[[split]]

-- mark before search
vim.cmd [[nnoremap / ms/]]

-- Show matching brackets when text indicator is over them
vim.o.showmatch = true
vim.o.matchtime = 1

-- highlight current line
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
vim.wo.colorcolumn = [[81]]

-- Use a popup menu to show the possible completions
vim.o.completeopt = [[menuone,noinsert,noselect]]

vim.o.virtualedit = [[block]]

vim.cmd [[autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif]]



-- Set popup menu max height.
vim.o.pumheight = 10

-- Enables pseudo-transparency for the popup-menu
vim.o.pumblend = 20

-- Enable syntax highlighting
vim.cmd [[syntax on]]

-- syntax enable
vim.o.t_Co = [[256]]
vim.o.termguicolors = true

-- Set utf8 as standard enconding
vim.o.encoding = [[utf-8]]

-- Use Unix as the standard file type
vim.o.fileformats = [[unix,dos,mac]]

-- Turn backup off, since most stuff is in SVN, git et.c anyway...
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.undofile = true
vim.o.undodir= vim.env.HOME .. "/.config/nvim/undo"


-- Visual shifting (does not exit Visual mode)
vim.cmd [[noremap < <gv]]
vim.cmd [[vnoremap > >gv]]

-- Smart way to move between windows
vim.cmd [[noremap <C-j> <C-W>j]]
vim.cmd [[noremap <C-k> <C-W>k]]
vim.cmd [[noremap <C-h> <C-W>h]]
vim.cmd [[noremap <C-l> <C-W>l]]


-- Close current tab
vim.cmd [[nnoremap <silent><leader>qt <cmd>tabclose<cr>]]


-- Move between buffer
-- Use tpope/vim-unimpaired replace below
-- noremap ]b <cmd>bnext<cr>
-- noremap [b <cmd>bprevious<cr>

-- Managing tabs
vim.cmd [[nnoremap <leader>t <cmd>tabnew<cr>]]
-- gt => <cmd>tabnext<cr>
-- gT => <cmd>tabprevious<cr>

-- Close all the buffers
vim.cmd [[nnoremap <leader>ba <cmd>bufdo bd<cr>]]

-- Opens a new tab with the current buffer's path
vim.cmd [[nnoremap <leader>te <cmd>tabedit <c-r>=expand("%:p:h")<cr>]]


vim.cmd [[nnoremap <silent><expr> q winnr('$') != 1 ? ':<C-u>close<CR>' : ""]]


vim.cmd [[autocmd CursorHold *? syntax sync minlines=300]]

-- Not use relative number, if not in the window
vim.wo.number = true
vim.cmd [[autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif]]
vim.cmd [[autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif]]

vim.cmd [[autocmd FileType qf wincmd J]]
vim.cmd [[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)]]

vim.cmd [[nnoremap <silent><F12> <cmd>call vimrc#show_function_key()<cr>]]


-- command line mode work like shell
vim.cmd [[cnoremap <C-a> <Home>]]
vim.cmd [[cnoremap <C-e> <End>]]
vim.cmd [[cnoremap <C-p> <Up>]]
vim.cmd [[cnoremap <C-n> <Down>]]
vim.cmd [[cnoremap <C-b> <Left>]]
vim.cmd [[cnoremap <C-f> <Right>]]
vim.cmd [[cnoremap <M-b> <S-Left>]]
vim.cmd [[cnoremap <M-f> <S-Right>]]

-- Puts new vsplit windows to the right of the current
vim.o.splitright = true
-- Puts new split windows to the bottom of the current
vim.o.splitbelow = true


-- Display candidates in command-line by popup menu.
vim.o.wildmenu = false
vim.o.wildmode = "full"
vim.o.wildoptions = "pum,tagfile"


 -- Enables pseudo-transparency for a floating window
vim.o.winblend = 20
 -- Set minimal width for current window.
-- vim.o.winwidth = 30
 -- Set minimal height for current window.
-- vim.o.winheight = 20
 -- Set maximam maximam command line window.
vim.o.cmdwinheight =5
 -- No equal window size.
vim.o.equalalways = true


 -- Don't redraw while executing macros (good performance config)
vim.o.lazyredraw = true

 -- Adjust window size of preview and help.
vim.o.previewheight = 5
vim.o.helpheight = 12

vim.o.shortmess = vim.o.shortmess .. 'c'

 -- Add a bit extra margin to the left
vim.o.foldcolumn = "1"

 -- Confiugre white space
vim.o.shiftwidth = 4 -- indent width
vim.o.tabstop = 4    -- tab width
vim.o.softtabstop = 4
vim.o.expandtab = true -- space replace tab
vim.o.smarttab= true -- Be smart when using tab

vim.o.autoindent = true
vim.o.smartindent = true

-- Maximum width of text that is being inserted (TODO)
-- set textwidth=80
-- set breakindent
-- set formatoptions=

