return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        -- Set a very dim color for normal indent lines
        highlight = { 'NonText' },
        char = '│',
      },
      scope = {
        enabled = true, -- enable scope highlighting
        show_start = false, -- don't show the start of the scope
        show_end = false, -- don't show the end of the scope
      },
    },
  },
}
