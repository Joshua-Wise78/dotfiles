local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git",
  "clone",
  "--filter=blob:none",
  "--branch=stable",
  lazyrepo,
  lazypath
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = {
	  enabled = true,
	  disabled_plugins = {
		 "gzip",
        	 "matchit",
	 	 "matchparen",
       		 "netrwPlugin",
         	 "tarPlugin",
         	 "tohtml",
        	 "tutor",
        	 "zipPlugin",
	  },
  },
})
