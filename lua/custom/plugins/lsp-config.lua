return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'b0o/schemastore.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
  },
  config = function()
    require('mason').setup {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(require 'custom.plugins.lsp.servers'),
    }
    require('lspconfig.ui.windows').default_options.border = 'single'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        map('gr', require('telescope.builtin').lsp_references, 'Goto References')
        map('gi', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        map('go', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        map('<leader>p', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        map('<leader>ws', require('telescope.builtin').lsp_workspace_symbols, 'Workspace Symbols')
        map('<leader>Ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

        map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
        map('K', function()
          vim.lsp.buf.hover()
          -- Prevent entering the hover window
          vim.cmd [[stopinsert]]
        end, 'Hover Documentation')
        map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', 'Goto Definition in Vertical Split')

        local wk = require 'which-key'
        wk.add {
          { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action' },
          { '<leader>cA', vim.lsp.buf.range_code_action, desc = 'Range Code Actions' },
          { '<leader>cs', vim.lsp.buf.signature_help, desc = 'Display Signature Information' },
          { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename all references' },
          { '<leader>cf', vim.lsp.buf.format, desc = 'Format' },
          { '<leader>ci', require('telescope.builtin').lsp_implementations, desc = 'Implementation' },

          -- W = {
          --   name = "+Workspace",
          --   a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
          --   r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
          --   l = {
          --     function()
          --       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          --     end,
          --     "List Folders",
          --   },
          -- },

          { '<leader>Wa', vim.lsp.buf.add_workspace_folder, desc = 'Workspace Add Folder' },
          { '<leader>Wr', vim.lsp.buf.remove_workspace_folder, desc = 'Workspace Remove Folder' },
          {
            '<leader>Wl',
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = 'Workspace List Folders',
          },
        }

        -- Document highlight removed
      end,
    })

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          -- on_attach = require("plugins.lsp.on_attach").on_attach,
          settings = require('custom.plugins.lsp.servers')[server_name],
          filetypes = (require('custom.plugins.lsp.servers')[server_name] or {}).filetypes,
        }
      end,
    }

    -- Gleam LSP
    -- For some reason mason doesn't work with gleam lsp
    require('lspconfig').gleam.setup {
      cmd = { 'gleam', 'lsp' },
      filetypes = { 'gleam' },
      root_dir = require('lspconfig').util.root_pattern('gleam.toml', '.git'),
      capabilities = capabilities,
    }

    vim.diagnostic.config {
      title = false,
      underline = false,
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        source = 'if_many',
        style = 'minimal',
        border = 'rounded',
        header = '',
        prefix = '',
      },
    }

    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end
  end,
}
