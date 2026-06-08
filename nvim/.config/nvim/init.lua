-- Leader (must be before plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- ============================================================================
-- Options
-- ============================================================================
local o = vim.o
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false
o.signcolumn = 'yes'
o.cursorline = true
o.scrolloff = 15
o.list = true
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.inccommand = 'split'
o.undofile = true
o.confirm = true
o.updatetime = 250
o.timeoutlen = 300
o.breakindent = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.softtabstop = 4
o.autocomplete = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)
-- ============================================================================
-- Keymaps
-- ============================================================================
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix diagnostics' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- ============================================================================
-- Autocommands
-- ============================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.pack.add {
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range '3',
  },
  -- dependencies
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  -- optional, but recommended | Also needed for lua line now
  'https://github.com/nvim-tree/nvim-web-devicons',
  -- telescope
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  --Which key
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/folke/which-key.nvim',
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  'https://github.com/ellisonleao/gruvbox.nvim',
  -- Mason
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  --gitsign
  'https://github.com/lewis6991/gitsigns.nvim',
  --Lua line
  'https://github.com/nvim-lualine/lualine.nvim',
}

require('gruvbox').setup()
vim.cmd.colorscheme("gruvbox")

require('plugins.neotree').setup()
require('plugins.telescope').setup()
require('plugins.misc').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {"lua_ls"}
})
require('lualine').setup()
