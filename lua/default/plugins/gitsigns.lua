return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>dv', '<cmd>DiffviewFileHistory %<cr>', desc = 'View git history for current file' },
      { '<leader>dh', '<cmd>DiffviewFileHistory<cr>',   desc = 'View git history for repo' },
      { '<leader>dt', function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewOpen')
          else
            vim.cmd('DiffviewClose')
          end
        end, desc = 'Toggle Diffview' },
    },
    opts = {
      enhanced_diff_hl = true,
      use_icons = true,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
      },
    },
    config = function(_, opts)
      require('diffview').setup(opts)

      local function set_diff_highlights()
        local is_dark = vim.o.background == 'dark'

        if is_dark then
          vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = '#2e4b2e', bold = true })
          vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = '#4c1e15', bold = true })
          vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = '#45565c', bold = true })
          vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = '#996d74', bold = true })
        else
          vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = 'palegreen', bold = true })
          vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = 'tomato', bold = true })
          vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = 'lightblue', bold = true })
          vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = 'lightpink', bold = true })
        end
      end

      set_diff_highlights()

      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('DiffColors', { clear = true }),
        callback = set_diff_highlights
      })
    end,
  },
}
