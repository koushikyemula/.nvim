return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'b0o/schemastore.nvim' },
    { 'hrsh7th/cmp-nvim-lsp', optional = true },
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

    -- Setup capabilities first
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Use blink.cmp capabilities instead of nvim-cmp
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
      capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
    else
      -- Fallback to nvim-cmp if blink is not available
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if has_cmp then
        capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
      end
    end

    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(require 'custom.plugins.lsp.servers'),
      automatic_installation = true,
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = require('custom.plugins.lsp.servers')[server_name],
            filetypes = (require('custom.plugins.lsp.servers')[server_name] or {}).filetypes,
          }
        end,
      },
    }
    require('lspconfig.ui.windows').default_options.border = 'single'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', function()
          require('snacks').picker.lsp_definitions()
        end, 'Goto Definition')
        map('gr', function()
          require('snacks').picker.lsp_references()
        end, 'Goto References')
        map('gi', function()
          require('snacks').picker.lsp_implementations()
        end, 'Goto Implementation')
        map('go', function()
          require('snacks').picker.lsp_type_definitions()
        end, 'Type Definition')
        map('<leader>ws', function()
          require('snacks').picker.lsp_workspace_symbols()
        end, 'Workspace Symbols')

        map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
        map('K', function()
          vim.lsp.buf.hover()
          -- Prevent entering the hover window
          vim.cmd [[stopinsert]]
        end, 'Hover Documentation')
        map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', 'Goto Definition in Vertical Split')

        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('<leader>cs', vim.lsp.buf.signature_help, 'Display Signature Information')
        map('<leader>ra', vim.lsp.buf.rename, 'Rename all references')
        map('<leader>cf', vim.lsp.buf.format, 'Format')
        map('<leader>ci', function()
          require('snacks').picker.lsp_implementations()
        end, 'Implementation')

        map('<leader>Wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
        map('<leader>Wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
        map('<leader>Wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders')

        -- Document highlight removed
      end,
    })

    -- Capabilities already defined above

    -- Remove the separate setup_handlers call since it's now part of the setup
    -- local mason_lspconfig = require 'mason-lspconfig'
    -- mason_lspconfig.setup_handlers {
    --   function(server_name)
    --     require('lspconfig')[server_name].setup {
    --       capabilities = capabilities,
    --       settings = require('custom.plugins.lsp.servers')[server_name],
    --       filetypes = (require('custom.plugins.lsp.servers')[server_name] or {}).filetypes,
    --     }
    --   end,
    -- }

    -- Biome LSP configuration
    require('lspconfig').biome.setup {
      settings = {
        biome = {
          lint = {
            rules = {
              nursery = {
                useSortedClasses = 'off',
              },
            },
          },
        },
      },
    }

    -- Gleam LSP
    -- For some reason mason doesn't work with gleam lsp
    require('lspconfig').gleam.setup {
      cmd = { 'gleam', 'lsp' },
      filetypes = { 'gleam' },
      root_dir = require('lspconfig').util.root_pattern('gleam.toml', '.git'),
      capabilities = capabilities,
    }

    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end
  end,
}
