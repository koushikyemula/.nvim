return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        theme = 'wave', -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'wave',
          light = 'lotus',
        },
      }
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1001,
    init = function()
      -- First load kanagawa for syntax highlighting
      vim.cmd.colorscheme 'kanagawa'

      -- Store catppuccin's syntax highlights
      local stored_highlights = {}
      local syntax_groups = {
        -- Telescope specific groups
        'TelescopeResultsNormal',
        'TelescopeResultsTitle',
        'TelescopeResultsBorder',
        'TelescopeMatching',
        'TelescopeSelection',
        'TelescopeSelectionCaret',
        'TelescopePromptPrefix',
        'TelescopePromptNormal',
        'TelescopePromptTitle',
        'TelescopePromptBorder',
        'TelescopeResultsIdentifier',
        'TelescopeResultsSpecialComment',
        'TelescopeResultsComment',
        'TelescopeResultsConstant',
        'TelescopeResultsField',
        'TelescopeResultsFunction',
        'TelescopeResultsMethod',
        'TelescopeResultsOperator',
        'TelescopeResultsStruct',
        'TelescopeResultsVariable',
        'TelescopeMultiSelection',

        -- Standard vim syntax groups
        'Comment',
        'Constant',
        'String',
        'Character',
        'Number',
        'Boolean',
        'Float',
        'Identifier',
        'Function',
        'Statement',
        'Conditional',
        'Repeat',
        'Label',
        'Operator',
        'Keyword',
        'Exception',
        'PreProc',
        'Include',
        'Define',
        'Macro',
        'PreCondit',
        'Type',
        'StorageClass',
        'Structure',
        'Typedef',
        'Special',
        'SpecialChar',
        'Tag',
        'Delimiter',
        'SpecialComment',
        'Debug',
        'Underlined',
        'Error',
        'Todo',

        -- TreeSitter groups
        '@variable',
        '@variable.builtin',
        '@constant',
        '@constant.builtin',
        '@constant.macro',
        '@string',
        '@string.regex',
        '@string.escape',
        '@string.special',
        '@character',
        '@character.special',
        '@boolean',
        '@number',
        '@float',
        '@function',
        '@function.builtin',
        '@function.call',
        '@function.macro',
        '@method',
        '@method.call',
        '@constructor',
        '@parameter',
        '@keyword',
        '@keyword.function',
        '@keyword.operator',
        '@keyword.return',
        '@conditional',
        '@repeat',
        '@label',
        '@operator',
        '@exception',
        '@type',
        '@type.builtin',
        '@type.qualifier',
        '@type.definition',
        '@storageclass',
        '@structure',
        '@namespace',
        '@include',
        '@preproc',
        '@debug',
        '@tag',
        '@tag.attribute',
        '@tag.delimiter',
        '@punctuation.delimiter',
        '@punctuation.bracket',
        '@punctuation.special',
        '@comment',
        '@property',
        '@field',
        '@module',
        '@variable.member',
        '@text',
        '@text.strong',
        '@text.emphasis',
        '@text.underline',
        '@text.strike',
        '@text.title',
        '@text.literal',
        '@text.uri',
        '@text.math',
        '@text.environment',
        '@text.environment.name',
        '@text.reference',
        '@text.todo',
        '@text.note',
        '@text.warning',
        '@text.danger',

        -- LSP Semantic Token Groups
        '@lsp.type.class',
        '@lsp.type.comment',
        '@lsp.type.decorator',
        '@lsp.type.enum',
        '@lsp.type.enumMember',
        '@lsp.type.function',
        '@lsp.type.interface',
        '@lsp.type.macro',
        '@lsp.type.method',
        '@lsp.type.namespace',
        '@lsp.type.parameter',
        '@lsp.type.property',
        '@lsp.type.struct',
        '@lsp.type.type',
        '@lsp.type.typeParameter',
        '@lsp.type.variable',
        '@lsp.type.keyword',
        '@lsp.type.modifier',
        '@lsp.type.regexp',
      }

      -- Store current highlight settings
      for _, group in ipairs(syntax_groups) do
        stored_highlights[group] = vim.api.nvim_get_hl(0, { name = group })
      end

      -- Load lackluster for its styling
      vim.cmd.colorscheme 'lackluster-hack'

      -- Restore syntax highlighting
      vim.schedule(function()
        for group, hl in pairs(stored_highlights) do
          if hl then
            -- Remove background to keep lackluster's background
            hl.bg = nil
            vim.api.nvim_set_hl(0, group, hl)
          end
        end
      end)
    end,
  },
}
