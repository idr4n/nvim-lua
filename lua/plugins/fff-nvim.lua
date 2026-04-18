return {
  "dmtrKovalenko/fff.nvim",
  -- enabled = false,
  -- build = "cargo build --release",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  config = function()
    require("fff").setup({
      preview = { enabled = true },
      -- debug = { show_scores = true, }, -- Toggle with F2 or :FFFDebug
      keymaps = {
        move_up = { "<Up>", "<C-p>", "<C-k>" },
        move_down = { "<Down>", "<C-n>", "<C-j>" },
        close = { "<Esc>", "<C-c>" },
        select = { "<CR>", "<C-l>" },
      },
      hl = {
        border = "FloatBorder",
        -- border = "Normal",
      },
      grep = {
        modes = { "fuzzy", "regex", "plain" },
      },
    })
  end,
  keys = {
    {
      "<C-Space>",
      function()
        require("fff").find_files()
      end,
      desc = "FFF Files",
    },
    {
      "<leader>r",
      function()
        require("fff").live_grep()
      end,
      desc = "LiFFFe grep",
    },
    {
      "<leader>r",
      function()
        require("fff").live_grep({ query = vim.fn.expand("<cword>") })
      end,
      mode = { "x" },
      desc = "LiFFFe grep",
    },
  },
}
