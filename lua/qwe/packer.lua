vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
--  use {
--	  "catppuccin/nvim", 
--	  as = "catppuccin", 
--	  config = function()
--		  vim.cmd('colorscheme catppuccin-mocha')
--	  end
--  }
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		vim.cmd('colorscheme rose-pine')
	  end
  })
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end}
	  
  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
end)
