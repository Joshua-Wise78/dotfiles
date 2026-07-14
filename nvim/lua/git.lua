require('mini.git').setup()

require('mini.diff').setup({
   view = {
      style = 'sign',
      signs = { add = '+', change = '~', delete = '-'},
   }
})

vim.keymap.set('n', '<leader>go', function()
   require('mini.diff').toggle_overlay(0)
end, { desc = 'Toggle Dff Overlay' })
