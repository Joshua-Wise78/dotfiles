vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH

require('mini.basics').setup({
  options = { basic = true, extra_ui = true },
  mappings = { basic = true }
})

local opt = vim.opt

opt.tabstop = 3
opt.shiftwidth = 3
opt.softtabstop = 3
opt.expandtab = true
opt.smartindent = true
opt.relativenumber = true
opt.number = true

opt.clipboard = "unnamedplus"
opt.foldmethod = "expr"                                 
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"        
opt.foldcolumn = "0"                                    
opt.foldtext = ""                                       
opt.foldlevel = 99                                      
opt.foldlevelstart = 99

opt.colorcolumn = "80"

require('mini.indentscope').setup({
	draw = {
		delay = 100,
		animation = require('mini.indentscope').gen_animation.none()
	},
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { desc = 'Clear Search Highlight' })

vim.keymap.set('n', '<leader>e', function()
   local current_file = vim.api.nvim_buf_get_name(0)
   require('mini.files').open(current_file)
end, { desc = 'File Explorer' })

