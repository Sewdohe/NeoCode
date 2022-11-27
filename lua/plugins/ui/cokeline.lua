local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex

local colors = require('dracula').colors()

local red = colors.red
local yellow = colors.yellow
local space = {text = " "}
local dark = colors.bg
local text = colors.fg
local grey = colors.gutter_fg
local light = colors.comment
local high = colors.purple

require("cokeline").setup(
    {
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
        components = {
            {
                text = function(buffer)
                    if buffer.index ~= 1 then
                        return ""
                    end
                    return ""
                end,
                bg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                fg = dark
            },
            space,
            {
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
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename .. "⠀"
                end,
                style = function(buffer)
                    return buffer.is_focused and "bold" or nil
                end
            },
            {
                text = function(buffer)
                  return buffer.is_modified and '' or ''
                end,
                fg = function(buffer)
                  return buffer.is_modified and colors.red or colors.menu
                end,
                delete_buffer_on_left_click = true,
                truncation = { priority = 1 },
            },
            -- diagnostics
            {
              text = function(buffer)
                return
                  (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
                  or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
                  or ''
              end,
              fg = function(buffer)
                return
                  (buffer.diagnostics.errors ~= 0 and colors.red)
                  or (buffer.diagnostics.warnings ~= 0 and colors.yellow)
                  or nil
              end,
              truncation = { priority = 1 },
            },
            space,
            {
                text = "",
                fg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                bg = dark
            }
        }
    }
)
