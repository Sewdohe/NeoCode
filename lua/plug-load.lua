local lspOK, _ = pcall(require, 'pluginconfig.lsp')
if not lspOK then
  return
end

local cmpOK, _ = pcall(require, 'pluginconfig.cmp')
if not cmpOK then
  return
end

local snippyOK, _ = pcall(require, 'pluginconfig.snippy')
if not snippyOK then
  return
end

local nvimtreeOK, nvimtree = pcall(require, 'pluginconfig.nvimtree')
if not nvimtreeOK then
  return
end

local lualineOK, _ = pcall(require, 'pluginconfig.lline')
if not lualineOK then
  return
end

local apairsOK, _ = pcall(require, 'nvim-autopairs')
if not apairsOK then
  return
end

local bufflineOK, _ = pcall(require, 'bufferline')
if not bufflineOK then
  return
end

local wspacesOK, _ = pcall(require, 'workspaces')
if not wspacesOK then
  return
end

local teleOkay, telescope = pcall(require, 'telescope')
if not teleOkay then
  return
end

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- Load FZF into telescope
-- require('telescope').load_extension('fzf')
telescope.load_extension("workspaces")

local rtoolsOkay, _ = pcall(require, 'rust-tools')
if not rtoolsOkay then
  return
end

local teleOkay, telescope = pcall(require, 'telescope')
if not teleOkay then
  return
end