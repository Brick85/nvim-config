vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- vim.keymap.set("x", "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "x" }, "<leader>p", [["_dP]])
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- Free keys for tmux

vim.keymap.set("i", "<C-b>", "<Nop>")

-- Disable mouse
vim.opt.mouse = ""

-- Autobrace
-- vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>ko")

-- move lines
-- vim.keymap.set("n", "<C-A-j>", ":m .+1<CR>==")
-- vim.keymap.set("n", "<C-A-k>", ":m .-2<CR>==")
-- vim.keymap.set("i", "<C-A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<C-A-k>", "<Esc>:m .-2<CR>==gi")
-- vim.keymap.set("v", "<C-A-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<C-A-k>", ":m '<-2<CR>gv=gv")

-- go
-- if vim.env.VIMENV == "golang" then
--     vim.keymap.set("n", "<F5>", ":!go run .<CR>")
-- end

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- vim.keymap.set("n", "<C-[>", ":cprevious<CR>")
-- vim.keymap.set("n", "<C-]>", ":cnext<CR>")
--
vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>")
