-- List of all default plugins & their definitions

local plugins = {
  --: alpha {{{
  {
    "goolord/alpha-nvim",
    enabled = false,
    event = "VimEnter",
    opts = require("plugins.config.dashboard").alpha.config,
  },
  --: }}},

  --: barbecue {{{
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = false,
    event = "BufReadPre",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = require("plugins.config.others").barbecue.opts,
  },
  --: }}},

  --: bufferline... {{{
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = require("plugins.config.bufferline").keys,
    opts = require("plugins.config.bufferline").opts,
    config = require("plugins.config.bufferline").cofig,
  },
  --: }}}

  --: Catppuccin {{{
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = require("plugins.config.colorschemes").catppuccin.opts,
  },
  --: }}}

  --: clipboard-image {{{
  {
    "ekickx/clipboard-image.nvim",
    ft = "markdown",
    opts = {
      -- Default configuration for all filetype
      default = {
        img_dir = { "%:p:h", "assets" },
      },
      markdown = {
        img_dir_txt = "./assets",
      },
    },
    config = function(_, opts)
      require("clipboard-image").setup(opts)
    end,
  },
  --: }}}

  --: close_buffers {{{
  {
    "kazhala/close-buffers.nvim",
    keys = require("plugins.config.others").closebuffers.keys,
  },
  --: }}},

  --: code_runner {{{
  {
    "CRAG666/code_runner.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>cc", ":RunCode<CR>", noremap = true, silent = false, desc = "Code run" },
      { "<leader>cf", ":RunFile float<CR>", noremap = true, silent = false, desc = "File run" },
    },
    config = require("plugins.config.others").code_runner.config,
  },
  --: }}}

  --: colorizer {{{
  {
    "NvChad/nvim-colorizer.lua",
    -- enabled = false,
    -- event = "BufReadPre",
    init = function()
      require("utils").lazy_load("nvim-colorizer.lua")
    end,
    keys = {
      { ",c", "<cmd>ColorizerToggle<cr>", noremap = true, silent = true },
    },
    opts = require("plugins.config.others").colorizer.opts,
  },
  --: }}},

  --: comment.nvim {{{
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    -- opts = {
    --     pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    -- },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  --: }}}

  --: darkplus {{{
  {
    "lunarvim/darkplus.nvim",
    lazy = true,
  },

  --: }}}

  --: dashboard-nvim {{{
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    keys = {
      { "<leader>od", "<cmd>Dashboard<cr>", desc = "Open Dashboard" },
    },
    opts = require("plugins.config.dashboard").dashboard.opts,
  },
  --: }}}

  --: diffview {{{
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>vo", ":DiffviewOpen<cr>", noremap = true, silent = true },
      { "<leader>vh", ":DiffviewFileHistory %<cr>", noremap = true, silent = true },
    },
  },
  --: }}},

  --: emmet {{{
  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    init = function()
      vim.g.user_emmet_leader_key = "<C-W>"
    end,
  },
  --: }}},

  --: flash {{{
  {
    "folke/flash.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            -- { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
  },
  --: }}}

  --: fzf-lua
  {
    "ibhagwan/fzf-lua",
    -- enabled = false,
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- keys = require("plugins.config.fzflua").keys,
    keys = {
      -- {
      --     "<leader>r",
      --     "<cmd>lua require('fzf-lua').live_grep()<CR>",
      --     noremap = true,
      --     silent = true,
      --     desc = "Live Grep",
      -- },
      {
        "<leader>or",
        "<cmd>lua require('fzf-lua').resume()<CR>",
        noremap = true,
        silent = true,
        desc = "Fzf-Lua Resume",
      },
      -- { "<C-P>", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
      { "<leader><Space>", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
      -- { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
      -- { "<C-T>", "<cmd>lua require('fzf-lua').oldfiles()<CR>", noremap = true, silent = true },
      -- { "<C-B>", "<cmd>lua require('fzf-lua').buffers()<CR>", noremap = true, silent = true },
      -- {
      --     "<leader>gs",
      --     "<cmd>lua require('fzf-lua').git_status({ winopts = { preview = { hidden = 'nohidden' } } })<CR>",
      --     noremap = true,
      --     silent = true,
      --     desc = "Git Status",
      -- },
      {
        "<leader>/",
        function()
          workdirs({ nvim_tmux = true })
        end,
        noremap = true,
        silent = true,
        desc = "Open dir in new TMUX",
      },
    },
    opts = function()
      vim.api.nvim_set_hl(0, "FZFLuaBorder", { fg = "#9D7CD8" })
      return require("plugins.config.fzflua").opts
    end,
  },
  --: }}}

  --: fzf.vim {{{
  {
    "junegunn/fzf.vim",
    cmd = { "Files", "Rg", "Lines", "BLines", "History" },
    keys = {
      -- { "<C-P>", ":Files<cr>", noremap = true, silent = true },
      -- { "<leader>ff", ":Files<cr>", noremap = true, silent = true },
      -- { "<C-T>", ":History<cr>", noremap = true, silent = true },
      -- { "<C-B>", ":Buffers<cr>", noremap = true, silent = true },
      { "<leader>r", ":Rg<cr>", noremap = true, silent = true, desc = "Fzf Live Grep" },
      -- { "<leader>gs", ":GitFiles?<cr>", noremap = true, silent = true },
      -- { "<leader>cc", "<cmd>lcd ~/.config/nvim | Files<cr>", noremap = true, silent = true },
      -- { "<leader>b", "<cmd>BLines<cr>", noremap = true, silent = true },
    },
    dependencies = "junegunn/fzf",
    config = require("plugins.config.fzfvim").config,
  },
  --: }}},

  --: gitsigns {{{
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require("plugins.config.gitsigns").opts,
  },
  --: }}},

  --: glance {{{
  {
    "dnlhc/glance.nvim",
    keys = {
      { "<leader>gg", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
      { "<leader>gr", "<CMD>Glance references<CR>", desc = "Glance references" },
      { "<leader>lr", "<CMD>Glance references<CR>", desc = "LSP references" },
      { "<leader>gd", "<CMD>Glance type_definitions<CR>", desc = "Glance type definitions" },
      { "<leader>gm", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
    },
    opts = {
      border = { enable = true, top_char = "─", bottom_char = "─" },
    },
  },
  --: }}}

  --: harpoon {{{
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon" },
      { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add Harpoon" },
      { "<M-u>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
      { "<M-i>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" },
      { "<M-o>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" },
      { "<M-p>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" },
      { "<M-[>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>" },
      { "<M-]>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>" },
    },
    dependencies = "nvim-lua/plenary.nvim",
  },
  --: }}}

  --: heirline {{{
  {
    "rebelot/heirline.nvim",
    -- enabled = false,
    -- event = "BufEnter",
    event = "VeryLazy",
    opts = require("plugins.config.heirline").opts,
  },
  --: }}}

  --: indent-blankline {{{
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- enabled = false,
    -- event = { "BufReadPre", "BufNewFile" },
    init = function()
      require("utils").lazy_load("indent-blankline.nvim")
    end,
    opts = require("plugins.config.blankline").opts,
    config = function(_, opts)
      require("ibl").setup(opts)
      for i = 1, 41 do
        local hl_group = string.format("@ibl.scope.underline.%s", i)
        -- vim.api.nvim_set_hl(0, hl_group, { link = "LspReferenceText" })
        -- vim.api.nvim_set_hl(0, hl_group, { bg = "#363C58" })
        vim.api.nvim_set_hl(0, hl_group, { bg = "#353B45" })
      end
    end,
  },
  --: }}},

  --: Kanagawa {{{
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = require("plugins.config.colorschemes").kanagawa.opts,
  },
  --: }}}

  --: lf {{{
  {
    "ptzz/lf.vim",
    dependencies = "voldikss/vim-floaterm",
    keys = {
      { ",l", ":Lf<cr>", noremap = true, silent = true, desc = "Open LF" },
    },
    config = require("plugins.config.others").lf.config,
  },
  --: }}},

  --: luasnip {{{
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    keys = require("plugins.config.luasnip").keys,
    config = require("plugins.config.luasnip").config,
  },
  --: }}}

  --: Markdown-preview {{{
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_browser = "Vivaldi"
    end,
  },

  --: }}}

  --: mason.nvim {{{
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>om", "<cmd>Mason<cr> " } },
    opts = require("plugins.config.mason").opts,
    config = require("plugins.config.mason").config,
  },
  --: }}}

  --: mini.indentscope with animations {{{
  {
    "echasnovski/mini.indentscope",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  --: }}}

  --: mini.ai {{{
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
  },
  --: }}}

  --: mini.surround {{{
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "S", -- Add surrounding
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
  },
  --: }}}

  --: modes.nvim {{{
  {
    "mvllow/modes.nvim",
    event = "InsertEnter",
    enabled = false,
    opts = {
      colors = {
        copy = "#42be65",
        delete = "#ff7eb6",
        insert = "#be95ff",
        visual = "#82cfff",
      },
    },
  },
  --: }}}

  --: monokai-pro {{{
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    opts = require("plugins.config.colorschemes").monokaipro.opts,
  },
  --: }}}

  --: neogit (magit for neovim) {{{
  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gn", ":Neogit<cr>", noremap = true, silent = true, desc = "Neogit" },
    },
    opts = {
      disable_signs = false,
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
      },
      integrations = { diffview = true },
    },
  },
  --: }}}

  --: neo-tree {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = require("plugins.config.neotree").keys,
    opts = require("plugins.config.neotree").opts,
  },
  --: }}}

  --: noice {{{
  {
    "folke/noice.nvim",
    -- enabled = false,
    event = "VeryLazy",
    keys = require("plugins.config.noice").keys,
    opts = require("plugins.config.noice").opts,
  },
  --: }}},

  --: null-ls/none-ls {{{
  {
    -- "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = require("plugins.config.nonels").opts,
  },
  --: }}}

  --: no-neck-pain (another zen-mode plugin) {{{
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = { "NoNeckPain" },
    keys = {
      {
        "<leader>tz",
        function()
          vim.cmd([[
                        NoNeckPain
                        set invnumber
                        set invrelativenumber
                    ]])
        end,
        desc = "Zen-mode (No-neck-pain)",
      },
    },
    opts = {
      buffers = { wo = { number = false, relativenumber = false } },
    },
  },
  --: }}}

  --: notify {{{
  {
    "rcarriga/nvim-notify",
    -- enabled = false,
    keys = {
      {
        "<leader>nn",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      -- background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  --: }}}

  --: nvim-autopairs {{{
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup()

      local Rule = require("nvim-autopairs.rule")

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end),
      })
      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match(".%" .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        })
      end
    end,
  },
  --: }}}

  --: nvim-cmp {{{
  {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    event = { "InsertEnter", "BufReadPost" },
    -- event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      { "js-everts/cmp-tailwind-colors", config = true },
    },
    opts = require("plugins.config.cmp").opts,
    config = require("plugins.config.cmp").config,
  },
  --: }}},

  --: nvim-dap {{{
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",

        config = function()
          require("dapui").setup()
        end,
      },
      { "jbyuki/one-small-step-for-vimkind" },
    },
    keys = require("plugins.config.dap").nvimdap.keys,
    config = require("plugins.config.dap").nvimdap.config,
  },
  --: }}}

  --: nvim-dap-go {{{
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = require("plugins.config.dap").nvimdapgo.opts,
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  --: }}}

  --: nvim-dap-python {{{
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = {
      { "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", mode = "v" },
    },
    config = function()
      require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    end,
  },
  --: }}}

  --: nvim-jdtls {{{
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  --: }}}

  --: nvim-lspconfig {{{
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    init = function()
      require("utils").lazy_load("nvim-lspconfig")
    end,
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    -- opts = require("plugins.config.lsp").conf.opts,
    opts = function()
      local root_pattern = require("lspconfig").util.root_pattern
      return require("plugins.config.lsp").conf.opts(root_pattern)
    end,
    config = require("plugins.config.lsp").conf.config,
  },
  --: }}}

  --: NvTerm {{{
  {
    "NvChad/nvterm",
    event = "BufReadPost",
    keys = function()
      return require("plugins.config.nvterm").keys(require("nvterm.terminal"))
    end,
    opts = require("plugins.config.nvterm").opts,
    config = function(_, opts)
      require("nvterm").setup(opts)
      require("plugins.config.nvterm").setup()
    end,
  },
  --: }}}

  --: nvim-treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    init = function()
      require("utils").lazy_load("nvim-treesitter")
    end,
    -- event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    opts = require("plugins.config.treesitter").treesitter.opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("ts_context_commentstring").setup({})
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  --: }}}

  --: nvim-treesitter-context: show context of the current function {{{
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>tt",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
  --: }}}

  --: nvim-treesitter-textobjects {{{
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "LspAttach",
    opts = require("plugins.config.treesitter").textobjects.opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  --: }}}

  --: nvim-ts-autotag: automatically add closing tags for HTML and JSX {{{
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  --: }}}

  --: nvim-ufo "folding" {{{
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
        -- stylua: ignore
        keys = {
            { "zR", function() require("ufo").openAllFolds() end, },
            { "zM", function() require("ufo").closeAllFolds() end, },
            { "z1", function() require("ufo").closeFoldsWith(1) end, },
            { "z2", function() require("ufo").closeFoldsWith(2) end, },
        },
    config = function()
      -- vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ftMap = {
        markdown = "",
        vue = "lsp",
      }

      require("ufo").setup({
        open_fold_hl_timeout = 0,
        -- close_fold_kinds = { "imports", "regions", "comments" },
        provider_selector = function(bufnr, filetype, buftype)
          -- return { "treesitter", "indent" }
          return ftMap[filetype] or { "treesitter", "indent" }
        end,
      })
    end,
  },
  --: }}}

  --: oil - file manager {{{
  {
    "stevearc/oil.nvim",
    enabled = false,
    cmd = "Oil",
    keys = { { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" } },
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  --: }}}

  --: Onedark.nvim {{{
  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = require("plugins.config.colorschemes").onedark.opts,
  },
  --: }}}

  --: persistence (sessions) {{{
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = function()
      local function pre_save()
        -- remove buffers whose files are located outside of cwd
        local cwd = vim.fn.getcwd() .. "/"
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local bufpath = vim.api.nvim_buf_get_name(buf) .. "/"
          if not bufpath:match("^" .. vim.pesc(cwd)) then
            vim.api.nvim_buf_delete(buf, {})
          end
        end
      end

      return {
        options = vim.opt.sessionoptions:get(),
        pre_save = pre_save,
      }
    end,
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
  },
  --: }}}

  --: rose-pine {{{
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    opts = require("plugins.config.colorschemes").rosepine.opts,
  },
  --: }}}

  --: quarto {{{
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    ft = { "quarto" },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        config = true,
      },
    },
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "lua", "html" },
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
    end,
  },
  --: }}}

  --: statuscol {{{
  {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    -- branch = "0.10",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        -- relculright = true,
        ft_ignore = { "toggleterm", "neogitstatus" },
        bt_ignore = { "terminal" },
        segments = {
          -- { text = { builtin.foldfunc, "" }, click = "v:lua.ScFa" },
          -- { text = { "%s" }, click = "v:lua.ScSa" },
          { sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
          { sign = { name = { "Dap*" }, auto = true }, click = "v:lua.ScSa" },
          {
            -- text = { "", builtin.lnumfunc, "   " },
            text = { "", builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          -- { text = { "%s" }, click = "v:lua.ScSa" },
          -- { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
          { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
        },
      }
    end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  --: }}}

  --: tabby {{{
  {
    "nanozuki/tabby.nvim",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- vim.o.showtabline = 2
      local theme = {
        fill = "TabLineFill",
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        win = "TabLine",
        tail = "TabLine",
      }
      require("tabby.tabline").set(function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              tab.close_btn("󱎘"),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          hl = theme.fill,
        }
      end)
    end,
  },
  --: }}}

  --: tabout {{{
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter" },
    opts = {
      tabkey = [[<C-\>]], -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = [[<C-S-\>]], -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = false, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      enable_backwards = true, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {}, -- tabout will ignore these filetypes
    },
    -- config = function(_, opts)
    --  require("tabout").setup(opts)
    -- end,
  },
  --: }}}

  --: telescope {{{
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "BufReadPost",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip", -- if you wish to lazy-load
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      "debugloop/telescope-undo.nvim",
    },
    keys = require("plugins.config.telescope").keys,
    opts = require("plugins.config.telescope").opts,
    config = require("plugins.config.telescope").config,
  },
  --: }}}

  --: tokyonight {{{
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = require("plugins.config.colorschemes").tokyonight.opts,
  },
  --: }}}

  --: todo-comments {{{
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", noremap = true, silent = true, desc = "TodoTrouble" },
    },
    opts = {
      highlight = {
        comments_only = false,
        after = "",
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--glob=!node_modules",
        },
      },
    },
  },
  --: }}}

  --: toggleterm {{{
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>gl", ":LazyGit<cr>", noremap = true, silent = true, desc = "LazyGit" },
      { "<M-\\>", ":ToggleTerm<cr>", noremap = true, silent = true },
    },
    opts = require("plugins.config.toggleterm").opts,
    config = require("plugins.config.toggleterm").config,
  },
  --: }}}

  --: trouble {{{
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true, desc = "Toggle" },
      {
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        silent = true,
        noremap = true,
        desc = "workspace_diagnostics",
      },
      {
        "<leader>ld",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        silent = true,
        noremap = true,
        desc = "workspace_diagnostics",
      },
      {
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        silent = true,
        noremap = true,
        desc = "document_diagnostics",
      },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", silent = true, noremap = true, desc = "loclist" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", silent = true, noremap = true, desc = "quickfix" },
      { "gr", "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true, desc = "LSP references" },
      -- { "gd", "<cmd>TroubleToggle lsp_definitions<cr>", silent = true, noremap = true },
    },
    opts = {
      height = 15,
    },
  },
  --: }}}

  --: vgit {{{
  {
    "tanvirtin/vgit.nvim",
    -- enabled = false,
    -- dev = true,
    -- event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
        -- stylua: ignore
        keys = {
            { "<leader>gp", function() require('vgit').buffer_hunk_preview() end, desc = "Hunk preview (vgit)" }
        },
    opts = {
      settings = {
        live_blame = { enabled = false },
        live_gutter = { enabled = false },
        authorship_code_lens = { enabled = false },
        scene = {
          diff_preference = "split",
          keymaps = {
            quit = "q",
          },
        },
        signs = {
          definitions = {
            GitSignsAdd = { text = "▎" },
            GitSignsDelete = { text = "󰍵" },
            GitSignsChange = { text = "▎" },
          },
        },
      },
    },
  },
  --: }}}

  --: vim-dirvish {{{
  {
    "justinmk/vim-dirvish",
    event = "VimEnter",
    enabled = false,
    config = function()
      vim.g.dirvish_git_show_ignored = 1

      -- sort folders at the top
      vim.g.dirvish_mode = ":sort ,^.*[\\/],"

      -- use h and l to navigate back and forward
      vim.cmd([[
            augroup dirvish_mappings
                autocmd!
                autocmd FileType dirvish nnoremap <silent><buffer> l :<C-U>.call dirvish#open("edit", 0)<CR>
                autocmd FileType dirvish nnoremap <silent><buffer> h :<C-U>exe "Dirvish %:h".repeat(":h",v:count1)<CR>
            augroup END
            ]])
    end,
  },
  --: }}}

  --: vim-fugitive {{{
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gi", ":Git<cr>", noremap = true, silent = true, desc = "Git Fugitive" },
    },
  },
  --: }}}

  --: which-key {{{
  {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    config = require("plugins.config.whichkey").config,
  },
  --: }}}

  --: windex (max. window) {{{
  {
    "declancm/windex.nvim",
        -- stylua: ignore
        keys = {
            { "<Leader>tm", "<Cmd>lua require('windex').toggle_nvim_maximize()<CR>", desc = "Toggle Maximize Window" },
            -- { "<C-Bslash>", "<Cmd>lua require('windex').toggle_terminal()<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
            -- { "<C-n>", "<C-Bslash><C-n>", mode = "t", desc = "Enter normal mode" },
        },
    config = true,
  },
  --: }}}

  --: yanky {{{
  {
    "gbprod/yanky.nvim",
    -- enabled = false,
    event = "BufReadPost",
    cmd = { "YankyRingHistory", "YankyClearHistory" },
    keys = {
      -- { ",r", "<cmd>YankyRingHistory<cr>", noremap = true, silent = true },
      -- { ",r", "<cmd>Telescope yank_history<cr>", noremap = true, silent = true },
      {
        ",y",
        "<cmd>lua require('telescope').extensions.yank_history.yank_history({ initial_mode = 'normal' })<cr>",
        noremap = true,
        silent = true,
        desc = "Yank history",
      },
    },
    opts = require("plugins.config.others").yanky.opts,
  },
  --: }}}

  --: zen-mode {{{
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    keys = {
      { "<leader>zz", ":ZenMode<cr>", noremap = true, silent = true, desc = "Zen mode" },
    },
    opts = require("plugins.config.others").zenmode.opts,
  },
  --: }}}

  --: Misc
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require("utils").devicons_override }
    end,
  },
  -- { "tpope/vim-vinegar", event = "VeryLazy" },
  { "moll/vim-bbye", event = "BufReadPost" },
  -- { "aymericbeaumet/vim-symlink", event = "VeryLazy" },
  { "dag/vim-fish", ft = "fish" },
  "simrat39/rust-tools.nvim",
  "nanotee/sqls.nvim",
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}

require("lazy").setup(plugins, require("plugins.config.lazynvim"))
