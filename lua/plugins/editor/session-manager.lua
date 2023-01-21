local status_ok, session_manager = pcall(require, "sessions")
if not status_ok then
	return
end

local status_ok, Path = pcall(require, "plenary.path")
if(Path) then
  session_manager.setup({
    events = { "WinEnter" },
    session_filepath = vim.fn.stdpath('data') ..'/session/',
    absolute = true,
})
end

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

