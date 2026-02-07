local localconf = require("qwe.localconf")

if not localconf.plugins or not localconf.plugins.enable_tailwindsorter then
	return {}
end

return {
	{
		"laytan/tailwind-sorter.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		config = true,
		-- lazy = true,
		-- cmd = { "TailwindSort", "TailwindSortOnSaveToggle" },
		opts = {
			on_save_enabled = true,
		},
	},
}
