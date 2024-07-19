local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  return
end

require("nvim-surround").setup({
  -- Configuration here, or leave empty to use defaults
})
