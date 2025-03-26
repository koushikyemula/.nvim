return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    { '<leader>pv', vim.cmd.Ex, desc = 'Open Netrw' },
  },
}
