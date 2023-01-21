local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

configs.setup({
	-- this is a list of default support you need.
	ensure_installed = {
		"lua",
		"typescript",
    "html",
    "css",
    "rust",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
    -- use_languagetree = true,
		enable = true, -- false will disable the whole extension
		-- disable = { "css", "html" }, -- list of language that will be disabled
		-- disable = { "css" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "yaml", "css" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	rainbow = {
		enable = false,
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
})
