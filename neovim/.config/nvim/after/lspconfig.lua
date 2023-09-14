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
