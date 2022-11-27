local M = {}

function M.setup()
  local present, cokeline = pcall(require, "cokeline")
  if not present then
    return
  end

  local colors = require("colors").get()

  cokeline.setup({

    show_if_buffers_are_at_least = 2,

    mappings = {
      cycle_prev_next = true,
    },

    default_hl = {
      fg = function(buffer)
        return buffer.is_focused and colors.purple or colors.gray
      end,
      bg = "NONE",
      style = function(buffer)
        return buffer.is_focused and "bold" or nil
      end,
    },

    components = {
      {
        text = function(buffer)
          return buffer.index ~= 1 and "  "
        end,
      },
      {
        text = function(buffer)
          return buffer.index .. ": "
        end,
        style = function(buffer)
          return buffer.is_focused and "bold" or nil
        end,
      },
      {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.purple or colors.gray
        end,
        style = "italic",
      },
      {
        text = function(buffer)
          return buffer.filename .. " "
        end,
        style = function(buffer)
          return buffer.is_focused and "bold" or nil
        end,
      },
      {
        text = function(buffer)
          return buffer.is_modified and " ●"
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.red
        end,
      },
      {
        text = "  ",
      },
    },
  })
end

return M
