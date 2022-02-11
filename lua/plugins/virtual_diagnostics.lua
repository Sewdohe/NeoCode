local status_ok, virtual_diagnostics = pcall(require, "lsp_lines")
if not status_ok then
  return
end

local config = {
  virtual_lines = {
    prefix = '🔥'
  }
}

virtual_diagnostics.register_lsp_virtual_lines()
