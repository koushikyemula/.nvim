return {
  jsonls = {
    settings = {
      json = {
        schema = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  bashls = {
    filetypes = { 'sh', 'zsh' },
  },
  vimls = {
    filetypes = { 'vim' },
  },
  -- tsserver = {},
  ts_ls = {
    single_file_support = true, -- Enable support for standalone TypeScript/JavaScript files
    -- flags = os.getenv 'DEBOUNCE_ESLINT' and {
    --   allow_incremental_sync = false,
    --   debounce_text_changes = 1000,
    -- } or nil,
  },
  gopls = {},
  pyright = {},

  solidity_ls_nomicfoundation = {},
  yamlls = {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml' },
  },

  zls = {},
  clangd = {},
  marksman = {},
  -- "markdownlint-cli2", "markdown-toc"
}
