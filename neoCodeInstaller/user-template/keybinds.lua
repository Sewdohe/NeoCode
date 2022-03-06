local opts = { noremap = true, silent = true }

local user_mappings = {
  -- NOTE: Insert custom stuff here
  { "<C-x>", "dd", mode = "n", description = "Cut Line", opts = opts }
}

return user_mappings
