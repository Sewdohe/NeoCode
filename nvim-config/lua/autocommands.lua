vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo,spectre_panel nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

]]

-- removed this from the above block for causing errors on buffer switch:
-- autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

local bbq_ok, bbq = pcall(require, "barbecue")
if not bbq_ok then
  return
end

vim.api.nvim_create_autocmd({
  "BufWinEnter",
  "BufWritePost",
  "CursorMoved",
  "InsertLeave",
  "TextChanged",
  "TextChangedI",
  -- add more events here
}, {
  group = vim.api.nvim_create_augroup("barbecue", {}),
  callback = function()
    require("barbecue.ui").update()

    -- maybe a bit more logic here
  end,
})


vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- 1. Get the path and resolve symlinks to the real physical path
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" or vim.bo.buftype ~= "" then return end
    
    local real_path = vim.uv.fs_realpath(path) or path
    local dir = vim.fs.dirname(real_path)

    -- 2. Search upward for the .git directory starting from the REAL path
    local root_file = vim.fs.find({ ".git" }, { upward = true, path = dir })[1]
    
    if root_file then
      local root = vim.fs.dirname(root_file)
      -- 3. Change the global CWD to the discovered root
      vim.fn.chdir(root)
    end
  end,
})
