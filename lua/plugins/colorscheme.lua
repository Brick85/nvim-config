-- use({
-- 	"catppuccin/nvim",
-- 	as = "catppuccin",
-- })
-- use({
-- 	"rose-pine/neovim",
-- 	as = "rose-pine",
-- })
-- use({
-- 	"tanvirtin/monokai.nvim",
-- 	as = "monokai",
-- })
-- use({
-- 	"folke/tokyonight.nvim",
-- 	as = "tokyonight",
-- })

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                styles = {
                    floats = "transparent",
                    sidebars = "transparent",
                },
                dim_inactive = true,
            })
            vim.cmd([[colorscheme tokyonight]])
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
}
-- return {
--     {
--         "rose-pine/neovim",
--         name = "rose-pine",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             require("rose-pine").setup({
--                 style = "night",
--                 transparent = true,
--                 styles = {
--                     floats = "transparent",
--                     sidebars = "transparent",
--                 },
--                 dim_inactive = true,
--             })
--             vim.cmd([[colorscheme rose-pine]])
--             -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--             -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         end,
--     },
-- }
