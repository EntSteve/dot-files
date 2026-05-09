-- Leader (must be before plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- ============================================================================
-- Options
-- ============================================================================
local o = vim.o
o.number         = true
o.relativenumber = true
o.mouse          = 'a'
o.showmode       = false
o.signcolumn     = 'yes'
o.cursorline     = true
o.scrolloff      = 15
o.list           = true
o.splitright     = true
o.splitbelow     = true
o.ignorecase     = true
o.smartcase      = true
o.inccommand     = 'split'
o.undofile       = true
o.confirm        = true
o.updatetime     = 250
o.timeoutlen     = 300
o.breakindent    = true
o.tabstop        = 4
o.shiftwidth     = 4
o.expandtab      = true
o.softtabstop    = 4

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.schedule(function() o.clipboard = 'unnamedplus' end)

-- ============================================================================
-- Keymaps
-- ============================================================================
local map = vim.keymap.set

map('n', '<Esc>',       '<cmd>nohlsearch<CR>')
map('n', '<leader>q',   vim.diagnostic.setloclist, { desc = 'Quickfix diagnostics' })
map('t', '<Esc><Esc>',  '<C-\\><C-n>',             { desc = 'Exit terminal mode' })
map('n', '<C-h>',       '<C-w><C-h>',              { desc = 'Focus left window' })
map('n', '<C-l>',       '<C-w><C-l>',              { desc = 'Focus right window' })
map('n', '<C-j>',       '<C-w><C-j>',              { desc = 'Focus lower window' })
map('n', '<C-k>',       '<C-w><C-k>',              { desc = 'Focus upper window' })

-- ============================================================================
-- Autocommands
-- ============================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugins
-- ============================================================================
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂',
      init = '⚙', keys = '🗝', plugin = '🔌', runtime = '💻',
      require = '🌙', source = '📄', start = '🚀', task = '📌', lazy = '💤',
    },
  },
})
