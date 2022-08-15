return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
          ["/usr/share/awesome/lib/awful"] = true,
          ["/usr/share/awesome/lib/beautiful"] = true,
          ["/usr/share/awesome/lib/gears"] = true,
          ["/usr/share/awesome/lib/naughty"] = true,
          ["/usr/share/awesome/lib/wibox"] = true,
        },
      },
    },
  },
}
