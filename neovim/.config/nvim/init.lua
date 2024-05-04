local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('junegunn/vim-plug') -- Added to get Vim help for vim-plug

-- Niceties
Plug('tpope/vim-fugitive')
Plug('mbbill/undotree')             -- Undo history tree visualizer
Plug('folke/todo-comments.nvim')    -- Plugin to highlight and search for TODOs and other TODO-type comments
Plug('tpope/vim-surround')          -- Plugin to easily add, change, and remove surrounding character pairs
Plug('tpope/vim-commentary')        -- Plugin to comment/un-comment with key binds
Plug('foosoft/vim-argwrap')         -- Plugin to quickly expand/collapse lists of things (e.g. function arg lists)
Plug('windwp/nvim-autopairs')       -- Autopairs plugin (insert/delete brackets, parentheses, quotes in pairs)
Plug('windwp/nvim-ts-autotag')      -- Auto-pairing and renaming of HTML tags (achieved by leveraging treesitter)
Plug('milkypostman/vim-togglelist') -- Very old plugin for toggling location list and quickfix list with key binds
Plug('nvim-lualine/lualine.nvim')

Plug(
    --[[
        (copied straight from the README)
        If you don't have nodejs and yarn
        use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
        see: https://github.com/iamcco/markdown-preview.nvim/issues/50
    --]]
    'iamcco/markdown-preview.nvim',
    {
        ['do'] = vim.fn['mkdp#util#install'],
        ['for'] = { 'markdown', 'vim-plug' },
    }
)

-- Navigation
Plug('scrooloose/nerdtree')

-- Search
Plug( -- Bare bones (n)vim integration for fzf, defaults to using fzf binary in $PATH, if available
    'junegunn/fzf',
    -- (Optional) Post-update hook to get latest version of fzf binary
    { ['do'] = vim.fn['fzf#install'], }
)
Plug('junegunn/fzf.vim')              -- Provides native (n)vim commands that leverage fzf
-- TODO: Trying out, may replace fzf/fzf.vim
Plug('nvim-lua/plenary.nvim')         -- Dependency for telescope.nvim / common library
Plug('nvim-telescope/telescope.nvim') -- Highly extensible fuzzy finder
Plug(                                 -- Recommended native telescope sorter (whatever that means); improves sort performance
    'nvim-telescope/telescope-fzf-native.nvim',
    { ['do'] = 'make' }
)

-- Session management
Plug('rmagatti/auto-session')
Plug('rmagatti/session-lens') -- Auto-session extension, adds fzf-enhanced session switching

