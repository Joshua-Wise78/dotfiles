local clue = require('mini.clue')

clue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<leader>' },
    { mode = 'x', keys = '<leader>' },

    -- Suround
    { mode = 'n', keys = 's' },
    { mode = 'x', keys = 's' },

    -- Builtin
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = '<C-w>' },

    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
  },
  clues = {
    clue.gen_clues.g(),
    clue.gen_clues.windows(),
    { mode = 'n', keys = '<leader>f', desc = '+Find/Picker' },
    { mode = 'n', keys = '<leader>c', desc = '+LSP & Code' },
    { mode = 'n', keys = '<leader>g', desc = '+Git' },
  },
  window = { delay = 0, config = { border = 'double' } },
})
