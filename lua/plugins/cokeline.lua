local get_hex = require('cokeline/utils').get_hex

local yellow = vim.g.terminal_color_3

require('cokeline').setup({
  default_hl = {
    focused = {
      fg = get_hex('Normal', 'fg'),
      bg = get_hex('ColorColumn', 'bg'),
    },
    unfocused = {
      fg = get_hex('Comment', 'fg'),
      bg = get_hex('ColorColumn', 'bg'),
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
            bg = get_hex('NvimTreeNormal', 'bg'),
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
