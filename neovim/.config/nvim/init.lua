local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('junegunn/vim-plug') -- Added to get Vim help for vim-plug

-- Niceties
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')         -- GitHub support in vim-fugitive (GBrowse, omni-completion)
Plug('ariel-frischer/bmessages.nvim')
                                  -- Better neovim messages (`:messages`)
Plug('mbbill/undotree')           -- Undo history tree visualizer
Plug('brenoprata10/nvim-highlight-colors')
                                  -- Real-time color highlighting
Plug('folke/todo-comments.nvim')  -- Highlighting and search functions for todo comments
Plug('tpope/vim-surround')        -- Easily add, change, and remove surrounding character pairs
Plug('numtostr/comment.nvim')     -- (Un)comment with key binds
--[[
    Sets commentstring based on the cursor's location in the file.
    (so, e.g., if the cursor is in a JSX block in a JavaScript file, this plugin
    will ensure that comment.nvim uses the correct syntax when adding comments).
--]]
Plug(
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        --[[
            HACK: Pin version to avoid breaking changes described here:
            https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82

            TODO: Update to latest and fix all configurations once you have
            nvim ≥ 0.9.4 (search for "Plugin settings: nvim-ts-context-commentstring")
            SEO: "newer version of neovim"
        --]]
        commit = '6c30f3c8915d7b31c3decdfe6c7672432da1809d',
    }
)
Plug('foosoft/vim-argwrap')         -- Quickly expand/collapse lists of things (e.g. function arg lists)
Plug('windwp/nvim-autopairs')       -- Autopairs plugin (insert/delete brackets, parentheses, quotes in pairs)
Plug(                               -- Auto-pairing and renaming of HTML tags (achieved by leveraging treesitter)
    'windwp/nvim-ts-autotag',
    {
        --[[
            HACK: Pin version to avoid breaking changes
            TODO: Update to latest and fix configurations (as needed?) once you
            have nvim ≥ 0.9.4
            SEO: "newer version of neovim"

            HACK: Fix for auto-pairing in htmldjango files:

            in `nvim-ts-autotag/lua/nvim-ts-autotag/internal.lua`,
            remove 'htmldjango' from `HBS_TAG`

            Source: https://github.com/windwp/nvim-ts-autotag/issues/127#issuecomment-1670026211
        --]]
        commit = '531f48334c422222aebc888fd36e7d109cb354cd',
    }
)
Plug('milkypostman/vim-togglelist') -- Toggle location list and quickfix list with key binds (very old plugin)
Plug('nvim-lualine/lualine.nvim')

Plug(
    --[[
        INFO: (copied straight from the README) "If you don't have nodejs and
        yarn, use pre build, add 'vim-plug' to the filetype list so vim-plug can
        update this plugin"
        See: https://github.com/iamcco/markdown-preview.nvim/issues/50
    --]]
    'iamcco/markdown-preview.nvim',
    {
        ['do'] = vim.fn['mkdp#util#install'],
        ['for'] = { 'markdown', 'vim-plug' },
    }
)

-- File explorer(s)
Plug('scrooloose/nerdtree') -- Tried and true
Plug('stevearc/oil.nvim')   -- Edit your filesystem like it's a vim buffer

-- Search
Plug( -- Bare bones (n)vim integration for fzf, defaults to using fzf binary in $PATH, if available
    'junegunn/fzf',
    -- (Optional) Post-update hook to get latest version of fzf binary
    { ['do'] = vim.fn['fzf#install'], }
)
Plug('junegunn/fzf.vim')              -- Native (n)vim commands that leverage fzf
-- TODO: Trying out, may replace fzf/fzf.vim
Plug('nvim-lua/plenary.nvim')         -- Dependency for telescope.nvim / common library
Plug('nvim-telescope/telescope.nvim') -- Highly extensible fuzzy finder
Plug(                                 -- Recommended native telescope sorter (whatever that means); improves sort performance
    'nvim-telescope/telescope-fzf-native.nvim',
    { ['do'] = 'make' }
)
Plug('nvim-telescope/telescope-live-grep-args.nvim') -- Basically live_grep with rg flag support
Plug('nvim-telescope/telescope-symbols.nvim')        -- Adds a bunch of sources for the symbol picker
--[[
    Advanced git search extension for Telescope and fzf-lua; lets me search the
    bodies of git commit messages!!
--]]
Plug('aaronhallaert/advanced-git-search.nvim')

-- Session management
Plug('rmagatti/auto-session')

