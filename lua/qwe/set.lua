-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
if not vim.fn.isdirectory(vim.fn.stdpath("data") .. "/undodir") then
    vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir")
end
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 100

vim.opt.colorcolumn = "80"

-- vim.g.netrw_banner = 0

vim.opt.scroll = 22

vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
