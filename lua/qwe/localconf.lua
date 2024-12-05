local localconf = {}

local gotconfig = false

local global_nvim_lua = vim.fn.expand('$HOME/.dotfiles/nvim.lua')

local success, data = pcall(dofile, global_nvim_lua)
if success then
	localconf = data
	gotconfig = true
end

success, data = pcall(dofile, "/app/.nvim.lua")
if success then
	localconf = data
	gotconfig = true
end

if not gotconfig then
	print("#######################################")
	print("# No local neovim configuration found #")
	print("#######################################")
end

return localconf
