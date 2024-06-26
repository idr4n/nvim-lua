return {
  "jackMort/ChatGPT.nvim",
  -- event = "VeryLazy",
  cmd = { "ChatGPT", "ChatGPTEditWithInstructions" },
  keys = {
    { "<leader>jc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    { "<leader>je", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v" } },
    { "<leader>jg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
    { "<leader>jt", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
    { "<leader>jk", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
    { "<leader>jd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
    { "<leader>ja", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
    { "<leader>jo", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
    { "<leader>js", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
    { "<leader>jf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
    { "<leader>jx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
    { "<leader>jr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
    {
      "<leader>jl",
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      desc = "Code Readability Analysis",
      mode = { "n", "v" },
    },
  },
  opts = {
    -- api_key_cmd = "op read op://Personal/openAIApiKey/credential --no-newline",
    openai_params = {
      -- model = "gpt-4",
      -- model = "gpt-4-turbo-preview",
      model = "gpt-4o",
      max_tokens = 4096,
    },
    openai_edit_params = {
      -- model = "gpt-4",
      -- model = "gpt-4-turbo-preview",
      model = "gpt-4o",
      max_tokens = 4096,
    },
    chat = {
      keymaps = {
        close = "<C-c>",
        yank_last = "<C-y>",
        yank_last_code = "<C-k>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
        cycle_modes = "<C-f>",
        next_message = "<C-j>",
        prev_message = "<C-k>",
        select_session = "<Space>",
        rename_session = "r",
        delete_session = "d",
        draft_message = "<C-r>",
        edit_message = "e",
        delete_message = "d",
        toggle_settings = "<C-o>",
        toggle_sessions = "<C-p>",
        toggle_help = "<C-h>",
        toggle_message_role = "<C-r>",
        toggle_system_role_open = "<C-s>",
        stop_generating = "<C-x>",
      },
    },
    popup_window = {
      win_options = { winhighlight = "TelescopeNormal:TelescopeNormal,TelescopeBorder:TelescopeBorder" },
    },
    popup_input = {
      win_options = {
        winhighlight = "TelescopeNormal:TelescopeNormal,TelescopeBorder:TelescopeBorder",
      },
      submit = "<C-Enter>",
      submit_n = "<Enter>",
    },
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
