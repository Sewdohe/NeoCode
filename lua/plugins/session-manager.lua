local status_ok, session_manager = pcall(require, "sessions")
if not status_ok then
	return
end

local Path = require('plenary.path')
session_manager.setup({
  -- events = { "VimLeavePre" },
  events = { "WinEnter" },
  session_filepath = vim.fn.stdpath('data') ..'/sessions/',
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

