return {
    "neovim/nvim-lspconfig",
    tag = 'v1.8.0',
    pin = true,
    dependencies = {
      {
	'mason-org/mason.nvim',
        -- tag = 'v1.11.0', -- seems so far no reason to fix version number
	pin = true,
        config = function()
          require("mason").setup()
        end,
      },
      {'mason-org/mason-lspconfig.nvim',
        tag = 'v1.32.0',
	pin = true,
	opts = {
      --    ensure_installed = { "lua_ls",}, -- Add your servers
          automatic_installation = true,
          automatic_enable = true, -- automatically enable installed servers (default in newer versions)
          handlers = { -- not needed for nvim v > 0.10
            function(server_name)
              require('lspconfig')[server_name].setup({})
             end,
	  },
	},
      },
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP
    },

    config = function()

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local buf = vim.api.nvim_get_current_buf() -- или event.buf, если вы внутри автокоманды LspAttach

         -- Info and utility tools 
          vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { buffer = buf, desc = 'LSP: Show LSP information' })
          vim.keymap.set('n', '<leader>lI', '<cmd>NoneLsInfo<cr>', { buffer = buf, desc = 'LSP: Show None-ls information' })
          vim.keymap.set('n', '<leader>lS', '<cmd>SymbolsOutline<cr>', { buffer = buf, desc = 'LSP: Toggle symbols outline' })

          -- Hover tooltips and popups
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buf, desc = 'LSP: Hover documentation' })
          vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { buffer = buf, desc = 'LSP: Signature help' })



          -- Code modification actions
          vim.keymap.set({'n', 'x'}, '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, { buffer = buf, desc = 'LSP: Format document' })

          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = buf, desc = 'LSP: Rename symbol' })
          vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = buf, desc = 'LSP: Rename symbol' })

          vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = buf, desc = 'LSP: Code action' })
          vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = buf, desc = 'LSP: Code action' })
          vim.keymap.set('n', '<leader>lA', function() vim.lsp.buf.code_action({ context = { only = { 'source' } } }) end, { buffer = buf, desc = 'LSP: Source code actions' })

          -- Line diagnostics
          vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { buffer = buf, desc = 'LSP: Line diagnostics' })
          vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { buffer = buf, desc = 'LSP: Line diagnostics' })
          -- Note: <C-W>d is built into Neovim by default for line diagnostics mapping

          -- defined in main kemaps file
          -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = buf, desc = 'LSP: Next diagnostic' })
          -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = buf, desc = 'LSP: Previous diagnostic' })
          -- vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { buffer = buf, desc = 'LSP: Next error' })
          -- vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { buffer = buf, desc = 'LSP: Previous error' })
          -- vim.keymap.set('n', ']w', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { buffer = buf, desc = 'LSP: Next warning' })
          -- vim.keymap.set('n', '[w', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { buffer = buf, desc = 'LSP: Previous warning' })

          -- -- Neovim v0.12+ Workspace Diagnostics feature check
          if vim.fn.has('nvim-0.12') == 1 then
            vim.keymap.set('n', '<leader>lw', vim.diagnostic.get_workspace, { buffer = buf, desc = 'LSP: Workspace diagnostics text' })
          end

          -- Neovim v0.11+ Document Symbol navigation feature check
          if vim.lsp.buf.document_symbol_next then
            vim.keymap.set('n', ']y', vim.lsp.buf.document_symbol_next, { buffer = buf, desc = 'LSP: Next document symbol' })
            vim.keymap.set('n', '[y', vim.lsp.buf.document_symbol_prev, { buffer = buf, desc = 'LSP: Previous document symbol' })
          end

          -- Direct jumps (Will open quickfix list ONLY if multiple targets are found)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'LSP: Go to definition' })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = buf, desc = 'LSP: Go to declaration' })
          vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = buf, desc = 'LSP: Go to type definition' })
          vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { buffer = buf, desc = 'LSP: Go to implementation' })


          -- works via a telescope:
          -- vim.keymap.set('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          -- vim.keymap.set('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        end,
      })

      require("lspconfig").lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }

---
-- Autocompletion config
---
      --[[
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({select = false}),
      
          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),
      
          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
      ]]
    end,
}
