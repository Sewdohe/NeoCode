local status_ok, norg = pcall(require, "neorg")
if not status_ok then
	return
end

norg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/norg/work",
					home = "~/norg/home",
					notes = "~/norg/notes",
					journal = "~/norg/journal",
				},
			},
		},
		["core.norg.journal"] = {
			config = {
				workspace = "notes",
			},
		},
		["core.norg.concealer"] = {},
    -- TODO: hook in completion engine
		-- ["core.norg.completion"] = {},
		["core.norg.qol.toc"] = {},
	},
})
