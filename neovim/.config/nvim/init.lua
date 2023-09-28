local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('junegunn/vim-plug') -- Added to get Vim help for vim-plug

-- Niceties
Plug('tpope/vim-fugitive')
Plug('mbbill/undotree') -- Undo history tree visualizer
Plug('folke/todo-comments.nvim') -- Plugin to highlight and search for TODOs and other TODO-type comments
Plug('tpope/vim-surround') -- Plugin to easily add, change, and remove surrounding character pairs
Plug('tpope/vim-commentary') -- Plugin to comment/un-comment with keybinds
Plug('foosoft/vim-argwrap') -- Plugin to quickly expand/collapse lists of things (e.g. function arg lists)
Plug('windwp/nvim-autopairs') -- Autopairs plugin (insert/delete brackets, parentheses, quotes in pairs)
Plug('windwp/nvim-ts-autotag') -- Auto-pairing and renaming of HTML tags (achieved by leveraging treesitter)
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
Plug('nvim-lua/plenary.nvim') -- Dependency for telescope.nvim / common library
Plug('nvim-telescope/telescope.nvim', { -- Highly extensible fuzzy finder
    branch = '0.1.x',
})
Plug('nvim-telescope/telescope-fzf-native.nvim', { -- Recommended native telescope sorter (whatever that means); improves sort performance
    ['do'] = 'make'
})

-- Session management
Plug('rmagatti/auto-session')
Plug('rmagatti/session-lens') -- Auto-session extension, adds fzf-enhanced session switching

