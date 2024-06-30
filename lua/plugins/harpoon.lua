return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon" },
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add Harpoon" },
    { "<M-u>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
    { "<M-i>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" },
    { "<M-o>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" },
    { "<M-p>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" },
  },
  dependencies = "nvim-lua/plenary.nvim",
}
