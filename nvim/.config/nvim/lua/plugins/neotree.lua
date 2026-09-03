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

  vim.keymap.set('n', '-', function()
    local reveal_file = vim.fn.expand('%:p')
    if (reveal_file == '') then
      reveal_file = vim.fn.getcwd()
    else
      local f = io.open(reveal_file, "r")
      if (f) then
        f.close(f)
      else
        reveal_file = vim.fn.getcwd()
      end
    end
    require('neo-tree.command').execute({
      action = "focus",          -- OPTIONAL, this is the default value
      source = "filesystem",     -- OPTIONAL, this is the default value
      position = "left",         -- OPTIONAL, this is the default value
      reveal_file = reveal_file, -- path to file or folder to reveal
      reveal_force_cwd = true,   -- change cwd without asking if needed
    })
    end,
    { desc = "Open neo-tree at current file or working directory" }
  );

end

return M
