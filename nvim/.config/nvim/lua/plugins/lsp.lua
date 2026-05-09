return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim',          opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim',             opts = {} },
    { 'folke/lazydev.nvim', ft = 'lua', opts = {
        library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
    }},
    'saghen/blink.cmp',
  },
  config = function()
    -- On attach: keymaps + document highlight + inlay hints
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local tb = require('telescope.builtin')

        map('grn', vim.lsp.buf.rename,            '[R]ename')
        map('gra', vim.lsp.buf.code_action,       'Code [A]ction', { 'n', 'x' })
        map('grr', tb.lsp_references,             '[R]eferences')
        map('gri', tb.lsp_implementations,        '[I]mplementation')
        map('grd', tb.lsp_definitions,            '[D]efinition')
        map('grD', vim.lsp.buf.declaration,       '[D]eclaration')
        map('gO',  tb.lsp_document_symbols,       'Document Symbols')
        map('gW',  tb.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('grt', tb.lsp_type_definitions,       '[T]ype Definition')

        local function supports(method)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          return client and client:supports_method(method, event.buf) or false
        end

        if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local g = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf, group = g, callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf, group = g, callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(e)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = e.buf }
            end,
          })
        end

        if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, 'Toggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostics
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN]  = ' ',
          [vim.diagnostic.severity.INFO]  = ' ',
          [vim.diagnostic.severity.HINT]  = ' ',
        },
      } or {},
      virtual_text = { source = 'if_many', spacing = 2 },
    }

    -- Shared capabilities for all servers
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Servers: keys are server names, values are extra vim.lsp.config options
    local servers = {
      pyright = {},
      ts_ls   = {},
      lua_ls  = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
    }

    for name, config in pairs(servers) do
      vim.lsp.config(name, vim.tbl_deep_extend('force', { capabilities = capabilities }, config))
    end

    require('mason-tool-installer').setup {
      ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'stylua' }),
    }

    -- mason-lspconfig bridges Mason installs → vim.lsp.enable()
    require('mason-lspconfig').setup {
      ensure_installed      = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    }
  end,
}
