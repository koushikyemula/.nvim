return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    styles = {
      snacks_image = {
        relative = 'editor',
        border = 'rounded',
        focusable = false,
        row = 1,
        col = -1,
      },
    },
    bigfile = { enabled = true },
    statuscolumn = { enabled = true },
    quickfile = { enabled = false },
    zen = { enabled = true },
    image = {
      enabled = true,
      doc = {
        inline = false,
        max_width = 50,
        max_height = 30,
      },
    },
  },
  init = function()
    _G.Snacks = require 'snacks'
  end,
  keys = {
    {
      '<leader>Z',
      function()
        Snacks.zen.zen()
      end,
      desc = 'Zen mode',
    },
  },
}
