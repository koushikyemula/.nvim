return {
  {
    'rebelot/kanagawa.nvim',
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
                bg = '#080808',        -- Very dark background like lackluster
                bg_gutter = '#080808', -- Dark background for line numbers
              },
            },
          },
        },
        overrides = function()
          return {
            LineNr = { bg = '#080808' },                                    -- Line numbers
            SignColumn = { bg = '#080808' },                                -- Sign column
            Normal = { bg = '#080808' },                                    -- Normal text background
            NormalFloat = { bg = '#080808' },                               -- Float windows
            FloatBorder = { bg = '#080808' },
            CursorLine = { bg = '#151515' },                                -- Current line highlight
            CursorLineNr = { bg = '#080808', fg = '#626262', bold = true }, -- Current line number

            -- TreeSitter Context
            TreesitterContext = { bg = '#080808' },
            TreesitterContextLineNumber = { bg = '#080808' },
            TreesitterContextBottom = { bg = '#080808' },
          }
        end,
      }
      -- Apply the colorscheme
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
