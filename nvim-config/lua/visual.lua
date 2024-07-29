--[[
___      ___ ___  ________  ___  ___  ________  ___ |
\\  \    /  /|\  \|\   ____\|\  \|\  \|\   __  \|\  \
\ \  \  /  / | \  \ \  \___|\ \  \\\  \ \  \|\  \ \  \
 \ \  \/  / / \ \  \ \_____  \ \  \\\  \ \   __  \ \  \
  \ \    / /   \ \  \|____|\  \ \  \\\  \ \  \ \  \ \  \____
   \ \__/ /     \ \__\____\_\  \ \_______\ \__\ \__\ \_______\
    \|__|/       \|__|\_________\|_______|\|__|\|__|\|_______|
                     \|_________|
--]] local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    -- This message was annoying. Leaving it just in-case though
    -- vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.cmd([[
  highlight Comment cterm=italic gui=italic
  
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none

  highlight WinSeparator guibg=None
]])

vim.opt.laststatus = 3
vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋'
})

vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = true

vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = false
vim.g.moonlight_italic_variables = false
vim.g.moonlight_contrast = true
vim.g.moonlight_borders = true
vim.g.moonlight_disable_background = false

local status_ok, vscode = pcall(require, "vscode")
if not status_ok then
    return
end

vscode.setup({
    -- Enable transparent background
    transparent = false,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true
})

require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "macchiato"
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        mason = true,
        barbar = true,
        nvim_surround = true,
        gitsigns = true,
        -- nvimtree = true,
        neotree = true,
        telescope = true,
        notify = true,
        mini = false,
        barbecue = {
            dim_dirname = true, -- directory name is dimmed by default
            bold_basename = true,
            dim_context = false,
            alt_background = false
        }
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    }
})

-- vim.cmd[[colorscheme dracula]]
vim.cmd.colorscheme "catppuccin"
