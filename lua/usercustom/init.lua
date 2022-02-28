-- use pcalls in this file to require custom config files,
-- that way if anyone syncs the repo and doesn't have that file they won't get errors

local custom_okay, _ = pcall(require, "usercustom.visual")
if not custom_okay then
  return
end

