local home = os.getenv('HOME')
  local db = require('dashboard')
  db.preview_file_height = 11
  db.preview_file_width = 70


  -- dashboard.button(
  --   "p",
  --   icons.git.Repo .. " Find project",
  --   ":lua require('telescope').extensions.projects.projects()<CR>"
  -- ),
  -- dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
  -- dashboard.button("t", icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
  -- dashboard.button("o", icons.ui.List .. " Take an Order", ":OpenWork<CR>"),
  -- dashboard.button("s", icons.ui.SignIn .. " Find Session", "<cmd>lua require('persistence').load({last=true})<CR>"),
  -- dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  -- dashboard.button("q", icons.diagnostics.Error .. " Quit", ":qa<CR>"),

  db.custom_center = {
      {icon = '  ',
      desc = 'Recently latest session                  ',
      shortcut = 's',
      action ='SessionLoad'},
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  ':Telescope oldfiles <CR>',
      shortcut = 'r'},
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
      {icon = '  ',
      desc ='File Browser                            ',
      action =  'Telescope file_browser',
      shortcut = 'SPC f b'},
      {icon = '  ',
      desc = 'Find  word                              ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f w'},
      {icon = '  ',
      desc = 'Open Personal dotfiles                  ',
      action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
      shortcut = 'SPC f d'},
    }