-- IDE-like stuff
Plug('lewis6991/gitsigns.nvim') -- Git decorations, chunk navigation, etc.
Plug(                           -- File tag browser; depends on universal-ctags
    'majutsushi/tagbar',
    { on = { 'TagbarToggle', 'TagbarOpen', 'TagbarOpenAutoClose' } }
)
Plug('davidmh/mdx.nvim')        -- "Good enough" MDX file syntax highlighting
Plug(
    --[[
        Add tree-sitter functionality

        (e.g. better syntax highlighting based on tree-sitter's concrete syntax
        tree; https://github.com/tree-sitter/tree-sitter)

        BUG: `:TSUpdate` will fail on fresh install (on Windows specifically, I
        believe), but should work fine on updates.
        Source: https://github.com/nvim-treesitter/nvim-treesitter/issues/1989
        Workaround: `:TSUpdate` in an elevated neovim/neovide instance (is this
        the best solution?)
    --]]
    'nvim-treesitter/nvim-treesitter',
    { ['do'] = ':TSUpdate' }
)
-- TODO: Try https://github.com/wellle/context.vim?
Plug('nvim-treesitter/nvim-treesitter-textobjects') -- Tree-sitter-based node movement, selection, and some other stuff

-- LSP stuff
Plug('neovim/nvim-lspconfig')     -- LSP configurations for neovim's built in LSP client/framework
--[[
    TODO: Remove lsp-zero

    The README says it's dead and the new docs walk through the same effective
    setup without the plugin: https://lsp-zero.netlify.app/docs/tutorial.html
--]]
Plug('VonHeikemen/lsp-zero.nvim') -- Bridge between nvim-cmp and nvim-lspconfig
Plug('j-hui/fidget.nvim')         -- Extensible UI for Neovim notifications and LSP progress messages (for LSPs using nvim's /$progress handler)
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
Plug('hrsh7th/cmp-nvim-lua')                -- nvim-cmp source for neovim's Lua API; TODO: remove?
-- TODO: Replace neodev in nvim >= 0.10 (SEO: "newer version of neovim")
Plug('folke/neodev.nvim')                   -- Full signature help, docs and completion for the nvim lua API
Plug('saadparwaiz1/cmp_luasnip')            -- nvim-cmp source for LuaSnip
Plug('tzachar/fuzzy.nvim')                  -- Dependency for cmp-fuzzy-buffer, cmp-fuzzy-path
Plug('tzachar/cmp-fuzzy-buffer')            -- nvim-cmp source for fuzzy searching current buffer
Plug('williamboman/mason.nvim')             -- External editor tooling management from within neovim
Plug('williamboman/mason-lspconfig.nvim')   -- Bridge from mason.nvim to nvim-lspconfig + some niceties
Plug('L3MON4D3/LuaSnip')                    -- Snippets engine (snippets sold separately)
Plug('rafamadriz/friendly-snippets')        -- Collection of snippets for various languages

-- Color schemes
Plug('folke/tokyonight.nvim')
Plug('xero/evangelion.nvim')

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

-- Add optional plugins
vim.cmd.packadd('cfilter') -- :Cfilter[!] /{pat}/, :Lfilter[!] /{pat}/

-- Add angle brackets to matched character pairs
vim.opt.matchpairs:append('<:>')

-- Tabs, spaces, indentation
vim.opt.expandtab = true -- Use spaces to insert <Tab>
--[[
    TODO: Finish space/tab/indent research
    In the meantime:
        `:bufdo if &filetype == 'typescript' || &filetype == 'typescriptreact' | setlocal shiftwidth=2 | endif`
vim.opt.tabstop = 4      -- Number of spaces a <Tab> in the file counts for
--]]
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
vim.keymap.set(
    'n',
    ']l',
    '<cmd>lnext<CR>',
    {
        remap = false,
        desc = 'Next location list item',
    }
)
vim.keymap.set(
    'n',
    '[l',
    '<cmd>lprevious<CR>',
    {
        remap = false,
        desc = 'Previous location list item',
    }
)

vim.keymap.set(
    'n',
    ']q',
    '<cmd>cnext<CR>',
    {
        remap = false,
        desc = 'Next quickfix item',
    }
)
vim.keymap.set(
    'n',
    '[q',
    '<cmd>cprevious<CR>',
    {
        remap = false,
        desc = 'Previous quickfix item',
    }
)

-- Tab mappings
vim.keymap.set(
    'n',
    '<Leader>th',
    '<cmd>tabfirst<CR>',
    {
        remap = false,
        desc = 'Go to the first tab (mnemonic: tab head)',
    }
)
vim.keymap.set(
    'n',
    '<Leader>tl',
    '<cmd>tablast<CR>',
    {
        remap = false,
        desc = 'Go to the last tab',
    }
)
vim.keymap.set(
    'n',
    '<Leader>tt',
    ':tabedit<Space>',
    {
        remap = false,
        desc = 'Put "tabedit " in the command prompt',
    }
)
vim.keymap.set(
    'n',
    '<Leader>gt',
    ':tabnext<Space>',
    {
        remap = false,
        desc = 'Put "tabnext " in the command prompt (mnemonic: Go to Tab <#>)',
    }
)
vim.keymap.set(
    'n',
    '<Leader>tm',
    ':tabmove<Space>',
    {
        remap = false,
        desc = 'Put "tabmove " in the command prompt (mnemonic: Tab Move)',
    }
)
vim.keymap.set(
    'n',
    '<Leader>td',
    '<cmd>tabclose<CR>',
    {
        remap = false,
        desc = 'Close the current tab (mnemonic: Tab Delete)',
    }
)
vim.keymap.set(
    'n',
    '<Leader>wt',
    '<cmd>tab split<CR>',
    {
        remap = false,
        desc = 'Open the current window in a new tab',
    }
)

-- Search mappings
vim.keymap.set(
    'n',
    '<Leader>/w',
    '/\\<<C-R>/\\><CR>',
    {
        remap = false,
        desc = 'Repeat the last search, but treat the query like a word',
    }
)

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
    {
        remap = false,
        desc = 'Strip trailing white space',
    }
)

vim.diagnostic.config({
    -- Disable virtual text for diagnostics
    virtual_text = false,
    signs = true,
    underline = true,
    float = { source = 'always', },
})


-- Plugin settings: vim-fugitive
vim.keymap.set(
    'n',
    '<Leader>gfll',
    ':vertical Git --paginate log --max-count 100',
    {
        remap = false,
        desc = 'Put "vertical Git --paginate log --max-count 100" in the command prompt (mnemonic: "git fugitive log (limited)")',
    }
)

vim.keymap.set(
    'n',
    '<Leader>gflv',
    '<cmd>vertical Git --paginate log<CR>',
    {
        remap = false,
        desc = 'Show the git logs (i.e. commit history) in a vertical split (mnemonic: "git fugitive log vertical")',
    }
)

--[[
    TODO: Remove this keymap? How often do I actually use it?

    Process:
        1. Load merge conflicts into quickfix window: `:Git mergetool`
        2. Run this keymap on each merge conflict to get a 4-way diff.

    fugitive keymaps in 4-way diff:
        d2o: Get "our" changes (i.e. the local branch, or the branch being rebased **onto** - the target branch)
        d3o: Get "their" changes (i.e. the remote branch, or the branch being rebased onto a target branch)

    Sources:
    - https://stackoverflow.com/questions/7309707/why-does-git-mergetool-open-4-windows-in-vimdiff-id-expect-3
    - https://stackoverflow.com/questions/12682164/show-base-in-fugitive-vim-conflict-diff
    - https://github.com/tpope/vim-fugitive/issues/1306
--]]
vim.keymap.set(
    'n',
    '<Leader>gf4d',
    '<cmd>Gvdiffsplit! | Ghdiffsplit | wincmd j | wincmd J<CR>',
    {
        remap = false,
        desc = '4-way diff for merge conflicts: d2o/d3o to get "ours"/local / "theirs"/remote, respectively',
    }
)

--[[
    vim-fugitive - fugitive objects
    
    In a merge conflict:

        :1 - the current file's common ancestor
        :2 - "ours"; the version of the file from the branch being rebased onto
        :3 - "theirs"; the version of the file from the branch being rebased

    My new approach:

        :tabedit | Git mergetool - Open first merge conflict in a new tab

        :Gtabedit :1 | Gdiff :2 - diff of common ancestor and "ours"
        :Gtabedit :1 | Gdiff :3 - diff of common ancestor and "theirs"
--]]
vim.keymap.set(
    'n',
    '<Leader>gfmt',
    '<cmd>tabedit | Git mergetool<CR>',
    {
        remap = false,
        desc = 'Open first merge conflict in a new tab',
    }
)
vim.keymap.set(
    'n',
    '<Leader>gfmc',
    ':Gtabedit :1 | Gdiff :',
    {
        remap = false,
        desc = 'Start a merge conflict diff (:2 - "ours", :3 - "theirs")',
    }
)


-- Plugin settings: bmessages.nvim
require('bmessages').setup({
    split_type = "split",
})


-- Plugin settings: undotree
vim.keymap.set(
    'n',
    '<Leader>ut',
    '<cmd>UndotreeToggle<CR>',
    {
        remap = false,
        desc = 'Toggle Undotree',
    }
)


-- Plugin settings: nvim-highlight-colors
local highlight_colors = require('nvim-highlight-colors')

highlight_colors.setup({
    -- Highlight colors in Tailwind CSS classes
    enable_tailwind = true,
})


-- Plugin settings: todo-comments.nvim
local todo_comments = require('todo-comments')

todo_comments.setup({
    keywords = {
        CONFIG = {
            icon = ' ',
            color = 'configuration',
            alt = { 'Plugin settings', 'Configuration', 'Configurations' },
        },
    },
    colors = {
        configuration = { '#ED45CE' },
    },
    search = {
        args = {
            '--hidden',
            -- The rest are from the default setup configurations
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
        }
    }
})

--[[
   Search multiple directories for todo comments. If any are found, populate the
   quickfix list with them and open the quickfix window.
--]]
local todo_comments_search_dirs = function(opts)
    -- Default to current directory as needed
    local dirs_to_search = #opts.fargs > 0 and opts.fargs or { '.' }

    --[[
       HACK: Lightly modify todo-comments's source code as follows:

       In `todo-comments.nvim\lua\todo-comments\search.lua`...

        ...rename `M.search` to `M.get_search_job` and have it return the job
            instead of starting it

        ...add the following:
            ```lua
            function M.search(cb, opts)
                M.get_search_job(cb, opts):start()
            end
            ```
       TODO: Open a PR or an issue for this?
       None of this would be necessary if the telescope integration supported
       multiple search directories.
    --]]
    local get_search_job = require('todo-comments.search').get_search_job

    -- Aggregate search results across directories
    local results = {}
    local collect_results = function(curr_results)
        for _, result in ipairs(curr_results) do
            table.insert(results, result)
        end
    end

    --[[
       Chain the directory searches so the results list will be properly
       populated.
    --]]
    local previous_search_job = nil

    for _, directory in ipairs(dirs_to_search) do
        local current_search_job = get_search_job(
            collect_results,
            { cwd = directory }
        )

        if previous_search_job == nil then
            current_search_job:start()
        else
            previous_search_job:and_then(current_search_job)
        end

        previous_search_job = current_search_job
    end

    --[[
       Report the counts, pop up the quickfix window if we found any matches
    --]]
    previous_search_job:after(
        vim.schedule_wrap(
            function()
                print(
                    'Found '
                    .. #results
                    .. ' todo comment'
                    .. ((#results == 1) and '' or 's')
                    .. ' across '
                    .. #dirs_to_search
                    .. ' director'
                    .. ((#dirs_to_search == 1) and 'y' or 'ies')
                )

                if #results > 0 then
                    vim.fn.setqflist(results, 'r')
                end
            end
        )
    )
end

vim.api.nvim_create_user_command(
    --[[
       Lua: `vim.cmd.TodoSearchDirs('dir1', ..., 'dirN')`
       Vim (EX command): `:TodoSearchDirs dir1 ... dirN`
    --]]
    'TodoSearchDirs',
    todo_comments_search_dirs,
    {
        nargs = '*',      -- 0, 1, or many (whitespace-separated) arguments allowed
        complete = 'dir', -- Enable directory completion for arguments
        desc = 'Search the given location(s) for todo comments and populate the quickfix list with the results'
    }
)

vim.keymap.set(
    'n',
    '<Leader>ftc',
    ':TodoSearchDirs<Space>',
    {
        remap = false,
        desc = 'Put "TodoSearchDirs " in the command prompt',
    }
)

vim.keymap.set(
    'n',
    '[tt',
    function()
        todo_comments.jump_prev({ keywords = { "TODO" } })
    end,
    { remap = false, desc = 'Go to previous "TODO" comment' }
)

vim.keymap.set(
    'n',
    ']tt',
    function()
        todo_comments.jump_next({ keywords = { "TODO" } })
    end,
    { remap = false, desc = 'Go to next "TODO" comment' }
)

vim.keymap.set(
    'n',
    '[tc',
    function()
        todo_comments.jump_prev()
    end,
    { remap = false, desc = 'Go to previous todo comment' }
)

vim.keymap.set(
    'n',
    ']tc',
    function()
        todo_comments.jump_next()
    end,
    { remap = false, desc = 'Go to next todo comment' }
)

vim.keymap.set(
    'n',
    '[ts',
    function()
        todo_comments.jump_prev({
            keywords = {
                "CONFIG",
                "Plugin settings",
                "Configuration",
                "Configurations",
            }
        })
    end,
    { remap = false, desc = 'Go to previous config / plugin settings comment' }
)

vim.keymap.set(
    'n',
    ']ts',
    function()
        todo_comments.jump_next({
            keywords = {
                "CONFIG",
                "Plugin settings",
                "Configuration",
                "Configurations",
            }
        })
    end,
    { remap = false, desc = 'Go to next config / plugin settings comment' }
)


-- Plugin settings: Comment.nvim, nvim-ts-context-commentstring
require('Comment').setup({
    --[[
        PERF: Only trigger the commentstring calculation as needed
        Configure Comment.nvim to trigger the commentstring calculation and
        update logic with its pre_hook configuration.
        Source: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations/9a79249fbecad1c0f86457ae8fdfc0cc39f5317b#commentnvim
    --]]
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

require('Comment.ft')
    -- Set line and block commentstring for Django HTML template files
    -- TODO: Fix inconsistency (is tree-sitter "detecting" HTML inside of htmldjango?)
    .set('htmldjango', {'{# %s #}', '{% comment %} %s {% endcomment %}'})


-- Plugin settings: vim-argwrap
vim.keymap.set(
    'n',
    '<Leader>a',
    '<cmd>ArgWrap<CR>',
    {
        remap = false,
        desc = 'Wrap/unwrap argument list',
    }
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

    lualine_<section> = { 'left', 'middle', 'right' }

    Handy symbols: 
--]]
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
        or file_type == 'nerdtree'
        or file_type == 'oil' then
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

    --[[
        Default separator: ':'
        Normal: {buffer index}{separator}{window number}
        Reversed: {window number}{separator}{buffer index}
    --]]
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
        lualine_b = { window_buffer_location('›') },
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
                -- Separator for file name and diagnostics
                separator = '%#lualine_c_inactive#∙'
            },
            { 'diagnostics' },
        },
        lualine_x = {
            {
                require('auto-session.lib').current_session_name,
                color = 'lualine_a_tabs_inactive',
            },
        },
        lualine_y = { 'fileformat', 'encoding', 'filetype' },
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
        lualine_z = {
            {
                'branch',
                fmt = function(branch_name, _)
                    local branch_short_name = string.match(
                        branch_name,
                        --[[
                            `^`
                            `.-` Match 0+ of anything non-greedily,
                            `/` then forward slash (/),
                            `([^/]+)` then non-forward slash characters greedily
                            $
                        --]]
                        '^.-/([^/]+)$'
                    )

                    return branch_short_name ~= nil and branch_short_name
                        or branch_name
                end,
            },
        },
    },
    inactive_winbar = {
        lualine_a = { window_buffer_location(' ') },
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

-- Don't replace netrw
vim.g.NERDTreeHijackNetrw = false
-- Close the tree window or bookmark table after opening a file
vim.g.NERDTreeQuitOnOpen = 3
-- Display line numbers in the tree window
vim.g.NERDTreeShowLineNumbers = true
-- Don't collapse directories with only one child directory to a single line
vim.g.NERDTreeCascadeSingleChildDir = false
-- Control how a node is opened with the NERDTree-<CR> key
vim.g.NERDTreeCustomOpenArgs = {
    -- When opening a file...
    file = {
        -- ...open it in the previous window
        where = 'p',
        -- ...never jump to an existing window into the file
        reuse = '',
        -- ...do not keep the tree window open
        keepopen = false,
    },
}

vim.keymap.set(
    'n',
    '<Leader>n',
    '<cmd>NERDTreeToggle<CR>',
    {
        remap = false,
        desc = 'Toggle NERDTree window',
    }
)

vim.keymap.set(
    'n',
    '<Leader>fn',
    '<cmd>NERDTreeFind<CR>',
    {
        remap = false,
        desc = 'Open NERDTree with the current file focused (mnemonic: Find current file in NERDTree)',
    }
)


-- Plugin settings: Oil
local oil = require('oil')

local oil_detailed_view = false

oil.setup({
    -- Don't replace netrw
    default_file_explorer = false,
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,

    keymaps = {
        ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
                oil_detailed_view = not oil_detailed_view

                oil.set_columns(oil_detailed_view and {
                    'permissions',
                    'size',
                    'birthtime',
                    'mtime',
                    'icon',
                } or { 'icon' })
            end,
        },
    },

    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

vim.keymap.set(
    'n',
    '<Leader>fo',
    function()
        oil.open_float(vim.fn.expand('%:p:h'))
    end,
    {
        remap = false,
        desc = "Open Oil to the current file's directory (mnemonic: Find current file in Oil)",
    }
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
local ts_lga_actions = require('telescope-live-grep-args.actions')
local ts_actions_layout = require('telescope.actions.layout')

-- Ctrl-based key map options are limited: https://stackoverflow.com/a/28003386
local ts_leader = '<C-b>'

local ts_mappings = {
    -- Try to ensure nothing unfortunate happens if we time out on the leader key
    ts_leader = false,

    -- Send selected/all results to quickfix list and open it
    [ts_leader .. 'qfs'] = ts_actions.smart_send_to_qflist + ts_actions.open_qflist,
    -- Add selected/all results to quickfix list and open it
    [ts_leader .. 'qfa'] = ts_actions.smart_add_to_qflist + ts_actions.open_qflist,

    -- Cycle to next layout
    [ts_leader .. 'nl'] = ts_actions_layout.cycle_layout_next,
    -- Freeze the current list and start a fuzzy search in the frozen list
    [ts_leader .. 'fz'] = ts_actions.to_fuzzy_refine,

    -- Scroll results
    [ts_leader .. 'U'] = ts_actions.results_scrolling_up,
    [ts_leader .. 'D'] = ts_actions.results_scrolling_down,
    [ts_leader .. 'H'] = ts_actions.results_scrolling_left,
    [ts_leader .. 'L'] = ts_actions.results_scrolling_right,

    -- Toggle preview
    [ts_leader .. 'pv'] = ts_actions_layout.toggle_preview,

    -- Scroll preview
    [ts_leader .. 'u'] = ts_actions.preview_scrolling_up,
    [ts_leader .. 'd'] = ts_actions.preview_scrolling_down,
    [ts_leader .. 'h'] = ts_actions.preview_scrolling_left,
    [ts_leader .. 'l'] = ts_actions.preview_scrolling_right,
}

local ts_layout_config = {
    width = function(_, max_columns)
        local percent_width = 0.8
        local max_width = 250

        return math.min(math.floor(percent_width * max_columns), max_width)
    end,
}

telescope.setup({
    defaults = {
        cycle_layout_list = { 'horizontal', 'center', 'vertical' },
        layout_config = ts_layout_config,
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
                    [ts_leader .. 'bd'] = 'delete_buffer',
                },
                n = {
                    -- Delete selected/all buffers
                    [ts_leader .. 'bd'] = 'delete_buffer',
                },
            },
            sort_mru = true,
        },
        find_files = {
            hidden = true,
        },
        git_branches = {
            mappings = {
                i = {
                    -- Delete currently selected branch, with confirmation
                    [ts_leader .. 'bd'] = 'git_delete_branch',
                },
                n = {
                    -- Delete currently selected branch, with confirmation
                    [ts_leader .. 'bd'] = 'git_delete_branch',
                },
            },
        },
    },
    extensions = {
        live_grep_args = {
            mappings = {
                i = {
                    [ts_leader .. '""'] = ts_lga_actions.quote_prompt(),
                    [ts_leader .. 'ig'] = ts_lga_actions.quote_prompt({
                        postfix = ' --iglob '
                    }),
                },
                n = {
                    [ts_leader .. '""'] = ts_lga_actions.quote_prompt(),
                    [ts_leader .. 'ig'] = ts_lga_actions.quote_prompt({
                        postfix = ' --iglob '
                    }),
                },
            },
        },
    },
})

telescope.load_extension('advanced_git_search')
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')
telescope.load_extension('session-lens')
telescope.load_extension('todo-comments')

vim.keymap.set(
    'n',
    '<Leader>ts<Space>',
    ':Telescope<Space>',
    {
        remap = false,
        desc = 'Put "Telescope " in the command prompt',
    }
)


-- Plugin settings: auto-session
-- TODO: Can this be moved into the "extensions" section of Telescope's config?
require('auto-session').setup({
    -- Use git branch to differentiate session name
    auto_session_use_git_branch = true,
    auto_session_suppress_dirs = {
        '~/scoop/apps/neovide/current',
    },

    session_lens = {
        previewer = true,

        mappings = {
            delete_session = {
                { 'i', 'n', },
                ts_leader .. 'sd'
            },
        },

        -- Doesn't respect Telescope's setup defaults, I guess
        theme_conf = { layout_config = ts_layout_config },
    },
})


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

-- Fix for TypeScript files
-- Source: https://github.com/universal-ctags/ctags/issues/2127#issuecomment-507963857
vim.g.tagbar_type_typescript = {
    ctagstype = 'typescript',
    kinds = {
        'c:class',
        'n:namespace',
        'f:function',
        'G:generator',
        'v:variable',
        'm:method',
        'p:property',
        'i:interface',
        'g:enum',
        't:type',
        'a:alias',
    },
    sro = '.',
    kind2scope = {
        c = 'class',
        n = 'namespace',
        i = 'interface',
        f = 'function',
        G = 'generator',
        m = 'method',
        p = 'property',
    },
}

-- Fix for TypeScript/React (tsx) files
-- Source: https://github.com/universal-ctags/ctags/issues/2127#issuecomment-784392429
vim.g.tagbar_type_typescriptreact = {
    ctagstype = 'typescript',
    kinds = {
        'c:class',
        'n:namespace',
        'f:function',
        'G:generator',
        'v:variable',
        'm:method',
        'p:property',
        'i:interface',
        'g:enum',
        't:type',
        'a:alias',
    },
    sro = '.',
    kind2scope = {
        c = 'class',
        n = 'namespace',
        i = 'interface',
        f = 'function',
        G = 'generator',
        m = 'method',
        p = 'property',
    },
}

vim.keymap.set(
    'n',
    '<Leader>tb',
    '<cmd>TagbarToggle<CR>',
    {
        remap = false,
        desc = 'Toggle the Tagbar window (populated by universal ctags)',
    }
)
vim.keymap.set(
    'n',
    '<Leader>ftb',
    '<cmd>TagbarOpenAutoClose<CR>',
    {
        remap = false,
        desc = 'Open Tagbar with the current node focused (mnemonic: Find current node in Tagbar)',
    }
)


-- Plugin settings: mdx.nvim
require('mdx').setup()


-- Plugin settings: nvim-treesitter, nvim-treesitter-textobjects, nvim-ts-autotag
require('nvim-treesitter.configs').setup({
    -- Parsers to install by default
    ensure_installed = {
        'c',
        'html',
        'htmldjango',
        'javascript',
        'lua',
        'python',
        'query',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
    },

    --[[
        Automatically install missing parsers when entering buffer
        Recommendation: disable if you don't have tree-sitter CLI installed locally
    -- ]]
    auto_install = false,

    --[[
        Plugin settings: nvim-ts-autotag
        Configure automatic closing and renaming of tags by nvim-ts-autotag;
        it's unclear to me how tightly nvim-ts-autotag is coupled with
        nvim-treesitter.

        TODO: Probably goes away with autotag upgrade
        SEO: "newer version of neovim"?
    --]]
    autotag = {
        enable = true,
    },

    -- Plugin settings: nvim-ts-context-commentstring
    context_commentstring = {
        enable = true,
        --[[
            PERF: Only trigger the commentstring calculation as needed
            Start by disabling the default autocmd
            Source: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations/9a79249fbecad1c0f86457ae8fdfc0cc39f5317b
        --]]
        enable_autocmd = false,
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

    -- WARNING: Experimental (at time of writing)
    indent = {
        enable = true,

        --[[
            Disable for languages where it doesn't work well
            Source: https://www.reddit.com/r/neovim/comments/svywql/comment/hxr0xjl/?context=3
        --]]
        disable = { 'c', 'tsx', }, -- TODO: Figure out why React files don't indent correctly (TS parser issue?)
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
    formatting = {
        -- Highlight colors with nvim-highlight-colors
        format = highlight_colors.format,
    },
    mapping = nvim_cmp.mapping.preset.insert({
        -- Navigate between snippet placeholders
        ['<C-f>'] = lsp_zero_cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = lsp_zero_cmp_action.luasnip_jump_backward(),

        --[[
            Completion menu visible → navigate to next/prev item in list
            Cursor on snippet trigger → expand snippet
            Snippet placeholder reachable → navigate to next/prev placeholder
            Cursor in word that doesn't trigger snippet → display completion menu
            Otherwise, use the fallback (i.e. the key's default behavior)
        --]]
        ['<C-n>'] = lsp_zero_cmp_action.luasnip_supertab(),
        ['<C-p>'] = lsp_zero_cmp_action.luasnip_shift_supertab(),

        -- Scroll through the completion documentation
        ['<C-d>'] = nvim_cmp.mapping.scroll_docs(4),
        ['<C-u>'] = nvim_cmp.mapping.scroll_docs(-4),

        --[[
            Trigger auto-completion on matches in visible buffers
            Deliberately similar to CTRL-X CTRL-O (omnifunc completion)
        --]]
        ['<C-x><C-b>'] = nvim_cmp.mapping.complete({
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

        -- Use nvim-cmp for language server-focused completion
        ['<C-x><C-x>'] = nvim_cmp.mapping.complete({
            config = {
                sources = {
                    { name = 'nvim_lsp', },
                    { name = 'nvim_lua', },
                    { name = 'luasnip', },
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
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
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
        --[[
            BUG: Latest version of ESLint language server doesn't work
            Source: https://github.com/neovim/nvim-lspconfig/issues/3146

            Further research suggests that Microsoft's VS Code extension for
            ESLint (https://github.com/Microsoft/vscode-eslint) comes bundled
            with the code to make ESLint compatible with / act like a language
            server (I haven't confirmed the specifics). This ESLint language
            server, along with other VS Code-specific language servers, are
            extracted into nvim-compatible releases by hrsh7th, which are then
            pulled by Mason.

            Extracted VS Code language servers: https://github.com/hrsh7th/vscode-langservers-extracted
                ↑ I believe this is what I'm version locking
        --]]
        'eslint@4.8.0', -- TODO: Remove version once fixed
        'jsonls',
        'lua_ls',
        'pyright',
        'tailwindcss',
        'ts_ls',
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})


-- Plugin settings: neodev
require('neodev').setup({})


-- Plugin settings: nvim-lspconfig
-- WARN: Has to come after mason, mason-lspconfig, lsp-zero, and neodev setup
local lspconfig = require('lspconfig')
local lspconfig_utils = require('lspconfig.util')

-- Add a border around `Lsp...` windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

--[[
    NOTE: Demystifying lspconfig language server setup

    See `:h lspconfig-setup`

    Basically, lspconfig is a community-supported plugin that provides nice
    defaults for a lot of language servers.

    View these defaults:
    - `:h lspconfig-all`
    - https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md


    ```lua
    lspconfig.<ls name>.setup({
        cmd = { 'command', '--flag', '--flag value', ... },
        root_dir = function(filename, bufnr) ... end,
        filetypes = { ... },
        ...

        -- Language server-specific settings
        settings = { ... },
    })
    ```

    e.g.,

    ```lua
    lspconfig.tailwindcss.setup({
        -- Other settings for lspconfig
        ...

        -- Tailwind CSS language server settings
        settings = {
            -- https://github.com/tailwindlabs/tailwindcss/issues/7553#issuecomment-735915659
            tailwindCSS = {
                experimental = {
                    configFile = nil,
                    classRegex = {
                        "<regex>",
                        ...
                    },
                },
            },
        },
    })
    ```

    Some helpful language server configuration documentation I've found:
    - **OmniSharp**
        https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options

        (an outlier for supporting hierarchical configuration files)

    - **MDX Analyzer**
        https://github.com/mdx-js/mdx-analyzer/tree/main/packages/language-server#configuration
--]]

lspconfig.html.setup({
    filetypes = { 'html', 'htmldjango', },
})

lspconfig.mdx_analyzer.setup({
    init_options = { typescript = { enabled = true, }, },
    root_dir = lspconfig_utils.root_pattern(
        'node_modules/typescript/',
        '.git',
        'package.json'
    ),
    settings = {
        -- Search for "experimentalLanguageServer" in the changelog:
        -- https://github.com/mdx-js/mdx-analyzer/blob/main/packages/vscode-mdx/CHANGELOG.md
        mdx = { server = { enable = true, }, },
    },
})


-- Plugin settings: fidget.nvim
require('fidget').setup()

vim.keymap.set(
    'n',
    '<>',
    '<cmd>Fidget clear<CR>',
    {
        remap = false,
        desc = "Clear fidget's active notifications",
    }
)

vim.keymap.set(
    'n',
    '<Leader>tsfn',
    function()
        -- TODO: Is it necessary to suppress both?
        vim.cmd([[
            Fidget suppress true
            Fidget lsp_suppress true
            Fidget clear
        ]])

        -- Re-enable them after 30 seconds
        vim.defer_fn(
            function()
                vim.cmd([[
                    Fidget suppress false
                    Fidget lsp_suppress false
                ]])
            end,
            30000
        )
    end,
    {
        remap = false,
        desc = "Temporarily suppress fidget notifications",
    }
)


-- neovide settings (https://neovide.dev/configuration.html)
--[[
    TODO: https://neovide.dev/configuration.html#remember-previous-window-size
    TODO: https://neovide.dev/configuration.html#animate-cursor-blink
--]]
if vim.g.neovide then
    --[[
        Number of seconds the scroll animation takes to complete.

        Note that the timing is not completely accurate and might depend
        slightly on have far you scroll, so experimenting is encouraged in order
        to tune it to your liking.
    --]]
    vim.g.neovide_scroll_animation_length = 0.15

    --[[
        Number of lines at the end of the scroll action to animate when
        scrolling more than one screen at a time.

        Set it to 0 to snap to the final position without any animation, or to
        something big like 9999 to always scroll the whole screen, much like
        neovide <= 0.10.4 did.
    --]]
    vim.g.neovide_scroll_animation_far_lines = 10

    --[[
        Whether to hide the mouse as soon as you start typing.

        This setting only affects the mouse if it is currently within the bounds
        of the neovide window. Moving the mouse makes it visible again.
    --]]
    vim.g.neovide_hide_mouse_when_typing = true

    --[[
        What kinds of particles to produce behind the cursor.

        Options at time of writing:
        "" (default) - no particles
        "railgun"
        "torpedo"
        "pixiedust"
        "sonicboom"
        "ripple"
        "wireframe"

        Source: https://neovide.dev/configuration.html#cursor-particles
    --]]
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    -- Number of seconds generated particles should survive
    vim.g.neovide_cursor_vfx_particle_lifetime = 3
    -- Number of generated particles (so what does a fraction mean?)
    vim.g.neovide_cursor_vfx_particle_density = 15.0
end
