return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('snacks').setup {
      bigfile = { enabled = true },
      statuscolumn = { enabled = true },
      quickfile = { enabled = false },
      zen = { enabled = true },
      image = {
        enabled = true,
        doc = {
          enabled = true,
          inline = false,
          float = true,
          max_width = 60,
          max_height = 30,
        },
      },
    }
  end,
  keys = {
    {
      '<leader>Z',
      function()
        Snacks.zen.zen()
      end,
      desc = 'Zen mode',
    },
    {
      '<leader>ti',
      function()
        Snacks.image.hover()
      end,
      desc = 'Toggle image preview',
    },
  },
}
