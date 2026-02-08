vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "x" }, "<leader>p", [["_dP]])
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]])

-- Free key for tmux
vim.keymap.set("i", "<C-b>", "<Nop>")

-- Disable mouse
-- vim.opt.mouse = ""

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- vim.keymap.set("n", "<C-[>", ":cprevious<CR>")
-- vim.keymap.set("n", "<C-]>", ":cnext<CR>")

vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprev<CR>")
vim.keymap.set("n", "<M-h>", ":cclose<CR>")
vim.keymap.set("n", "<M-l>", ":copen<CR>")

-- vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>")
vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>lv", ":.lua<CR>")
vim.keymap.set("v", "<leader>lv", ":lua<CR>")
