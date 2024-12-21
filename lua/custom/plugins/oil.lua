return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Don't automatically disable Netrw
    default_file_explorer = false,
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = function()
    require('oil').setup {
      default_file_explorer = false,
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    -- Keep your existing Netrw binding
    vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open Netrw' })
  end,
}
