return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- Basic Harpoon setup
      harpoon:setup()

      -- Keybindings
      vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "Harpoon Prepend File" })
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Quick Menu" })

      -- Select files
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon Select File 1" })
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Harpoon Select File 2" })
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Harpoon Select File 3" })
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Harpoon Select File 4" })

      -- Replace files at specific indices
      vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end, { desc = "Harpoon Replace File 1" })
      vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end, { desc = "Harpoon Replace File 2" })
      vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end, { desc = "Harpoon Replace File 3" })
      vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end, { desc = "Harpoon Replace File 4" })
    end
  }
}