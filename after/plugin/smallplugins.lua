-- Comments
vim.g.skip_ts_context_commentstring_module = true
vim.g.loaded_ts_context_commentstring = 1

require('Comment').setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})


-- Indent Blankline
require("ibl").setup({
    indent = { char = "▏"}
})



-- surround.nvim
-- require("surround").setup({mappings_style = "sandwich"})


-- nvim-neoclip.lua
require('neoclip').setup()
vim.keymap.set("n", "<leader>pp", require('telescope').extensions.neoclip.default)


-- lewis6991/gitsigns.nvim
require('gitsigns').setup()

