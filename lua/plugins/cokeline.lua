local yellow = vim.g.terminal_color_3
local cokeline_okay, cokeline = pcall(require, "cokeline")
if not cokeline_okay then
  return
end
local utils_okay, utils= pcall(require, "cokeline/utils")
if not utils_okay then
  return
end

cokeline.setup({
  default_hl = {
    focused = {
      fg = utils.get_hex('Normal', 'fg'),
      bg = utils.get_hex('ColorColumn', 'bg'),
    },
    unfocused = {
      fg = utils.get_hex('Comment', 'fg'),
      bg = utils.get_hex('ColorColumn', 'bg'),
    },
  },

  rendering = {
    left_sidebar = {
      filetype = 'NvimTree',
      components = {
        {
          text = '  NvimTree',
          hl = {
            fg = yellow,
            bg = utils.get_hex('NvimTreeNormal', 'bg'),
            style = 'bold'
          }
        },
      }
    },
  },

  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
    },
    {
      text = '  ',
    },
    {
      text = function(buffer)
        return buffer.devicon.icon
      end,
      hl = {
        fg = function(buffer)
          return buffer.devicon.color
        end,
      },
    },
    {
      text = ' ',
    },
    {
      text = function(buffer) return buffer.filename .. '  ' end,
      hl = {
        style = function(buffer)
          return buffer.is_focused and 'bold' or nil
        end,
      }
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },
})
