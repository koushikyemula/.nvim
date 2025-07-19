return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = { 'accept', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-j>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',
          Field = '󰜢',
          Variable = '󰆦',
          Class = '󰌗',
          Interface = '󰌗',
          Module = '󰏗',
          Property = '󰖷',
          Unit = '󰖷',
          Value = '󰎠',
          Enum = '󰖷',
          Keyword = '󰌋',
          Snippet = '󰘌',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          EnumMember = '󰖷',
          Constant = '󰏿',
          Struct = '󰌗',
          Event = '󰆾',
          Operator = '󰦕',
          TypeParameter = '󰘦',
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
          treesitter_highlighting = true,
          window = {
            border = 'rounded',
            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      },
    },
    opts_extend = { 'sources.default' },
    config = function(_, opts)
      -- Set up blink.cmp
      require('blink.cmp').setup(opts)

      -- Configure highlight groups to match dark theme
      local function setup_blink_highlights()
        -- Use colors that match most dark themes
        vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = '#181825', fg = '#cdd6f4' })
        vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#585b70' })
        vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = '#313244', fg = '#cdd6f4' })
        vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = '#181825', fg = '#cdd6f4' })
        vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = '#585b70' })
      end

      -- Set highlights immediately
      setup_blink_highlights()

      -- Update highlights when colorscheme changes
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('BlinkCmpTheme', { clear = true }),
        callback = setup_blink_highlights,
      })
    end,
  },
}
