local localconf = {}

local gotconfig = false

local success, data = pcall(dofile, "/home/vital/.dotfiles/.nvim.lua")
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
