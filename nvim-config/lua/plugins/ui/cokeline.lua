local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex

local colors = require('dracula').colors()

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

local red = colors.red
local yellow = colors.yellow
local space = {
    text = " "
}
local dark = colors.bg
local text = colors.fg
local grey = colors.gutter_fg
local light = colors.comment
local high = catppccn_colors.blue

-- separator_style = { "", "" },

require("cokeline").setup({
    default_hl = {
        fg = function(buffer)
            if buffer.is_focused then
                return dark
            end
            return text
        end,
        bg = function(buffer)
            if buffer.is_focused then
                return high
            end
            return grey
        end
    },
    components = {{
        text = function(buffer)
            return " "
        end,
        bg = function(buffer)
            if buffer.is_focused then
                return catppccn_colors.base
            end
            return catppccn_colors.base
        end,
        fg = function(buffer)
            if buffer.is_focused then
                return high
            end
            return grey
        end
    }, space, {
        text = function(buffer)
            if is_picking_focus() or is_picking_close() then
                return buffer.pick_letter .. " "
            end

            return buffer.devicon.icon
        end,
        fg = function(buffer)
            if is_picking_focus() then
                return colors.yellow
            end
            if is_picking_close() then
                return colors.red
            end

            if buffer.is_focused then
                return colors.black
            else
                return colors.bright_magenta
            end
        end,
        style = function(_)
            return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
        end
    }, {
        text = function(buffer)
            return buffer.unique_prefix .. buffer.filename .. "⠀"
        end,
        style = function(buffer)
            return buffer.is_focused and "bold" or nil
        end
    }, {
        text = function(buffer)
            return buffer.is_modified and '' or ''
        end,
        fg = function(buffer)
            return buffer.is_modified and colors.menu or colors.menu
        end,
        delete_buffer_on_left_click = true,
        truncation = {
            priority = 1
        }
    }, space, -- diagnostics
    {
        text = function(buffer)
            return (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors) or
                       (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings) or ''
        end,
        fg = function(buffer)
            return (buffer.diagnostics.errors ~= 0 and colors.menu) or
                       (buffer.diagnostics.warnings ~= 0 and colors.menu) or nil
        end,
        truncation = {
            priority = 1
        }
    }, space, {
        text = " ",
        fg = function(buffer)
            if buffer.is_focused then
                return high
            end
            return grey
        end,
        bg = catppccn_colors.base
    }},
    sidebar = {
        filetype = 'NvimTree',
        components = {{
            text = '  NvimTree',
            fg = yellow,
            style = 'bold'
        }}
    }
})
