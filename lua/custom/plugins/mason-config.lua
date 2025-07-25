return {
  {
    'williamboman/mason.nvim',
    lazy = false, -- Load immediately to ensure PATH is set
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
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
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- LSP Servers
          'lua_ls', -- Lua LSP
          'ts_ls', -- TypeScript/JavaScript LSP (renamed from tsserver)
          'gopls', -- Go LSP
          'pyright', -- Python LSP
          'jsonls', -- JSON LSP
          'yamlls', -- YAML LSP
          'html', -- HTML LSP
          'cssls', -- CSS LSP
          'tailwindcss', -- Tailwind CSS LSP
          'rust_analyzer', -- Rust LSP
          'bashls', -- Bash LSP
          'marksman', -- Markdown LSP
        },
        automatic_installation = true,
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- Formatters (for conform.nvim)
          'stylua', -- Lua formatter
          'prettier', -- Web formatter (JS/TS/HTML/CSS/JSON/YAML/MD)
          'black', -- Python formatter
          'isort', -- Python import formatter
          -- Note: gofmt comes with Go installation, not needed in Mason
          'goimports', -- Go import formatter
          'shfmt', -- Shell script formatter
          -- 'terraform_fmt', -- Terraform formatter (removed - not used)
          'buf', -- Protocol Buffers formatter
          'taplo', -- TOML formatter

          -- Linters (optional - can be used via LSP or nvim-lint)
          'markdownlint-cli2', -- Markdown linter
          'shellcheck', -- Shell script linter
          'yamllint', -- YAML linter
        },
        auto_update = false,
        run_on_start = true,
      }
    end,
  },
}
