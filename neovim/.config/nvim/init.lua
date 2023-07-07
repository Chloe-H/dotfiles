local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug 'junegunn/vim-plug' -- to get Vim help for vim-plug

-- Niceties
Plug 'tpope/vim-surround'

-- Git
Plug 'tpope/vim-fugitive'

-- TODO: jiangmiao/auto-pairs?

-- Color schemes
Plug 'folke/tokyonight.nvim'
vim.call('plug#end')

-- Show line numbers
vim.o.number = true

vim.o.relativenumber = true
vim.o.colorcolumn = '80,100,120'

-- Use unix line endings
vim.o.fileformat = 'unix'

-- Disable the mouse in all modes
vim.opt.mouse = ''

vim.cmd [[colorscheme tokyonight]]
