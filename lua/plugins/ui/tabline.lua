local status_ok, tabline = pcall(require, "tabline")
if not status_ok then
  return
end

tabline.setup{
  enable = true,
  options = {
    show_tabs_always = false,
    show_devicons = true,
    show_filename_only = true,
  }
}

vim.cmd[[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
