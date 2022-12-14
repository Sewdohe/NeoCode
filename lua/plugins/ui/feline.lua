local components = {
  active = {},
  inactive = {}
}

-- INSERT COMPONENTS

-- LEFT SIDE
components.active[1][1] = {
    {
      provider = 'vi_mode',
      hl = function()
        return {
          name = require('feline.providers.vi_mode').get_mode_highlight_name(),
          fg = require('feline.providers.vi_mode').get_mode_color(),
          style = 'bold'
        }
      end,
      right_sep = ' '
    }
}

-- MIDDLE
table.insert(components.active[1], {

})

-- RIGHT SIDE
table.insert(components.active[1], {

})

require('feline').setup()
require('feline').winbar.setup()
