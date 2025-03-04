return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        highlight = 'IndentLine',
        char = '│',
      },
      scope = {
        enabled = true,
        highlight = 'IndentLineActive',
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, 'IndentLine', { fg = '#2C2C2C' })
      vim.api.nvim_set_hl(0, 'IndentLineActive', { fg = '#707070' })
      require('ibl').setup(opts)
    end,
  },
}
