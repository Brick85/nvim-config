function ColorMyPencils(color)
	-- color = color or "rose-pine"
	-- color = color or "monokai"
	-- vim.cmd.colorscheme(color)
	-- vim.cmd("colorscheme catppuccin-mocha")
	-- vim.cmd("colorscheme rose-pine")
	-- vim.cmd("colorscheme monokai_pro")
	vim.cmd("colorscheme tokyonight")
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
