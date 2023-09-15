local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('junegunn/vim-plug') -- Added to get Vim help for vim-plug

-- Niceties
Plug('tpope/vim-fugitive')
Plug('tpope/vim-surround') -- Plugin to easily add, change, and remove surrounding character pairs
Plug('tpope/vim-commentary') -- Plugin to comment/un-comment with keybinds
Plug('foosoft/vim-argwrap') -- Plugin to quickly expand/collapse lists of things (e.g. function arg lists)
Plug('jiangmiao/auto-pairs') -- Pretty old plugin for inserting or deleting brackets, parentheses, and quotes in pairs
Plug('milkypostman/vim-togglelist') -- Very old plugin for toggling location list and quickfix list with keybinds
Plug('nvim-lualine/lualine.nvim')

--[[
    (copied straight from the README)
    If you don't have nodejs and yarn
    use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
    see: https://github.com/iamcco/markdown-preview.nvim/issues/50
--]]
Plug('iamcco/markdown-preview.nvim', {
    ['do'] = vim.fn['mkdp#util#install'],
    ['for'] = { 'markdown', 'vim-plug' },
})

-- Navigation
Plug('ctrlpvim/ctrlp.vim')
Plug('scrooloose/nerdtree')

-- Search
Plug('junegunn/fzf', { -- Bare bones (n)vim integration for fzf, defaults to using fzf binary in $PATH, if available
    ['do'] = vim.fn['fzf#install'], -- (Optional) Post-update hook to get latest version of fzf binary
})
Plug('junegunn/fzf.vim') -- Provides native (n)vim commands that leverage fzf
-- TODO: Trying out, may replace fzf/fzf.vim + CtrlP
Plug('nvim-lua/plenary.nvim') -- Dependency for telescope.nvim
Plug('nvim-telescope/telescope.nvim', { -- Highly extensible fuzzy finder
    branch = '0.1.x',
})
Plug('nvim-telescope/telescope-fzf-native.nvim', { -- Recommended native telescope sorter (whatever that means); improves sort performance
    ['do'] = 'make'
})

-- Session management
Plug('rmagatti/auto-session')
Plug('rmagatti/session-lens') -- auto-session extension, adds fzf-enhanced session switching

-- IDE-like stuff
Plug('majutsushi/tagbar', {
    on = { 'TagbarToggle', 'TagbarOpen' }
})

-- LSP stuff
Plug('neovim/nvim-lspconfig') -- LSP configurations for neovim's built in LSP client/framework
Plug('VonHeikemen/lsp-zero.nvim', { -- Bridge between nvim-cmp and nvim-lspconfig
    branch = 'v3.x', -- TODO: Only necessary until v3.x becomes default (soon(TM), Sep 2023)
})
Plug('hrsh7th/nvim-cmp') -- Auto-completion engine
Plug('hrsh7th/cmp-nvim-lsp') -- nvim-cmp source for neovim's built-in LSP client
Plug('williamboman/mason.nvim') -- External editor tooling management from within neovim
Plug('williamboman/mason-lspconfig.nvim') -- Bridge from mason.nvim to nvim-lspconfig + some niceties
Plug('L3MON4D3/LuaSnip') -- Snippets engine (snippets sold separately)

-- Color schemes
Plug('folke/tokyonight.nvim')

vim.call('plug#end')


-- Native settings

vim.g.mapleader = ' '

vim.opt.termguicolors = true -- TODO: Do I need this?
vim.cmd.colorscheme('tokyonight')

vim.opt.mouse = '' -- Disable the mouse in all modes

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.number = true -- Show line numbers

vim.opt.relativenumber = true
vim.opt.colorcolumn = '80,100,120'

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use unix line endings by default on Windows
if jit.os == 'Windows' then
    vim.opt.fileformats = 'unix,dos'
end

-- Add angle brackets to matched character pairs
vim.opt.matchpairs:append('<:>')

-- Tabs, spaces, indentation
vim.opt.expandtab = true -- Use spaces to insert <Tab>
vim.opt.tabstop = 4 -- Number of spaces a <Tab> in the file counts for
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent

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

-- Window borders, for readability

-- TODO: Do I even need this anymore?
-- Add a border around `Lsp...` windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

--[[
    Add borders to floating windows for all LSP clients.

    Source: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
--]]
local lsp_orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts)
  opts = opts or {}
  opts.border = opts.border or 'rounded'

  return lsp_orig_util_open_floating_preview(contents, syntax, opts)
end
-- end TODO: Do I even need this anymore?


-- Plugin settings: lsp-zero.nvim
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig() -- Must call before setting up a language server or setting up mason-lspconfig
lsp_zero.on_attach(function(client, bufnr)
    --[[
        Buffer local mappings
        See `:help vim.lsp.*` for documentation on the functions below
    --]]
    local bufopts = {
        buffer = bufnr,
        remap = false,
    }

    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<Leader>sd', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<Leader>sh', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<Leader>fu', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', '<Leader>ed', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, bufopts)
end)


-- Plugin settings: nvim-cmp
local nvim_cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

nvim_cmp.setup({
    mapping = nvim_cmp.mapping.preset.insert({
        -- <Enter> to confirm completion
        ['<CR>'] = nvim_cmp.mapping.confirm({select = false}),

        -- Ctrl + x, Ctrl + o to trigger completion menu
        ['<C-x><C-o>'] = nvim_cmp.mapping.complete(),

        -- Navigate between snippet placeholders
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll through the completion documentation
        ['<C-d>'] = nvim_cmp.mapping.scroll_docs(4),
        ['<C-u>'] = nvim_cmp.mapping.scroll_docs(-4),
    }),
})


-- Plugin settings: mason.nvim, mason-lspconfig.nvim
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function ()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})
