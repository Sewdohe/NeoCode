local status_ok, floaterm = pcall(require, "floaterm")
if not status_ok then
    return
end

floaterm.setup({
    border = false,
    size = {
        h = 60,
        w = 70
    },

    -- to use, make this func(buf)
    mappings = {
        sidebar = nil,
        term = nil
    },

    -- Default sets of terminals you'd like to open
    terminals = {{
        name = "Terminal"
    }, -- cmd can be function too
    {
        name = "Lazygit",
        cmd = "lazygit"
    } -- More terminals
    }
})
