vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	use({
		"tanvirtin/monokai.nvim",
		as = "monokai",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	-- use("prettier/vim-prettier")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("jay-babu/mason-null-ls.nvim")
	use("github/copilot.vim")
	use("tpope/vim-commentary")
	use("nvim-treesitter/nvim-treesitter-context")
	use("mg979/vim-visual-multi")
	if vim.env.VIMENV == "node" then
		use({
			"laytan/tailwind-sorter.nvim",
			requires = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
			config = function()
				require("tailwind-sorter").setup()
			end,
			run = "cd formatter && npm i && npm run build",
		})
	end
end)
