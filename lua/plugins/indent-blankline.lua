local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

indent_blankline.setup({
	-- space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	filetype_exclude = { "NvimTree", "alpha", "Telescope", "Aerial", "aerial", "t", "ToggleTerm" },
})

