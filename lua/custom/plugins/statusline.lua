return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = {
        normal = {
          --          a = { bg = '#FF5555', fg = '#282A36' },
          a = { bg = '#662222', fg = '#BBBBBB' }, -- Even darker red-brown
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
        insert = {
          --a = { bg = '#61AFEF', fg = '#282A36' },
          a = { bg = '#8B4513', fg = '#BBBBBB' }, -- Darker saddle brown orange
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
        visual = {
          a = { bg = '#FFB86C', fg = '#282A36' },
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
        replace = {
          a = { bg = '#BD93F9', fg = '#282A36' },
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
        command = {
          --a = { bg = '#FF79C6', fg = '#282A36' },
          a = { bg = '#0F4214', fg = '#BBBBBB' }, -- Much darker forest green
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
        inactive = {
          a = { bg = '#44475A', fg = '#F8F8F2' },
          b = { bg = '#2B2B2B', fg = '#F8F8F2' },
          c = { bg = '#303030', fg = '#F8F8F2' },
        },
      },
      component_separators = '|',
      section_separators = '',
    },
    extensions = {
      'quickfix',
      'fugitive',
      'lazy',
      'man',
      'mason',
      {
        filetypes = { 'CompetiTest' },
        sections = {
          lualine_b = { vim.b.competitest_title or 'CompetiTest' },
          lualine_y = { 'searchcount' },
          lualine_z = { 'change this sometime' },
        },
        inactive_sections = {
          lualine_b = { vim.b.competitest_title or 'CompetiTest' },
        },
      },
    },
  },
}
