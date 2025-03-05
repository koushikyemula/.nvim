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
    picker = {
      debug = {
        scores = true,
      },
      layout = {
        preset = 'ivy',

        cycle = false,
      },
      layouts = {
        ivy = {
          layout = {
            box = 'vertical',
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = 'top',
            title = ' {title} {live} {flags}',
            title_pos = 'left',
            { win = 'input', height = 1, border = 'bottom' },
            {
              box = 'horizontal',
              { win = 'list',    border = 'none' },
              { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
            },
          },
        },
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input',   height = 1,          border = 'bottom' },
            { win = 'list',    border = 'none' },
            { win = 'preview', title = '{preview}', height = 0.4,     border = 'top' },
          },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {

            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },

            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
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
    {
      '<leader>se',
      function()
        require('snacks').explorer()
      end,
      desc = '[S]earch [E]xplorer',
    },
    {
      '<leader>rr',
      function()
        require('snacks').rename.rename_file()
      end,
      desc = '[R]ename Current File',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>bd',
      function()
        require('snacks').bufdelete()
      end,
      desc = '[B]uffer [D]elete (Confirm)',
    },
    {
      '<leader><tab>',
      function()
        require('snacks').picker.files()
      end,
      desc = '[S]nacks Find Files',
    },
    {
      '<leader>sn',
      function()
        require('snacks').picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim Config',
    },
    {
      '<leader>lg',
      function()
        require('snacks').picker.grep()
      end,
      desc = '[L]ive [G]rep (Snacks)',
    },
    {
      '<leader>sw',
      function()
        require('snacks').picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sk',
      function()
        require('snacks').picker.keymaps { layout = 'ivy' }
      end,
      desc = '[S]earch [K]eymaps',
    },
    -- Git integration
    {
      '<leader>gb',
      function()
        require('snacks').picker.git_branches { layout = 'select' }
      end,
      desc = '[G]it [B]ranches',
    },
    -- Additional utilities
    {
      '<leader>sc',
      function()
        require('snacks').picker.colorschemes { layout = 'ivy' }
      end,
      desc = '[S]earch [C]olorscheme',
    },
    {
      '<leader>sh',
      function()
        require('snacks').picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
  },
}
