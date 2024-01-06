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
            vim.cmd([[colorscheme tokyonight]])
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
}
