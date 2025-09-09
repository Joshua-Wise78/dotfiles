local keymap = vim.keymap
local opts = { noremap = true, silemt = true }

keymap.set("n", "x", '"_x')

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

keymap.set("n", "<C-a>", "gg<S-v>G")

-- Keymaps for incrementing and decrementing numbers
vim.keymap.set("n", "<leader>+", "<C-a>" )
vim.keymap.set("n", "<leader>-", "<C-x>" )

-- Keymaps for splitting windows
vim.keymap.set("n", "ss", ":split<CR>" )
vim.keymap.set("n", "sv", ":vsplit<CR>" )

-- Keymaps for resizing windows
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Git commands
keymap.set("n", "<leader>gg", ":Neogit<CR>")

-- Formatting
keymap.set({ "n", "v"}, "<leader>f", function ()
  require("conform").format({
    lsp_fallback = true,
    asyn = false,
    timeout_ms = 500,
  })
end, { desc = "Format file or range" })
