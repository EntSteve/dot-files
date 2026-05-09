-- vue_ls (formerly volar) handles .vue files (HTML/CSS sections)
-- ts_ls handles TypeScript inside .vue via @vue/typescript-plugin (hybrid mode)
local vue_plugin_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

vim.lsp.config('ts_ls', {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_plugin_path,
        languages = { 'vue' },
      },
    },
  },
})

vim.lsp.config('vue_ls', {
  filetypes = { 'vue' },
  init_options = {
    vue = { hybridMode = true },
  },
})

vim.lsp.enable { 'ts_ls', 'vue_ls' }

return {}
