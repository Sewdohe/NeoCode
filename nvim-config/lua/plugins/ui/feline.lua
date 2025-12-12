local ctp_feline = require('catppuccin.special.feline')

require("feline").setup({
    components = ctp_feline.get_statusline(),
})
