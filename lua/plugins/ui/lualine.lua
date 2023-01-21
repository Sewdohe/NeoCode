local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local function lsp_server_name()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end
-- icon = ' LSP:',ra
-- color = { fg = '#ffffff', gui = 'bold' },

local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		-- section_separators = { left = "", right = "" },
		-- component_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {

    },
		always_divide_middle = true,
    globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
      {
      "diagnostics",
      sources = {'nvim_lsp'},
		lualine_c = { { lsp_server_name, icons_enabled = true, icon = " " }, "filename" },
		lualine_x = { "filetype" },
		lualine_y = { },
		lualine_z = { "location", "progress" },
	},
	inactive_sections = {
		-- lualine_a = {},
		-- lualine_b = {},
		-- lualine_c = {},
		-- lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {}
	},
	tabline = {},
	extensions = { "nvim-tree", "aerial", "fzf", "toggleterm" },
}

lualine.setup(config)


-- GLYPH LOOKUP
-- Decimal 	Unicode 	Glyph
-- 57504 	\ue0a0 	
-- 57505 	\ue0a1 	
-- 57506 	\ue0a2 	
-- 57507 	\ue0a3 	
-- 57520 	\ue0b0 	
-- 57521 	\ue0b1 	
-- 57522 	\ue0b2 	
-- 57523 	\ue0b3 	
-- 57524 	\ue0b4 	
-- 57525 	\ue0b5 	
-- 57526 	\ue0b6 	
-- 57527 	\ue0b7 	
-- 57528 	\ue0b8 	
-- 57529 	\ue0b9 	
-- 57530 	\ue0ba 	
-- 57531 	\ue0bb 	
-- 57532 	\ue0bc 	
-- 57533 	\ue0bd 	
-- 57534 	\ue0be 	
-- 57535 	\ue0bf 	
-- 57536 	\ue0c0 	
-- 57537 	\ue0c1 	
-- 57538 	\ue0c2 	
-- 57539 	\ue0c3 	
-- 57540 	\ue0c4 	
-- 57541 	\ue0c5 	
-- 57542 	\ue0c6 	
-- 57543 	\ue0c7 	
-- 57544 	\ue0c8 	
-- 57546 	\ue0ca 	
-- 57548 	\ue0cc 	
-- 57549 	\ue0cd 	
-- 57550 	\ue0ce 	
-- 57551 	\ue0cf 	
-- 57552 	\ue0d0 	
-- 57553 	\ue0d1 	
-- 57554 	\ue0d2 	
-- 57556 	\ue0d4 	
