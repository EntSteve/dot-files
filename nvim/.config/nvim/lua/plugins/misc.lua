return {
  -- Indentation detection
  'NMAC427/guess-indent.nvim',

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' },
                topdelete = { text = '‾' }, changedelete = { text = '~' } },
    },
  },

  -- Keybind hints
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts  = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec  = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- TODO comments
  {
    'folke/todo-comments.nvim',
    event        = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts         = { signs = false },
  },

  -- Mini utilities: text objects, surround, statusline
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local sl = require('mini.statusline')
      sl.setup { use_icons = vim.g.have_nerd_font }
      sl.section_location = function() return '%2l:%-2v' end
    end,
  },
}
