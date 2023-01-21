local catppuccin = require("catppuccin")
catppuccin.setup()
local mocha = require("catppuccin.palettes").get_palette "mocha"

local catppccn_colors = {
  base = "#1E1E2E",
  blue = "#89B4FA",
  crust = "#11111B",
  flamingo = "#F2CDCD",
  green = "#A6E3A1",
  lavender = "#B4BEFE",
  mantle = "#181825",
  maroon = "#EBA0AC",
  mauve = "#CBA6F7",
  overlay0 = "#6C7086",
  overlay1 = "#7F849C",
  overlay2 = "#9399B2",
  peach = "#FAB387",
  pink = "#F5C2E7",
  red = "#F38BA8",
  rosewater = "#F5E0DC",
  sapphire = "#74C7EC",
  sky = "#89DCEB",
  subtext0 = "#A6ADC8",
  subtext1 = "#BAC2DE",
  surface0 = "#313244",
  surface1 = "#45475A",
  surface2 = "#585B70",
  teal = "#94E2D5",
  text = "#CDD6F4",
  yellow = "#F9E2AF"
}

local bg_selected = catppccn_colors.base
local text_selected = catppccn_colors.text
local bg = catppccn_colors.base
local tab_bg = catppccn_colors.surface0
local text = catppccn_colors.text


require('bufferline').setup({
  options = {
    separator_style = { "", "" },
    diagnostics = "nvim_lsp",
    buffer_close_icon = "",
    indicator = {
      style = "icon",
      icon = "  "
    },
  },
  highlights = {
    fill = {
        fg = text,
        bg = bg,
    },
    background = {
        fg = text,
        bg = bg
    },
    tab = {
        fg = text,
        bg = tab_bg
    },
    tab_selected = {
        fg = text,
        bg = bg_selected
    },
    tab_close = {
        fg = catppccn_colors.subtext0,
        bg = bg
    },
    close_button = {
        fg = catppccn_colors.subtext0,
        bg = bg
    },
    close_button_visible = {
        fg = catppccn_colors.subtext0,
        bg = bg
    },
    close_button_selected = {
        fg = catppccn_colors.red,
        bg = bg_selected
    },
    buffer_visible = {
        fg = text,
        bg = bg
    },
    buffer_selected = {
      fg = text_selected,
      bg = bg_selected,
      bold = true,
      italic = true,
    },
    -- numbers = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    -- },
    -- numbers_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    -- },
    -- numbers_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     bold = true,
    --     italic = true,
    -- },
    diagnostic = {
        fg = text,
        bg = bg,
    },
    diagnostic_visible = {
        fg = text,
        bg = bg,
    },
    diagnostic_selected = {
        fg = text_selected,
        bg = bg_selected,
        bold = true,
        italic = true,
    },
    -- hint = {
    --     fg = '<colour-value-here>',
    --     sp = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- hint_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- hint_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    -- hint_diagnostic = {
    --     fg = '<colour-value-here>',
    --     sp = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- hint_diagnostic_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- hint_diagnostic_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    info = {
        fg = text,
        -- sp = '<colour-value-here>',
        bg = bg
    },
    -- info_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    info_selected = {
        fg = text_selected,
        bg = bg_selected,
        -- sp = '<colour-value-here>',
        bold = true,
        italic = true,
    },
    -- info_diagnostic = {
    --     fg = '<colour-value-here>',
    --     sp = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- info_diagnostic_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- info_diagnostic_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    -- warning = {
    --     fg = '<colour-value-here>',
    --     sp = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- warning_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- warning_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    -- warning_diagnostic = {
    --     fg = '<colour-value-here>',
    --     sp = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- warning_diagnostic_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- warning_diagnostic_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = warning_diagnostic_fg
    --     bold = true,
    --     italic = true,
    -- },
    -- error = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    -- },
    -- error_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- error_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    -- error_diagnostic = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    -- },
    -- error_diagnostic_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- error_diagnostic_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     sp = '<colour-value-here>'
    --     bold = true,
    --     italic = true,
    -- },
    -- modified = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- modified_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- modified_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    -- },
    -- duplicate_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    --     italic = true,
    -- },
    -- duplicate_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    --     italic = true
    -- },
    -- duplicate = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>'
    --     italic = true
    -- },
    separator_selected = {
        fg = catppccn_colors.surface0,
        bg = catppccn_colors.surface0
    },
    separator_visible = {
        fg = bg,
        bg = bg
    },
    separator = {
        fg = catppccn_colors.crust,
        bg = bg
    },
    indicator_selected = {
        fg = catppccn_colors.teal,
        bg = bg_selected
    },
    -- pick_selected = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     bold = true,
    --     italic = true,
    -- },
    -- pick_visible = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     bold = true,
    --     italic = true,
    -- },
    -- pick = {
    --     fg = '<colour-value-here>',
    --     bg = '<colour-value-here>',
    --     bold = true,
    --     italic = true,
    -- },
    -- offset_separator = {
    --     fg = win_separator_fg,
    --     bg = separator_background_color,
    -- },
  }
})
