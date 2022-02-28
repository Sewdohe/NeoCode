local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

-- Buffer line setup
bufferline.setup({
	options = {
    tab_size = 20,
		indicator_icon = "▎",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		close_command = "Bdelete %d",
		right_mouse_command = "Bdelete! %d",
		left_trunc_marker = "",
		right_trunc_marker = "",
		offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
		show_tab_indicators = true,
    show_buffer_close_icons = true,
    show_buffer_icons = true,
		separator_style = "padded_slant",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    always_show_bufferline = false
	},
})
