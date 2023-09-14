local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- to get Vim help for vim-plug
Plug('junegunn/vim-plug')

-- Niceties
Plug('tpope/vim-fugitive')
Plug('tpope/vim-surround')
Plug('tpope/vim-commentary')
Plug('foosoft/vim-argwrap')
Plug('jiangmiao/auto-pairs')
Plug('milkypostman/vim-togglelist')
Plug('nvim-lualine/lualine.nvim')

-- If you don't have nodejs and yarn
-- use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
-- see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug('iamcco/markdown-preview.nvim', {
    ['do'] = vim.fn['mkdp#util#install'],
    ['for'] = { 'markdown', 'vim-plug' },
})

-- Navigation
Plug('ctrlpvim/ctrlp.vim')
Plug('scrooloose/nerdtree')

-- Search
Plug('junegunn/fzf', {
    ['do'] = vim.fn['fzf#install'],
})
Plug('junegunn/fzf.vim')
-- Trying out, may replace fzf/fzf.vim + CtrlP (TODO)
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {
    branch = '0.1.x',
})
Plug('nvim-telescope/telescope-fzf-native.nvim', {
    ['do'] = 'make'
})

-- Session management
Plug('rmagatti/auto-session')
Plug('rmagatti/session-lens')

-- IDE-like stuff
Plug('majutsushi/tagbar', {
    on = { 'TagbarToggle', 'TagbarOpen' }
})

-- LSP stuff
Plug('neovim/nvim-lspconfig')

-- Color schemes
Plug('folke/tokyonight.nvim')

vim.call('plug#end')


-- Native settings

vim.g.mapleader = ' '

vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

-- Disable the mouse in all modes
vim.opt.mouse = ''

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Show line numbers
vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.colorcolumn = '80,100,120'

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use unix line endings
if jit.os == 'Windows' then
    vim.opt.fileformats = 'unix'
end

-- Add angle brackets to matched character pairs
vim.opt.matchpairs:append('<:>')

-- Tabs, spaces, indentation

-- Use spaces to insert <Tab>
vim.opt.expandtab = true
-- Number of spaces a <Tab> in the file counts for
vim.opt.tabstop = 4
-- Number of spaces a <Tab> counts for while performing editing operations
vim.opt.softtabstop = 4
-- Number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4

-- QuickFix list / Location list mappings (pair nicely with vim-togglelist)
vim.keymap.set('n', ']l', '<cmd>lnext<CR>', { remap = false })
vim.keymap.set('n', '[l', '<cmd>lprevious<CR>', { remap = false })

vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { remap = false })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>', { remap = false })

-- Tab mappings
vim.keymap.set('n', '<Leader>th', '<cmd>tabfirst<CR>', { remap = false })
vim.keymap.set('n', '<Leader>tl', '<cmd>tablast<CR>', { remap = false })
vim.keymap.set('n', '<Leader>tt', ':tabedit<Space>', { remap = false })
vim.keymap.set('n', '<Leader>gt', ':tabnext<Space>', { remap = false })
vim.keymap.set('n', '<Leader>tm', ':tabmove<Space>', { remap = false })
vim.keymap.set('n', '<Leader>td', '<cmd>tabclose<CR>', { remap = false })
vim.keymap.set('n', '<Leader>wt', '<cmd>tab split<CR>', { remap = false })

-- Search mappings
vim.keymap.set('n', '<Leader>/w', '/\\<<C-R>/\\><CR>', { remap = false })

-- Custom function for stripping trailing white space
strip_trailing_white_space = function()
    local cursor_pos = vim.fn.getpos('.')
    local current_query = vim.fn.getreg('/')

    vim.cmd([[ %s/\s\+$//e ]])

    vim.fn.setpos('.', cursor_pos)
    vim.fn.setreg('/', current_query)
end

vim.keymap.set(
    'n',
    '<Leader>ss',
    strip_trailing_white_space,
    { remap = false }
)

-- Disable virtual text for diagnostics
vim.diagnostic.config ({
    virtual_text = false,
    signs = true,
    underline = true,
})


-- Plugin settings

-- Plugin settings: vim-fugitive
vim.keymap.set(
    'n',
    '<Leader>gflv',
    '<cmd>vertical Git --paginate log<CR>',
    { remap = false }
)

-- Plugin settings: vim-argwrap
vim.keymap.set(
    'n',
    '<Leader>a',
    '<cmd>ArgWrap<CR>',
    { remap = false }
)


-- Plugin settings: lualine.nvim
-- Handy symbols: 
require('lualine').setup({
    options = {
        disabled_filetypes = {
            'ctrlp',
            'nerdtree',
            'fugitive',
        },
        globalstatus = true,
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 2,
                use_mode_colors = true,
                max_length = vim.o.columns,
            },
        },
        lualine_z = { require('auto-session.lib').current_session_name },
    },
    inactive_winbar = {
        lualine_a = {
            {
                'filename',
                path = 3,
            }
        },
        lualine_y = {
	        'vim.api.nvim_win_get_number(0)',
        },
    },
})


-- Plugin settings: CtrlP
vim.g.ctrlp_match_current_file = 1

if jit.os == 'Windows' then
    vim.g.ctrlp_user_command = 'dir %s /-n /b /s /a-d'
end


-- Plugin settings: NERDTree
-- Workaround for glyphs not displaying correctly in RHEL via MobaXterm
vim.g.NERDTreeDirArrowExpandable = '+'
vim.g.NERDTreeDirArrowCollapsible = '~'

vim.keymap.set(
    'n',
    '<Leader>n',
    '<cmd>NERDTreeToggle<CR>',
    { remap = false }
)

vim.keymap.set(
    'n',
    '<Leader>fn',
    '<cmd>NERDTreeFind<CR>',
    { remap = false }
)


-- Plugin settings: fzf / fzf.vim
vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
    ['ctrl-q'] = 'fill_quickfix',
}


-- Plugin settings: telescope.nvim
local telescope = require('telescope')
telescope.setup({
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('session-lens')

vim.keymap.set(
    'n',
    '<Leader>ts<Space>',
    ':Telescope<Space>',
    { remap = false }
)


-- Plugin settings: auto-session
require('auto-session').setup()


-- Plugin settings: tagbar
vim.g.tagbar_left = 1

vim.keymap.set(
    'n',
    '<Leader>tb',
    '<cmd>TagbarToggle<CR>',
    { remap = false }
)
vim.keymap.set(
    'n',
    '<Leader>ftb',
    '<cmd>TagbarOpen fj<CR>',
    { remap = false }
)
