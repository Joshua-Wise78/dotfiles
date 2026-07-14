local add = MiniDeps.add

add({
  source = 'nvim-treesitter/nvim-treesitter',
  name = 'nvim-treesitter',
  checkout = 'main', 
})

local status_ok, ts = pcall(require, 'nvim-treesitter')
if not status_ok then
  return
end

ts.setup()

local ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc", "markdown" }
ts.install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
   callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
   end,
})
