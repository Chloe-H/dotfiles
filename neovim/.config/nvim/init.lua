local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- to get Vim help for vim-plug
Plug 'junegunn/vim-plug'

-- Niceties
Plug 'tpope/vim-surround'

-- Git
Plug 'tpope/vim-fugitive'

-- Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

-- Search
Plug('junegunn/fzf', {
    ['do'] = function()
        vim.call('fzf#install')
    end
})
Plug 'junegunn/fzf.vim'

-- Color schemes
Plug 'folke/tokyonight.nvim'

vim.call('plug#end')


-- Native settings

vim.g.mapleader = ','

-- Show line numbers
vim.o.number = true

vim.o.relativenumber = true
vim.o.colorcolumn = '80,100,120'

-- Use unix line endings
vim.o.fileformat = 'unix'

-- Disable the mouse in all modes
vim.opt.mouse = ''

vim.cmd [[colorscheme tokyonight]]


-- Plugin settings

-- Plugin settings: NERDTree
vim.api.nvim_set_keymap(
    'n',
    '<Leader>n',
    ':NERDTreeToggle<CR>',
    {}
)
