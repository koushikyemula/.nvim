return {
  jsonls = {
    settings = {
      json = {
        schema = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  terraformls = {
    cmd = { 'terraform-ls' },
    arg = { 'server' },
    filetypes = { 'terraform', 'tf', 'terraform-vars' },
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
    flags = os.getenv 'DEBOUNCE_ESLINT' and {
      allow_incremental_sync = false,
      debounce_text_changes = 1000,
    } or nil,
  },
  eslint = {
    settings = {
      -- Improve handling of Next.js projects
      workingDirectory = { mode = 'auto' },
      -- Longer timeout to avoid timeouts with larger projects
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      },
      -- Handle missing plugins gracefully
      experimental = {
        useFlatConfig = false
      }
    },
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
