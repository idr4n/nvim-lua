return {
  "Shatur/neovim-session-manager",
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("session_manager").load_current_dir_session() end, desc = "Restore Current Dir Session" },
      { "<leader>ql", function() require("session_manager").load_last_session() end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("session_manager").delete_current_dir_session() end, desc = "Delete Current Dir Session" },
    },
  config = function()
    require("session_manager").setup({})
  end,
}
