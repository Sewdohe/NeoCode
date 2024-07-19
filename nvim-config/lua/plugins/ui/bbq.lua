local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
  return
end

require("barbecue").setup()