-- IDE-like stuff
Plug('lewis6991/gitsigns.nvim') -- Plugin for git decorations, chunk navigation, etc.
Plug(                           -- File tag browser; depends on universal-ctags
    'majutsushi/tagbar',
    { on = { 'TagbarToggle', 'TagbarOpen' } }
)
Plug(
--[[
        Plugin for tree-sitter functionality

        (e.g. better syntax highlighting based on tree-sitter's concrete syntax
        tree; https://github.com/tree-sitter/tree-sitter)

        `:TSUpdate` will fail on fresh install, but should work fine on updates.
        Source: https://github.com/nvim-treesitter/nvim-treesitter/issues/1989
    --]]
    'nvim-treesitter/nvim-treesitter',
    { ['do'] = ':TSUpdate' }
)
Plug('nvim-treesitter/nvim-treesitter-context')     -- Plugin for sticky headers (using tree-sitter's syntax trees)
Plug('nvim-treesitter/nvim-treesitter-textobjects') -- Plugin for treesitter-based node movement, selection, and some other stuff

-- LSP stuff
Plug('neovim/nvim-lspconfig')     -- LSP configurations for neovim's built in LSP client/framework
Plug('VonHeikemen/lsp-zero.nvim') -- Bridge between nvim-cmp and nvim-lspconfig
Plug('hrsh7th/nvim-cmp')          -- Auto-completion engine
Plug('hrsh7th/cmp-buffer')        -- nvim-cmp source for words in buffers
--[[
    Best I can piece together, nvim-cmp supports providing completions in command
    mode (I guess that means `:`, `/`, /and/ `?`), but it won't actually do it
    unless/until you install cmp-cmdline.

    Source: https://github.com/hrsh7th/nvim-cmp/pull/362#issuecomment-952568174
--]]
Plug('hrsh7th/cmp-cmdline')                 -- nvim-cmp source for vim/neovim's command line
Plug('hrsh7th/cmp-nvim-lsp')                -- nvim-cmp source for neovim's built-in LSP client
Plug('hrsh7th/cmp-nvim-lsp-signature-help') -- nvim-cmp source for showing function signatures with current parameter emphasized
Plug('hrsh7th/cmp-nvim-lua')                -- nvim-cmp source for neovim's Lua API
Plug('saadparwaiz1/cmp_luasnip')            -- nvim-cmp source for LuaSnip
Plug('tzachar/fuzzy.nvim')                  -- Dependency for cmp-fuzzy-buffer, cmp-fuzzy-path
Plug('tzachar/cmp-fuzzy-buffer')            -- nvim-cmp source for fuzzy searching current buffer
Plug('williamboman/mason.nvim')             -- External editor tooling management from within neovim
Plug('williamboman/mason-lspconfig.nvim')   -- Bridge from mason.nvim to nvim-lspconfig + some niceties
Plug('L3MON4D3/LuaSnip')                    -- Snippets engine (snippets sold separately)
Plug('rafamadriz/friendly-snippets')        -- Collection of snippets for various languages

-- Color schemes
Plug('folke/tokyonight.nvim')

vim.call('plug#end')


-- Native settings
local path_separator = jit.os == 'Windows' and '\\' or '/'

vim.g.mapleader = ' '

vim.opt.termguicolors = true -- TODO: Do I need this?
vim.cmd.colorscheme('tokyonight')

vim.opt.mouse = '' -- Disable the mouse in all modes

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.wrap = false  -- Disable line wrapping

vim.opt.number = true -- Show line numbers

vim.opt.colorcolumn = '80,100,120'

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use Unix line endings by default on Windows
if jit.os == 'Windows' then
    vim.opt.fileformats = 'unix,dos'
end

-- Add angle brackets to matched character pairs
vim.opt.matchpairs:append('<:>')

-- Tabs, spaces, indentation
vim.opt.expandtab = true -- Use spaces to insert <Tab>
vim.opt.tabstop = 4      -- Number of spaces a <Tab> in the file counts for
vim.opt.softtabstop = 4  -- Number of spaces a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent

-- Spelling settings
local custom_spellfiles = {}
local custom_spellfiles_dir = string.format(
    '%s%s%s%s',
    vim.fn.stdpath('config'),
    path_separator,
    'spell',
    path_separator
)

if vim.fn.isdirectory(custom_spellfiles_dir) == 0 then
    if vim.fn.mkdir(custom_spellfiles_dir, 'p') == 0 then
        print(string.format(
            'Failed to create spellfiles directory "%s"',
            custom_spellfiles_dir
        ))
    else
        print(string.format(
            'Successfully created spellfiles directory "%s"',
            custom_spellfiles_dir
        ))
    end
end

for index, custom_spellfile in ipairs({
    'personal.en.utf-8',
    'work.en.utf-8',
}) do
    custom_spellfiles[index] = string.format(
        '%s%s.add',
        custom_spellfiles_dir,
        custom_spellfile
    )
end

vim.opt.spelllang = { 'en', 'en_us', }
vim.opt.spelloptions = { 'noplainbuffer', 'camel', }
vim.opt.spellfile = custom_spellfiles

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
local strip_trailing_white_space = function()
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
vim.diagnostic.config({
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
--[[
    Sections:
    +-------------------------------------------------+
    | A | B | C                             X | Y | Z |
    +-------------------------------------------------+

    lualine_<section> = { 'left', 'to', 'right' }

    Handy symbols: 
--]]
--
local get_pleasing_buffer_name = function(
    original_name,
    window_type,
    buffer_type,
    file_type,
    abs_path_to_file,
    context
)
    local pleasing_name = original_name

    if string.find(file_type, 'Telescope', 0, true) then
        pleasing_name = 'telescope'
    elseif file_type == 'fugitive'
        or file_type == 'nerdtree' then
        pleasing_name = file_type
    elseif window_type == 'autocmd' then
        -- TODO: When would I see this? How does it look?
        pleasing_name = original_name .. ' [autocommands]'
    elseif window_type == 'command' then
        pleasing_name = 'Command Line'
    elseif window_type == 'loclist' then
        pleasing_name = 'Location List'
    elseif window_type == 'quickfix' then
        pleasing_name = 'Quickfix List'
    elseif buffer_type == 'help' then
        pleasing_name = 'help:' .. vim.fn.fnamemodify(abs_path_to_file, ':t:r')
    elseif buffer_type == 'terminal' then
        local terminal_command = string.match(abs_path_to_file, 'term:.*:(.+)')

        pleasing_name = terminal_command ~= nil and terminal_command
            or vim.fn.fnamemodify(vim.env.SHELL, ':t')
    elseif vim.fn.isdirectory(abs_path_to_file) == 1 then
        pleasing_name = vim.fn.fnamemodify(abs_path_to_file, ':p:.')
    elseif window_type ~= '' then
        -- Should be popup or preview window
        pleasing_name = original_name ~= '[No Name]'
            and '[' .. window_type .. '] ' .. original_name
            or window_type
    end

    -- Don't show modified icon when we've got a fancy name
    context.modified_icon = pleasing_name == original_name
        and context.modified_icon
        or ''

    return pleasing_name
end

local use_pleasing_name_for_tab = function(name, context)
    local window_id = vim.fn.win_getid(vim.fn.tabpagewinnr(context.tabnr), context.tabnr)
    local active_buffer = vim.api.nvim_win_get_buf(window_id)

    local window_type = vim.fn.win_gettype(window_id)
    local buffer_type = vim.fn.getbufvar(active_buffer, '&bufype')
    local file_type = vim.fn.getbufvar(active_buffer, '&filetype')

    return get_pleasing_buffer_name(
        name,
        window_type,
        buffer_type,
        file_type,
        context.file,
        context
    )
end

local use_pleasing_name_for_window = function(name, context)
    local window_type = vim.fn.win_gettype()
    local buffer_type = vim.bo.buftype
    local file_type = vim.bo.filetype
    local abs_path_to_file = vim.fn.expand('%:p')

    return get_pleasing_buffer_name(
        name,
        window_type,
        buffer_type,
        file_type,
        abs_path_to_file,
        context
    )
end

local window_buffer_location = function(separator, reverse)
    separator = separator or ':'

    -- Default separator: ':'
    -- Normal: {buffer index}{separator}{window number}
    -- Reversed: {window number}{separator}{buffer index}
    return function()
        local window_number = vim.api.nvim_win_get_number(0)
        local buffer_index = vim.api.nvim_win_get_buf(0)

        return reverse and window_number .. separator .. buffer_index
            or buffer_index .. separator .. window_number
    end
end

require('lualine').setup({
    options = { globalstatus = true, },
    sections = {
        lualine_b = {'branch', 'vim.api.nvim_win_get_buf(0)'},
        lualine_c = {
            {
                'filename',
                --[[
                    When displaying the name of a new file, append the
                    "newfile" symbol if the first write of the new file hasn't
                    happened yet.
                --]]
                newfile_status = true,
                -- File name and parent dir, ~ for home dir
                path = 4,
                --[[
                    Shorten path to leave this many spaces in the window for
                    other components.
                --]]
                shorting_target = 120,
                fmt = use_pleasing_name_for_window,
            },
        },
        lualine_x = {'diagnostics'},
        lualine_y = {'fileformat', 'encoding', 'filetype'},
        lualine_z = {'vim.api.nvim_win_get_number(0)', 'location'},
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                -- Tab number and tab name
                mode = 2,
                -- Let the tabline be l o n g
                max_length = vim.o.columns,
                use_mode_colors = true,
                symbols = {
                    -- Text to show when the file is modified
                    modified = ' ●',
                },
                fmt = use_pleasing_name_for_tab,
            },
        },
        lualine_z = { require('auto-session.lib').current_session_name },
    },
    inactive_winbar = {
        lualine_a = {window_buffer_location(' ')},
        lualine_b = {
            {
                'filename',
                --[[
                    When displaying the name of a new file, append the
                    "newfile" symbol if the first write of the new file hasn't
                    happened yet.
                --]]
                newfile_status = true,
                -- File name and parent dir, ~ for home dir
                path = 4,
                color = 'lualine_c_normal',
                fmt = use_pleasing_name_for_window,
            },
        },
        lualine_x = {
            {
                'filename',
                -- Don't display file status (e.g. readonly, modified)
                file_status = false,
                -- Absolute path, ~ for home dir
                path = 3,
            },
        },
    },
})


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
local ts_actions = require('telescope.actions')
local ts_actions_layout = require('telescope.actions.layout')
local ts_mappings = {
    -- Send selected/all results to quickfix list and open it
    ['<C-q>'] = ts_actions.smart_send_to_qflist + ts_actions.open_qflist,
    -- Add selected/all results to quickfix list and open it
    ['<M-q>'] = ts_actions.smart_add_to_qflist + ts_actions.open_qflist,
    -- Toggle preview
    ['<M-p>'] = ts_actions_layout.toggle_preview,
    -- Cycle to next layout
    ['<M-n>'] = ts_actions_layout.cycle_layout_next,
}
telescope.setup({
    defaults = {
        cycle_layout_list = { 'horizontal', 'center', 'vertical' },
        layout_strategy = 'vertical',
        mappings = {
            i = ts_mappings,
            n = ts_mappings,
        },
        path_display = { 'filename_first' },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    -- Delete selected/all buffers
                    ['<M-d>'] = 'delete_buffer',
                },
                n = {
                    -- Delete selected/all buffers
                    ['<M-d>'] = 'delete_buffer',
                },
            },
            sort_mru = true,
        },
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


-- Plugin settings: nvim-treesitter, nvim-treesitter-textobjects, nvim-ts-autotag
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

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<Leader>tsis',
            node_incremental = 'tsn', -- Next increment
            node_decremental = 'tsp', -- Previous increment
        },
    },

    -- Warning: Experimental (at time of writing)
    indent = {
        enable = true,

        --[[
            Disable for languages where it doesn't work well
            Source: https://www.reddit.com/r/neovim/comments/svywql/comment/hxr0xjl/?context=3
        --]]
        disable = { 'c', },
    },

    -- Plugin settings: nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = { query = '@parameter.outer', desc = 'Select around function argument (outer)', },
                ['ia'] = { query = '@parameter.inner', desc = 'Select function argument (inner)', },
                ['af'] = { query = '@function.outer', desc = 'Select around function definition (outer)', },
                ['if'] = { query = '@function.inner', desc = 'Select function interior/body (inner)', },
                ['ac'] = { query = '@class.outer', desc = 'Select around class definition (outer)', },
                ['ic'] = { query = '@class.inner', desc = 'Select class interior/body (inner)', },
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']fo'] = { query = '@function.outer', desc = 'Go to start of next function (outer)', },
                [']fi'] = { query = '@function.inner', desc = 'Go to start of next function (inner)', },
                [']]c'] = { query = '@class.outer', desc = 'Go to start of next class (outer)', },
                [']]b'] = { query = '@block.outer', desc = 'Go to start of next block (outer)', },
            },
            goto_next_end = {
                [']]f'] = { query = '@function.outer', desc = 'Go to end of next function (outer)', },
            },
            goto_previous_start = {
                ['[fo'] = { query = '@function.outer', desc = 'Go to start of previous function (outer)', },
                ['[fi'] = { query = '@function.inner', desc = 'Go to start of previous function (inner)', },
                ['[[c'] = { query = '@class.outer', desc = 'Go to start of previous class (outer)', },
                ['[[b'] = { query = '@block.outer', desc = 'Go to start of previous block (outer)', },
            },
            goto_previous_end = {
                ['[[f'] = { query = '@function.outer', desc = 'Go to end of previous function (outer)', },
            },
        },
    },
})

