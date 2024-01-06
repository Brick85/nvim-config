return {
    {
        "AckslD/nvim-neoclip.lua",
        keys = {
            { "<leader>pp", function() require('telescope').extensions.neoclip.default() end, "n" },
        },
        opts = {},
        lazy = false,
    },
}
