local status_ok, darkman = pcall(require, "darkman")
if not status_ok then
  return
end

require 'darkman'.setup({
  change_background = true,
  send_user_event = false,
  colorscheme = {
    light = "catpuccin-latte",
    dark = "catpuccin-macchiato"
  },
})