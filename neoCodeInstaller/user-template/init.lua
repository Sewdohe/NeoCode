-- use pcalls in this file to require custom config files,
-- that way if anyone syncs the repo and doesn't have that file they won't get errors

local settings_okay, _ = pcall(require, "user.settings")
if not settings_okay then
  return
end

local custom_okay, _ = pcall(require, "user.visual")
if not custom_okay then
  return
end


-- local custom_okay, _ = pcall(require, "usercustom.windline")
-- if not custom_okay then
--   return
-- end
