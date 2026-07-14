MiniDeps.add('neovim/nvim-lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.general.positionEncodings = { "utf-16" }

-- Python (Strict Pyright)
vim.lsp.config('pyright', {
   capabilities = capabilities,
   before_init = function(_, config)
      -- Dynamically set the python path to the uv .venv
      local venv_path = config.root_dir .. '/.venv/bin/python'
      if vim.fn.executable(venv_path) == 1 then
         config.settings.python.pythonPath = venv_path
      end
   end,
   settings = {
      python = {
         analysis = {
            typeCheckingMode = "strict", 
            diagnosticMode = "workspace",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            inlayHints = {
               variableTypes = true,
               functionReturnTypes = true,
               callArgumentNames = true,
               pytestParameters = true
            }
         }
      }
   }
})

-- C/C++ (Clangd)
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",           
    "--header-insertion=iwyu" 
  }
})

vim.lsp.config('ruff', {
   capabilities = capabilities,
   init_options = {
      settings = {
         lineLength = 80,
         lint = {
            select = {
               "E",
               "F",
               "D",
               "I",
               "N",
               "UP",
               "ANN",
               "RUF",
            }
         }
      }
   }
})

-- Enable your language servers natively
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('clangd')
vim.lsp.enable('marksman')

-- Attach keymaps and omnifunc ONLY when a language server connects
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Attach mini.completion to the LSP
    vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    
    -- Navigation & Hints
    vim.keymap.set('n', 'gd', function()
      vim.cmd("normal! m'") -- Manually drop a breadcrumb in the jump list
      vim.lsp.buf.definition()
    end, { buffer = bufnr, desc = 'Go to Definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })

    
    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename Symbol' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
    
    -- Errors & Diagnostics
    vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { buffer = bufnr, desc = 'Show Line Diagnostics' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'Previous Diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'Next Diagnostic' })
    
    -- Populate the location list with all buffer diagnostics and open it
   vim.keymap.set('n', '<leader>cl', function()
     vim.diagnostic.setloclist()
   end, { buffer = bufnr, desc = 'Diagnostic List (LocList)' })
    
   local format_filter = function(c)
      if vim.bo.filetype == "python" then
         return c.name == "ruff"
      end
      return true
   end

    -- Formatting
    vim.keymap.set('n', '<leader>fm', function()
       vim.lsp.buf.format({
          async = true,
          filter = format_filter
       })
    end, { buffer = bufnr, desc = 'Format Document' })

    if client and client:supports_method("textDocument/formatting") then
       vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
             vim.lsp.buf.format({
                async = false,
                filter = format_filter
             })
         end
       })
      end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})

vim.diagnostic.config({
   underline = true,
   virtual_text = {
      spacing = 4,
      prefix= '●',
      severity_sort = true
   },
   signs = true,
   update_in_insert = true
})