local ts_utils = require('nvim-treesitter.ts_utils')

local goto_sibling_node = function(goto_next, goto_end)
    -- Get next or previous node
    local get_node = goto_next and ts_utils.get_next_node or ts_utils.get_previous_node

    return function()
        local current_node = ts_utils.get_node_at_cursor()

        ts_utils.goto_node(get_node(current_node, true, true), goto_end, false)
    end
end

vim.keymap.set(
    'n',
    ']n',
    goto_sibling_node(true, false),
    { desc = 'Go to start of next sibling node' }
)
vim.keymap.set(
    'n',
    ']]n',
    goto_sibling_node(true, true),
    { desc = 'Go to end of next sibling node' }
)
vim.keymap.set(
    'n',
    '[n',
    goto_sibling_node(false, false),
    { desc = 'Go to start of previous sibling node' }
)
vim.keymap.set(
    'n',
    '[[n',
    goto_sibling_node(false, true),
    { desc = 'Go to end of previous sibling node' }
)

-- Tree-sitter-based folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false -- Set all folds to be open by default


-- Plugin settings: nvim-treesitter-context
-- TODO: Replace with https://github.com/wellle/context.vim?
local treesitter_context = require('treesitter-context')

treesitter_context.setup({
    enable = false,
    max_lines = 2,
    min_window_height = 25,
    multiline_threshold = 1,
    separator = '-',
    trim_scope = 'inner',
})

