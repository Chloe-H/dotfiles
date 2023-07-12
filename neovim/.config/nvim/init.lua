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

-- Navigation
Plug('ctrlpvim/ctrlp.vim')
Plug('scrooloose/nerdtree')

-- Search
Plug('junegunn/fzf', {
    ['do'] = function()
        vim.call('fzf#install')
    end
})
Plug('junegunn/fzf.vim')

-- LSP stuff
Plug('neovim/nvim-lspconfig')
Plug('Decodetalkers/csharpls-extended-lsp.nvim')
Plug('Hoffs/omnisharp-extended-lsp.nvim')

-- Color schemes
Plug('folke/tokyonight.nvim')

vim.call('plug#end')


-- Native settings

vim.g.mapleader = ','

vim.cmd.colorscheme('tokyonight')

-- Disable the mouse in all modes
vim.opt.mouse = ''

-- Show line numbers
vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.colorcolumn = '80,100,120'

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use unix line endings
vim.opt.fileformat = 'unix'

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

-- Plugin settings: vim-argwrap
vim.keymap.set(
    'n',
    '<Leader>a',
    '<cmd>ArgWrap<CR>',
    { remap = false }
)


-- Plugin settings: lualine.nvim
require('lualine').setup({
    options = {
        disabled_filetypes = {
            'ctrlp',
            'nerdtree',
        },
    }
})


-- Plugin settings: CtrlP
vim.g.ctrlp_match_current_file = 1

-- For Windows
vim.g.ctrlp_user_command = 'dir %s /-n /b /s /a-d'


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


-- Plugin settings: lspconfig
local lspconfig = require('lspconfig')

-- Window borders, for readability

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


local on_attach_apply_universal_lsp_configs = function(client, bufnr)
    -- Enable completion triggered by <C-x><C-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
end

-- Useful things for configuring C# language servers

-- Types of files the C# LSPs can be started in
local csharp_filetypes = { 'solution', 'xml', 'cs', 'vb' }

-- Gets the root directory
local csharp_root_dir = function(startpath)
    -- Source: https://github.com/neovim/nvim-lspconfig/issues/2612
    return lspconfig.util.root_pattern('*.sln')(startpath)
        or lspconfig.util.root_pattern('*.csproj')(startpath)
        or lspconfig.util.root_pattern('*.fsproj')(startpath)
        or lspconfig.util.root_pattern('.git')(startpath)
end

-- Gets the C# language server's source (i.e. an absolute path to a sln,
-- csproj, or dir)
local csharp_source = function()
    local source_path
    local file_extension = vim.fn.expand('%:e')

    if file_extension == 'sln' or file_extension == 'csproj' then
        -- Use the path to the open project or solution
        source_path = vim.fn.expand('%:p')
    else
        -- Get the nearest ancestor dir containing a C# root-y file
        source_path = csharp_root_dir(vim.fn.expand('%:p:h'))
    end

    return source_path
end

--[[
    LSP settings: csharp-language-server
    lang(s): C#
--]]
lspconfig['csharp_ls'].setup({
    autostart = false,
    filetypes = csharp_filetypes,
    cmd = {
        'csharp-ls',
        '--solution',
        csharp_source(),
    },
    root_dir = csharp_root_dir,
    on_attach = on_attach_apply_universal_lsp_configs,
    handlers = {
        ['textDocument/definition'] = require('csharpls_extended').handler,
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            -- Disable diagnostics because they're ALL WRONG
            result.diagnostics = {}
        end,
    },
})

--[[
    LSP settings: OmniSharp-Roslyn
    lang(s): C#

    Source(s):
        - https://stackoverflow.com/a/76225760
--]]
lspconfig['omnisharp'].setup({
    autostart = false,
    filetypes = csharp_filetypes,
    cmd = {
        'C:\\OmniSharp\\omnisharp-win-x64\\OmniSharp.exe',
        '--languageserver',
        '--hostPID',
        tostring(vim.fn.getpid()),
        '--source',
        csharp_source(),
    },
    root_dir = csharp_root_dir,
    on_attach = function(client, bufnr)
        on_attach_apply_universal_lsp_configs(client, bufnr)

        --[[
            Temporary fix for a Roslyn issue in OmniSharp
            Relevant:
                - https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
                - https://github.com/neovim/neovim/issues/21391
        --]]
        client.server_capabilities.semanticTokensProvider = {
            range = true,
            full = vim.empty_dict(),
            legend = {
                tokenModifiers = { 'static_symbol' },
                tokenTypes = {
                    'comment',
                    'excluded_code',
                    'identifier',
                    'keyword',
                    'keyword_control',
                    'number',
                    'operator',
                    'operator_overloaded',
                    'preprocessor_keyword',
                    'string',
                    'whitespace',
                    'text',
                    'static_symbol',
                    'preprocessor_text',
                    'punctuation',
                    'string_verbatim',
                    'string_escape_character',
                    'class_name',
                    'delegate_name',
                    'enum_name',
                    'interface_name',
                    'module_name',
                    'struct_name',
                    'type_parameter_name',
                    'field_name',
                    'enum_member_name',
                    'constant_name',
                    'local_name',
                    'parameter_name',
                    'method_name',
                    'extension_method_name',
                    'property_name',
                    'event_name',
                    'namespace_name',
                    'label_name',
                    'xml_doc_comment_attribute_name',
                    'xml_doc_comment_attribute_quotes',
                    'xml_doc_comment_attribute_value',
                    'xml_doc_comment_cdata_section',
                    'xml_doc_comment_comment',
                    'xml_doc_comment_delimiter',
                    'xml_doc_comment_entity_reference',
                    'xml_doc_comment_name',
                    'xml_doc_comment_processing_instruction',
                    'xml_doc_comment_text',
                    'xml_literal_attribute_name',
                    'xml_literal_attribute_quotes',
                    'xml_literal_attribute_value',
                    'xml_literal_cdata_section',
                    'xml_literal_comment',
                    'xml_literal_delimiter',
                    'xml_literal_embedded_expression',
                    'xml_literal_entity_reference',
                    'xml_literal_name',
                    'xml_literal_processing_instruction',
                    'xml_literal_text',
                    'regex_comment',
                    'regex_character_class',
                    'regex_anchor',
                    'regex_quantifier',
                    'regex_grouping',
                    'regex_alternation',
                    'regex_text',
                    'regex_self_escaped_character',
                    'regex_other_escape',
                },
            },
        }
    end,
    handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler,
    },
})
