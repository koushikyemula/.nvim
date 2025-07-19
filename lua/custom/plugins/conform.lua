return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true }, function(err, did_edit)
          if not err and did_edit then
            vim.notify('Code formatted', vim.log.levels.INFO, { title = 'Conform' })
          end
        end)
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      -- Lua
      lua = { 'stylua' },

      -- Go
      go = { 'goimports', 'gofmt' },

      -- Web technologies
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      vue = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      less = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },

      -- Markdown
      markdown = { 'prettier' },

      -- Python
      python = { 'isort', 'black' },

      -- Shell
      sh = { 'shfmt' },
      bash = { 'shfmt' },

      -- Other
      proto = { 'buf' },
      toml = { 'taplo' },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2', '-ci' },
      },
      prettier = {
        prepend_args = { '--tab-width', '2' },
      },
    },
  },
}
