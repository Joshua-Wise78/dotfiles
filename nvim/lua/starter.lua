local starter = require('mini.starter')

starter.setup({
  items = {
    { 
      name = 'Browser',         
      action = function() require('mini.files').open() end, 
      section = 'Quick Links' 
    },
    { 
      name = 'Command history', 
      action = function() vim.api.nvim_feedkeys('q:', 'm', false) end, 
      section = 'Quick Links' 
    },
    { name = 'Files',           action = 'Pick files',     section = 'Quick Links' },
    { name = 'Help tags',       action = 'Pick help',      section = 'Quick Links' },
    { name = 'Live grep',       action = 'Pick grep_live', section = 'Quick Links' },
    { name = 'Old files',       action = 'Pick oldfiles',  section = 'Quick Links' },
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning('center', 'center'),
  },
})

-- Force mini.starter to open if Neovim is launched with a directory argument
vim.api.nvim_create_autocmd("VimEnter", {
   callback = function()
      if vim.fn.argc() == 1 then
         local stat = vim.loop.fs_stat(vim.fn.argv(0))
         if stat and stat.type == "directory" then
            require("mini.starter").open()
         end
      end
   end,
})
