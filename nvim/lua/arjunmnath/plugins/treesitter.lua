return {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
event = { "BufReadPre", "BufNewFile" },
dependencies = { "windwp/nvim-ts-autotag"}, 
config = function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = { "python", "c", "javascript", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        indent = { enable = true },
        autotag = { enable = true },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    })
end
}
