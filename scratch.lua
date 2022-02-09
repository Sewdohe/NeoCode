if package.config:sub(1,1) == "/" then
  Current_Os = "unix"
else
  Current_Os = "windows"
end

print(Current_Os)

local packer_is_installed
if Current_Os == "unix" then
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
else
  local install_path = fn.stdpath('data')..'\\site\\pack\\packer\\start\\packer.nvim'
end