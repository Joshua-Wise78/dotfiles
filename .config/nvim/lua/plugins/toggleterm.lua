-- ~/.config/nvim/lua/plugins/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Or pin to a specific version, e.g. 'v2.9.0'
	config = function()
		require("toggleterm").setup({
			-- size can be a number or a function which is passed the current terminal
			size = 20,
			open_mapping = [[<c-\>]], -- A keymap to open a new terminal
			hide_numbers = true, -- Hide Neovim line numbers in the terminal
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true, -- Whether or not the open mapping applies in insert mode
			persist_size = true,
			-- Direction can be 'vertical', 'horizontal', 'tab', or 'float'
			direction = "float",
			close_on_exit = true, -- Close the terminal window when the process exits
			shell = vim.o.shell, -- Use your default shell
			float_opts = {
				-- Options for floating window, see ':help nvim_open_win'
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal

		-- Floating terminal on top
		local float_term = Terminal:new({
			direction = "float",
			hidden = true,
		})

		function _FLOAT_TERM_TOGGLE()
			float_term:toggle()
		end

		-- Terminal on the bottom
		local bottom_term = Terminal:new({
			direction = "horizontal",
			hidden = true,
		})

		function _BOTTOM_TERM_TOGGLE()
			bottom_term:toggle()
		end

		-- Lazygit terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "double",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function(_)
				vim.cmd("checktime")
			end,
		})

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		-- Set keymaps
		vim.keymap.set(
			"n",
			"<leader>tf",
			"<cmd>lua _FLOAT_TERM_TOGGLE()<CR>",
			{ noremap = true, silent = true, desc = "Toggle floating terminal" }
		)
		vim.keymap.set(
			"n",
			"<leader>tb",
			"<cmd>lua _BOTTOM_TERM_TOGGLE()<CR>",
			{ noremap = true, silent = true, desc = "Toggle bottom terminal" }
		)
		vim.keymap.set(
			"n",
			"<leader>lg",
			"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
			{ noremap = true, silent = true, desc = "Toggle lazygit" }
		)
	end,
}
