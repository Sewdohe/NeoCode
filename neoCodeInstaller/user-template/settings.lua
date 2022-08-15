-- INFO: Setup settings
local settings = {
  clipboard = "unnamedplus"
}

for key, value in pairs(settings) do
  vim.opt[key] = value
end


