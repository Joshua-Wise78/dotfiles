require('mini.pick').setup()

vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<CR>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<CR>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<CR>', { desc = 'Find Buffers' })

vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic scope="current"<CR>', { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>fD', '<cmd>Pick diagnostic scope="all"<CR>', { desc = 'Workspace Diagnostics' })

vim.keymap.set('n', '<leader>fs', '<cmd>Pick lsp scope="document_symbol"<CR>', { desc = 'Find Document Symbols' })
vim.keymap.set('n', '<leader>fS', '<cmd>Pick lsp scope="workspace_symbol"<CR>', { desc = 'Find Workspace Symbols' })
