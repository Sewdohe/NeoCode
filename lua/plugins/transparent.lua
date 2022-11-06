local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
  return
end

transparent.setup({
  enable = false, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be clear
    -- In particular, when you set it to 'all', that means all avaliable groups

    -- example of akinsho/nvim-bufferline.lua
    "all",
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
    "LuaLine",
    "NvimTree"
  },
  exclude = {}, -- table: groups you don't want to clear
})
