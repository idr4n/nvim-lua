local M = {}

M.barbecue = {
  opts = {
    show_navic = true,
    show_dirname = true,
    show_modified = true,
    theme = {
      basename = { fg = "#9D7CD8", bold = true },
    },
  },
}

M.code_runner = {
  config = function()
    require("code_runner").setup({
      focus = false,
      term = {
        position = "vert",
        size = 50,
      },
      float = {
        close_key = "q",
        border = "rounded",
        height = 0.4,
        width = 0.8,
        x = 0.5,
        y = 0.3,
      },
    })
  end,
}

M.colorizer = {
  opts = {
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      tailwind = "lsp",
      -- Available modes: foreground, background
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      -- mode = "virtualtext", -- Set the display mode.
      virtualtext = "■",
    },
  },
}

M.closebuffers = {
  keys = {
    {
      "<leader>bk",
      -- "<cmd>lua vim.cmd('Alpha'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      "<cmd>lua vim.cmd('Dashboard'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      noremap = true,
      silent = false,
      desc = "Close all and show Dashboard",
    },
    {
      "<leader>bo",
      "<cmd>lua require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      noremap = true,
      silent = false,
      desc = "Close all other buffers",
    },
  },
}

M.diffview = {
  keys = {
    { "<leader>vo", ":DiffviewOpen<cr>", desc = "Diffview Project Open" },
    { "<leader>vh", ":DiffviewFileHistory %<cr>", desc = "Diffview File History" },
  },
}

M.lf = {
  keys = {
    { ",L", ":Lf<cr>", noremap = true, silent = true, desc = "Open LF" },
  },
  config = function()
    local function calcFloatSize()
      return {
        width = math.min(math.ceil(vim.fn.winwidth(0) * 0.9), 140),
        height = math.min(math.ceil(vim.fn.winheight(0) * 0.9), 35),
      }
    end

    local function recalcFloatermSize()
      vim.g.floaterm_width = calcFloatSize().width
      vim.g.floaterm_height = calcFloatSize().height
    end

    vim.api.nvim_create_augroup("floaterm", { clear = true })
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = { "*" },
      callback = recalcFloatermSize,
      group = "floaterm",
    })

    vim.g.floaterm_width = calcFloatSize().width
    vim.g.floaterm_height = calcFloatSize().height
  end,
}

M.nabla = {
  keys = {
    { "<leader>tE", ":lua require('nabla').toggle_virt()<cr>", desc = "toggle equations" },
    { "<leader>te", ":lua require('nabla').popup()<cr>", desc = "hover equation" },
  },
}

M.vimtex = {
  config = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_silent = 1
    -- vim.g.vimtex_syntax_enabled = 0
  end,
}

M.neogit = {
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
}

M.spectre = {
    -- stylua: ignore
    keys = {
      { "<leader>ts", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre current word" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', mode = "v", desc = "Spectre current word" },
      { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre on current file" }
    },
}

M.yanky = {
  opts = function()
    require("telescope").load_extension("yank_history")
    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")

    return {
      ring = {
        history_length = 50,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 70,
      },
      system_clipboard = {
        sync_with_ring = false,
      },
      picker = {
        telescope = {
          mappings = {
            -- default = mapping.put("p"),
            default = mapping.special_put("YankyPutIndentAfter"),
            i = {
              ["<c-p>"] = mapping.special_put("YankyPutIndentBefore"),
              ["<c-k>"] = nil,
              ["<c-x>"] = mapping.delete(),
              ["<c-r>"] = mapping.set_register(utils.get_default_register()),
            },
            n = {
              p = mapping.special_put("YankyPutIndentAfter"),
              P = mapping.special_put("YankyPutIndentBefore"),
              d = mapping.delete(),
              r = mapping.set_register(utils.get_default_register()),
            },
          },
        },
      },
    }
  end,
}

M.zenmode = {
  opts = {
    window = {
      width = 85,
      height = 0.95,
      backdrop = 1,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        cursorcolumn = false,
      },
    },
    plugins = {
      -- gitsigns = { enabled = false },
      options = {
        laststatus = 3,
      },
    },
  },
}

return M