-- TODO: remove keymap, try folke/flash?
vim.keymap.set(
    'n',
    '<Leader>tscg',
    treesitter_context.go_to_context,
    { remap = false }
)
vim.keymap.set(
    'n',
    '<Leader>tsct',
    '<cmd>TSContextToggle<CR>',
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
local lsp_zero_cmp_action = lsp_zero.cmp_action()

local get_small_visible_buffers = function()
    local bufs = {}

    -- Only get visible buffers <= 1 Megabyte in size
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_size_bytes = vim.api.nvim_buf_get_offset(
            buf,
            vim.api.nvim_buf_line_count(buf)
        )

        if buf_size_bytes <= 1024 * 1024 then
            bufs[vim.api.nvim_win_get_buf(win)] = true
        end
    end

    return vim.tbl_keys(bufs)
end

nvim_cmp.setup({
    completion = { keyword_length = 3 },
    mapping = nvim_cmp.mapping.preset.insert({
        -- Navigate between snippet placeholders
        ['<C-f>'] = lsp_zero_cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = lsp_zero_cmp_action.luasnip_jump_backward(),

        --[[
            Completion menu visible -> navigate to next/prev item in list
            Cursor on snippet trigger -> expand snippet
            Snippet placeholder reachable -> navigate to next/prev placeholder
            Cursor in word that doesn't trigger snippet -> display completion menu
            Otherwise, use the fallback (i.e. the key's default behavior)
        --]]
        ['<C-n>'] = lsp_zero_cmp_action.luasnip_supertab(),
        ['<C-p>'] = lsp_zero_cmp_action.luasnip_shift_supertab(),

        -- Scroll through the completion documentation
        ['<C-d>'] = nvim_cmp.mapping.scroll_docs(4),
        ['<C-u>'] = nvim_cmp.mapping.scroll_docs(-4),

        -- Trigger auto-completion on matches in visible buffers
        -- Mnemonic: "[s]tart [b]uffer completion"
        ['<C-s><C-b>'] = nvim_cmp.mapping.complete({
            config = {
                sources = {
                    {
                        name = 'fuzzy_buffer',
                        option = { get_bufnrs = get_small_visible_buffers, },
                    },
                    {
                        name = 'buffer',
                        option = { get_bufnrs = get_small_visible_buffers, },
                    },
                },
            },
        }),
    }),
    -- Do not pre-select any items
    preselect = nvim_cmp.PreselectMode.None,
    --[[
        The order of the sources dictates the order in which the grouped results
        appear in the completion list.
    --]]
    sources = nvim_cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
})

-- Command-line mappings
local command_mappings_override = {
    -- Don't override default behavior
    ['<C-z>'] = nvim_cmp.config.disable,
    ['<Tab>'] = nvim_cmp.config.disable,
    ['<S-Tab>'] = nvim_cmp.config.disable,

    ['<C-x><C-o>'] = nvim_cmp.mapping({
        c = function()
            if not nvim_cmp.visible() then
                --[[
                    Once completion is triggered, it will continue to occur
                    for that word. I don't know whether this is intentional,
                    and I have yet to find a way to, like...return to not
                    auto-completing once auto-completion has been triggered.
                --]]
                nvim_cmp.complete()
            end
        end
    }),
}

-- Use buffer source(s) for search commands
nvim_cmp.setup.cmdline({ '/', '?' }, {
    completion = { autocomplete = false, keyword_length = 3, },
    mapping = nvim_cmp.mapping.preset.cmdline(command_mappings_override),
    sources = nvim_cmp.config.sources({
        { name = 'fuzzy_buffer', option = { get_bufnrs = get_small_visible_buffers, }, },
        { name = 'buffer',       option = { get_bufnrs = get_small_visible_buffers, }, },
    }),
})

-- Add sources for command-line mode
nvim_cmp.setup.cmdline({ ':' }, {
    completion = { autocomplete = false, keyword_length = 3, },
    mapping = nvim_cmp.mapping.preset.cmdline(command_mappings_override),
    sources = nvim_cmp.config.sources({
        { name = 'cmdline' }, -- I'm still not totally sure what this does
    })
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


-- Plugin settings: nvim-lspconfig
-- Has to come after mason, mason-lspconfig, and lsp-zero setup
local lspconfig = require('lspconfig')

-- Add a border around `Lsp...` windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

lspconfig.html.setup({
    filetypes = { 'html', 'htmldjango', },
})
