return {
  "R-nvim/R.nvim",
  ft = { "R" },
  -- lazy = false,
  opts = {
    R_app = "radian",
    -- auto_start = "always",
    -- external_term = "tmux split-window -h -p 40",
    rconsole_width = 60,
    min_editor_width = 45,
  },
  config = function(_, opts)
    require("r").setup(opts)
  end,
}
