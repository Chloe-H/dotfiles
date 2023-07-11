local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- to get Vim help for vim-plug
Plug 'junegunn/vim-plug'

-- Niceties
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'

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

-- Disable the mouse in all modes
vim.opt.mouse = ''

vim.cmd 'colorscheme tokyonight'

-- Show line numbers
vim.o.number = true

vim.o.relativenumber = true
vim.o.colorcolumn = '80,100,120'

-- Use unix line endings
vim.o.fileformat = 'unix'

-- Tabs, spaces, indentation

-- Use spaces to insert <Tab>
vim.o.expandtab = true
-- Number of spaces a <Tab> in the file counts for
vim.o.tabstop = 4
-- Number of spaces a <Tab> counts for while performing editing operations
vim.o.softtabstop = 4
-- Number of spaces to use for each step of (auto)indent
vim.o.shiftwidth = 4



-- Plugin settings

-- Plugin settings: NERDTree
vim.api.nvim_set_keymap(
    'n',
    '<Leader>n',
    ':NERDTreeToggle<CR>',
    {}
)


-- Plugin settings: lspconfig

--[[
    LSP settings: OmniSharp-Roslyn
    lang(s): C#
    Source(s):
      - https://aaronbos.dev/posts/csharp-dotnet-neovim
      - https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611
--]]

local pid = vim.fn.getpid()

local omnisharp_bin = 'C:\\OmniSharp\\omnisharp-win-x64\\OmniSharp.exe'

require'lspconfig'.omnisharp.setup {
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <C-x><C-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Buffer local mappings
        -- See `:help vim.lsp.*` for documentation on the functions below
        local bufopts = { buffer = bufnr }

        vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<Leader>sd', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<Leader>sh', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<Leader>fu', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
    end
}
