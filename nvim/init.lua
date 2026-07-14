vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path })
  vim.cmd('packadd mini.nvim | helptags ALL')
end
require('mini.deps').setup({ path = { package = path_package } })

local now, later = MiniDeps.now, MiniDeps.later

now(function() require('theme') end)
now(function() require('starter') end)
now(function() require('core') end)
now(function() require('ui') end)
now(function() require('finder') end)
now(function() require('git') end)

now(function()
   require('mini.pairs').setup()
   require('mini.surround').setup({
      mappings = {
         add = 'sa',
         delete= 'sd',
         find = 'sf',
         find_left = 'sF',
         highlight = 'sh',
         replace = 'sr',
         update_n_lines = 'sn',
      }
   })
   require('mini.extra').setup()
   require('mini.files').setup()
   require('mini.snippets').setup()

   require('mini.completion').setup({
      window = {
         info = { border = 'double' },
         signature = { border = 'double' },
      }
   })
end)

later(function() require('lsp') end)
later(function() require('treesitter') end)
-- later(function() require('ai') end)
