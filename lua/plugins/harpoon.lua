return {
    "ThePrimeagen/harpoon",
    keys = {
        { "<leader><tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },
        { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
        { "<c-s>", "<cmd>lua require('harpoon.ui').nav_next()<cr>" },
        -- { "<c-x>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>" },
        { "<M-u>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
        { "<M-i>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" },
        { "<M-o>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" },
        { "<M-p>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" },
        { "<M-[>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>" },
        { "<M-]>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>" },
    },
    dependencies = "nvim-lua/plenary.nvim",
}
