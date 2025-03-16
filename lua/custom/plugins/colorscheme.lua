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
        transparent = true, -- Enable transparency
        colors = {
          theme = {
            all = {
              ui = {
                -- bg = '#080808', -- Commented out for transparency
                -- bg_gutter = '#080808', -- Commented out for transparency
              },
            },
          },
        },
        overrides = function()
          return {
            -- SignColumn = { bg = '#080808' },
            Normal = { bg = 'NONE' }, -- Use NONE for transparency
            -- NormalFloat = { bg = '#080808' },
            -- FloatBorder = { bg = '#080808' },
            CursorLine = { bg = '#151515' },

            -- LineNr = { bg = '#080808', fg = '#515151' },
            LineNr = { bg = 'NONE', fg = '#515151' },
            -- CursorLineNr = { bg = '#080808', fg = '#B0B0B0' },
            CursorLineNr = { bg = 'NONE', fg = '#B0B0B0' },

            -- TreesitterContext = { bg = '#080808' },
            -- TreesitterContextLineNumber = { bg = '#080808' },
            -- TreesitterContextBottom = { bg = '#080808' },
            TreesitterContext = { bg = 'NONE' },
            TreesitterContextLineNumber = { bg = 'NONE' },
            TreesitterContextBottom = { bg = 'NONE' },
          }
        end,
      }
      vim.cmd.colorscheme 'kanagawa'

      vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
    end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    name = 'oxocarbon',
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
    end,
  },
  {
    'ricardoraposo/nightwolf.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nightwolf').setup {
        theme = 'black',
        italic = true,
        transparency = false,
        palette_overrides = {},
        highlight_overrides = {},
      }
      vim.opt.termguicolors = true
      vim.opt.background = 'dark'
    end,
  },
  {
    'ficcdaf/ashen.nvim',
    name = 'ashen',
    priority = 1000,
    config = function() end,
  },
  {
    'wtfox/jellybeans.nvim',
    priority = 1000,
    config = function()
      require('jellybeans').setup()
    end,
  },
}
