return {
  'nvim-neo-tree/neo-tree.nvim',
  version      = '*',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
  cmd          = 'Neotree',
  keys         = {
    { '\\', '<cmd>Neotree reveal<CR>', desc = 'Reveal in Neo-tree' },
  },
  opts = {
    filesystem = {
      window = { mappings = { ['\\'] = 'close_window' } },
    },
  },
}
