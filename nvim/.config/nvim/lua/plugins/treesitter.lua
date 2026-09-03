local T = {}

function T.setup()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            "lua", "vim", "vimdoc", "json", "bash", "markdown", "javascript",
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enabled = true,
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    })
