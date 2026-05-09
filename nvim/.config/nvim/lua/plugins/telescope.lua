return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function()
        return vim.fn.executable('make') == 1
    end },
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown() } },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local b   = require('telescope.builtin')
    local map = vim.keymap.set

    map('n', '<leader>sh', b.help_tags,    { desc = '[S]earch [H]elp' })
    map('n', '<leader>sk', b.keymaps,      { desc = '[S]earch [K]eymaps' })
    map('n', '<leader>sf', b.find_files,   { desc = '[S]earch [F]iles' })
    map('n', '<leader>sg', b.live_grep,    { desc = '[S]earch by [G]rep' })
    map('n', '<leader>sd', b.diagnostics,  { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sr', b.resume,       { desc = '[S]earch [R]esume' })
    map('n', '<leader>sw', b.grep_string,  { desc = '[S]earch current [W]ord' })
    map('n', '<leader>s.', b.oldfiles,     { desc = '[S]earch Recent Files' })
    map('n', '<leader><leader>', b.buffers, { desc = 'Find Buffers' })

    map('n', '<leader>/', function()
      b.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
    end, { desc = 'Fuzzy search buffer' })

    map('n', '<leader>sn', function()
      b.find_files { cwd = vim.fn.stdpath('config') }
    end, { desc = '[S]earch [N]eovim config' })
  end,
}
