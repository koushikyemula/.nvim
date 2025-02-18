return {
--   'windwp/nvim-autopairs',
--   event = 'InsertEnter',

--   dependencies = { 'hrsh7th/nvim-cmp' },
--   config = function()
--     require('nvim-autopairs').setup {}

--     vim.keymap.set({ 'i', 'n', 'v' }, '<M-[>', function()
--       local disabled = not vim.g.minipairs_disable
--       vim.g.minipairs_disable = disabled
--       vim.api.nvim_echo({ { 'Autopairing: ' .. tostring(not disabled) } }, true, {})
--     end, { desc = 'Toggle pairing' })

--     local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--     local cmp = require 'cmp'
--     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
--   end,
}
