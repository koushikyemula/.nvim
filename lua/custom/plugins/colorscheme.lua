return {
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        theme = 'wave',
        background = {
          dark = 'wave',
          light = 'lotus',
        },
        colors = {
          theme = {
            all = {
              ui = {
                bg = '#080808',
                bg_gutter = '#080808',
              },
            },
          },
        },
        overrides = function()
          return {
            LineNr = { bg = '#080808' },
            SignColumn = { bg = '#080808' },
            Normal = { bg = '#080808' },
            NormalFloat = { bg = '#080808' },
            FloatBorder = { bg = '#080808' },
            CursorLine = { bg = '#151515' },
            CursorLineNr = { bg = '#080808', fg = '#626262', bold = true },

            TreesitterContext = { bg = '#080808' },
            TreesitterContextLineNumber = { bg = '#080808' },
            TreesitterContextBottom = { bg = '#080808' },
          }
        end,
      }

      vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    name = 'oxocarbon',
    priority = 1000,
    config = function()
      --vim.cmd.colorscheme 'oxocarbon'
    end,
  },
  {
    'ficcdaf/ashen.nvim',
    name = 'ashen',
    priority = 1000,
    config = function()
      --vim.cmd.colorscheme 'ashen'
    end,
  },
}
