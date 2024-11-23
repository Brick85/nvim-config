vim.g.skip_ts_context_commentstring_module = true
vim.g.loaded_ts_context_commentstring = 1

return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        -- "Brick85/nvim-ts-context-commentstring",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring", 
        },
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "JoosepAlviste/nvim-ts-context-commentstring" 
        },
    },
}
