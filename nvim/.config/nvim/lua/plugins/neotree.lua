local M = {}

function M.setup()
  require('neo-tree').setup({
    close_if_last_window = true,

    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_dotfiles   = false,
        hide_gitignored = false,
        hide_by_name    = { 'node_modules', '.git' },
        never_show      = { '.DS_Store', 'thumbs.db' },
      },
      use_libuv_file_watcher = true,
    },

    buffers = {
      follow_current_file = { enabled = true },
    },

    git_status = {
      window = { position = 'float' },
    },

    enable_git_status  = true,
    enable_diagnostics = true,
    popup_border_style = 'rounded',
  })

  -- Keymaps live here too, close to what they configure
  vim.keymap.set('n', '\\', '<Cmd>Neotree toggle<CR>', {
    noremap = true,
    silent  = true,
    desc    = 'Toggle Neo-tree sidebar',
  })
end

return M