-- IDE-like stuff
Plug('lewis6991/gitsigns.nvim') -- Plugin for git decorations, chunk navigation, etc.
Plug('majutsushi/tagbar', { -- File tag browser; depends on universal-ctags
    on = { 'TagbarToggle', 'TagbarOpen' }
})
Plug('nvim-treesitter/nvim-treesitter', { -- Plugin for tree-sitter functionality (e.g. better syntax highlighting based on tree-sitter's concrete syntax tree; https://github.com/tree-sitter/tree-sitter)
    ['do'] = ':TSUpdate' -- will fail on fresh install, should work fine on updates (https://github.com/nvim-treesitter/nvim-treesitter/issues/1989)
})
Plug('nvim-treesitter/nvim-treesitter-context') -- Plugin for sticky headers (using tree-sitter's syntax trees)

-- LSP stuff
Plug('folke/neodev.nvim') -- Plugin for automatic configuration of lua-language-server for init.lua development (doesn't impact non-nvim config lua development!)
Plug('neovim/nvim-lspconfig') -- LSP configurations for neovim's built in LSP client/framework
Plug('VonHeikemen/lsp-zero.nvim') -- Bridge between nvim-cmp and nvim-lspconfig
Plug('hrsh7th/nvim-cmp') -- Auto-completion engine
Plug('hrsh7th/cmp-nvim-lsp') -- nvim-cmp source for neovim's built-in LSP client
Plug('saadparwaiz1/cmp_luasnip') -- nvim-cmp source for LuaSnip
Plug('williamboman/mason.nvim') -- External editor tooling management from within neovim
Plug('williamboman/mason-lspconfig.nvim') -- Bridge from mason.nvim to nvim-lspconfig + some niceties
Plug('L3MON4D3/LuaSnip') -- Snippets engine (snippets sold separately)
Plug('rafamadriz/friendly-snippets') -- Collection of snippets for various languages

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


-- Plugin settings: vim-fugitive
vim.keymap.set(
    'n',
    '<Leader>gflv',
    '<cmd>vertical Git --paginate log<CR>',
    { remap = false }
)


-- Plugin settings: undotree
vim.keymap.set(
    'n',
    '<Leader>ut',
    '<cmd>UndotreeToggle<CR>',
    { remap = false }
)


-- Plugin settings: todo-comments.nvim
-- TODO: why isn't it finding TODOs in init.lua?
require('todo-comments').setup()


-- Plugin settings: vim-argwrap
vim.keymap.set(
    'n',
    '<Leader>a',
    '<cmd>ArgWrap<CR>',
    { remap = false }
)


-- Plugin settings: nvim-autopairs
local npairs = require('nvim-autopairs')
local npairs_rule = require('nvim-autopairs.rule')
local npairs_conditions = require('nvim-autopairs.conds')

npairs.setup()

--[[
    Add custom rules to auto-pair <bracket><Space> (i.e. to automatically add
    a space before the automatically paired closing character when one is
    added after the opening character that triggered the auto-pair)
    Source: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
--]]
local npairs_brackets = {
    { '(', ')' },
    { '[', ']' },
    { '{', '}' },
}
npairs.add_rules({
    -- Rule for a pair with left-side ' ' and right side ' '
    npairs_rule(' ', ' ')
        -- Pair will only occur if the conditional function returns true
        :with_pair(function(opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains(
                {
                    npairs_brackets[1][1] .. npairs_brackets[1][2],
                    npairs_brackets[2][1] .. npairs_brackets[2][2],
                    npairs_brackets[3][1] .. npairs_brackets[3][2],
                },
                pair
            )
        end)
        :with_move(npairs_conditions.none())
        :with_cr(npairs_conditions.none())
        -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains(
                {
                    npairs_brackets[1][1] .. '  ' .. npairs_brackets[1][2],
                    npairs_brackets[2][1] .. '  ' .. npairs_brackets[2][2],
                    npairs_brackets[3][1] .. '  ' .. npairs_brackets[3][2]
                },
                context
            )
        end)
})
-- For each pair of brackets we will add another rule
for _, bracket in pairs(npairs_brackets) do
    npairs.add_rules({
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        npairs_rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(npairs_conditions.none())
            :with_move(function(opts) return opts.char == bracket[2] end)
            :with_del(npairs_conditions.none())
            :use_key(bracket[2])
            -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
    })
end


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
telescope.load_extension('todo-comments') -- Undocumented, but makes todo-comments show up in telescope's builtins list right away, rather than after running a todo-comments command

vim.keymap.set(
    'n',
    '<Leader>ts<Space>',
    ':Telescope<Space>',
    { remap = false }
)


-- Plugin settings: auto-session
require('auto-session').setup()


-- Plugin settings: gitsigns.nvim
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = package.loaded.gitsigns

        local function gitsigns_map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Hunk navigation (falls back to default behavior for diff-mode)
        gitsigns_map(
            'n',
            ']c',
            function()
                if vim.wo.diff then
                    return ']c'
                end

                vim.schedule(
                    function()
                        gitsigns.next_hunk()
                    end
                )

                return '<Ignore>'
            end,
            { expr = true }
        )

        gitsigns_map(
            'n',
            '[c',
            function()
                if vim.wo.diff then
                    return '[c'
                end

                vim.schedule(
                    function()
                        gitsigns.prev_hunk()
                    end
                )

                return '<Ignore>'
            end,
            { expr = true }
        )
    end
})


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


-- Plugin settings: nvim-treesitter, nvim-ts-autotag
require('nvim-treesitter.configs').setup({
    -- Parsers to install by default
    ensure_installed = {
        'c',
        'javascript',
        'lua',
        'query',
        'typescript',
        'vim',
        'vimdoc',
    },

    --[[
        Automatically install missing parsers when entering buffer
        Recommendation: disable if you don't have tree-sitter CLI installed locally
    -- ]]
    auto_install = false,

    -- Plugin settings: nvim-ts-autotag
    -- Configure automatic closing and renaming of tags by nvim-ts-autotag
    -- It's unclear to me how tightly nvim-ts-autotag is coupled with nvim-treesitter
    autotag = {
        enable = true,
    },

    highlight = {
        enable = true,
    },

    -- Warning: Experimental (at time of writing)
    indent = {
        enable = true,

        --[[
            Disable for languages where it doesn't work well
            Source: https://www.reddit.com/r/neovim/comments/svywql/comment/hxr0xjl/?context=3
        --]]
        disable = {
            'c',
            'python',
        },
    },
})

-- Tree-sitter-based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false -- Set all folds to be open by default


-- Plugin settings: nvim-treesitter-context
local treesitter_context = require('treesitter-context')

treesitter_context.setup({
    max_lines = 3,
    trim_scope = 'inner',
})

-- TODO: remove keymap, try folke/flash?
vim.keymap.set(
    'n',
    '<Leader>tsc',
    function()
        treesitter_context.go_to_context()
    end,
    { remap = false }
)


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


-- Plugin settings: LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()


-- Plugin settings: nvim-cmp
lsp_zero.extend_cmp()
local nvim_cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

nvim_cmp.setup({
    mapping = nvim_cmp.mapping.preset.insert({
        -- Navigate between snippet placeholders
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        --[[
            Completion menu visible -> navigate to next/prev item in list
            Cursor on snippet trigger -> expand snippet
            Snippet placeholder reachable -> navigate to next/prev placeholder
            Cursor in word that doesn't trigger snippet -> display completion menu
            Otherwise, use the fallback (i.e. the key's default behavior)
        --]]
        ['<C-n>'] = cmp_action.luasnip_supertab(),
        ['<C-p>'] = cmp_action.luasnip_shift_supertab(),

        -- Scroll through the completion documentation
        ['<C-d>'] = nvim_cmp.mapping.scroll_docs(4),
        ['<C-u>'] = nvim_cmp.mapping.scroll_docs(-4),
    }),
    sources = nvim_cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})


-- Plugin settings: neodev.nvim
-- Must set up neodev /before/ nvim-lspconfig
require('neodev').setup()


-- Plugin settings: nvim-lspconfig
-- Has to come after mason, mason-lspconfig, and lsp-zero setup
local lspconfig = require('lspconfig')

-- Add a border around `Lsp...` windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

lspconfig.html.setup({
    filetypes = { 'html', 'htmldjango', },
})
