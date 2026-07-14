local add = MiniDeps.add

add({ source = 'Robitx/gp.nvim' })

local status_ok, gp = pcall(require, 'gp')
if not status_ok then return end

gp.setup({
   providers = {
      openai = {
         disable = false,
         endpoint = "http://127.0.0.1:1234/v1/chat/completions",
         secret = "lm-studio",
      },
      copilot = { disable = true },
      anthropic = { disable = true },
      googleai = { disable = true },
   },

   agents = {
      {
         name = "LocalLM",
         provider = "openai", 
         chat = true,
         command = true,
         model = { model = "local-model" },
         system_prompt = "You are a highly precise, expert AI coding assistant.",
      },
   },

   default_chat_agent = "LocalLM",
   default_command_agent = "LocalLM",

   hooks = {
      ChatWithContext = function(gp, params)
         local buf = vim.api.nvim_get_current_buf()
         local file_path = vim.fn.expand("%:~:.")
         local file_type = vim.bo.filetype
         local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

         local context_lines = {
            string.format("Context from: `%s`", file_path),
            "",
            "```" .. file_type
         }
         
         for i, line in ipairs(lines) do
            table.insert(context_lines, string.format("%4d | %s", i, line))
         end
         
         table.insert(context_lines, "```")
         table.insert(context_lines, "")

         vim.cmd("GpChatNew " .. (params.args or ""))
         vim.api.nvim_put(context_lines, "c", true, true)

         vim.cmd("startinsert")
      end,
   },
})
   

--- Keymaps ---

-- Chat toggle & management
vim.keymap.set({ "n", "i" }, "<leader>ac", "<cmd>GpChatToggle split<cr>", { silent = true, nowait = true, desc = "Toggle AI Chat (Split)" })
vim.keymap.set({ "n" },       "<leader>an", "<cmd>GpChatNew split<cr>",    { silent = true, nowait = true, desc = "New AI Chat" })

-- Context Injection (Visual Paste)
vim.keymap.set({ "v" },       "<leader>ac", ":<C-u>'<,'>GpChatPaste split<cr>", { silent = true, nowait = true, desc = "Paste Selection to Chat" })

-- Inline commands (Split for Normal and Visual)
vim.keymap.set({ "n" },       "<leader>ai", "<cmd>GpImplement<cr>",             { silent = true, nowait = true, desc = "Inline Rewrite/Implement" })
vim.keymap.set({ "v" },       "<leader>ai", ":<C-u>'<,'>GpImplement<cr>",        { silent = true, nowait = true, desc = "Inline Rewrite/Implement" })

vim.keymap.set({ "n" },       "<leader>ap", "<cmd>GpChatRespond<cr>",            { silent = true, nowait = true, desc = "Force AI Response" })
vim.keymap.set({ "v" },       "<leader>ap", ":<C-u>'<,'>GpChatRespond<cr>",       { silent = true, nowait = true, desc = "Force AI Response" })

-- Working File Context (Custom Hook with line numbers)
vim.keymap.set({ "n" },       "<leader>aw", "<cmd>GpChatWithContext split<cr>", { silent = true, nowait = true, desc = "AI Chat with Working File" })

-- Whole File Native Context (Fast, no line numbers)
vim.keymap.set({ "n" },       "<leader>af", "<cmd>%GpChatNew split<cr>",         { silent = true, nowait = true, desc = "New Chat with Whole File" })
vim.keymap.set({ "n" },       "<leader>aF", "<cmd>%GpChatPaste split<cr>",       { silent = true, nowait = true, desc = "Paste Whole File to Chat" })
