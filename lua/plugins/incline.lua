return {
  "b0o/incline.nvim",
  enabled = false,
  event = "BufReadPre",
  dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>I", '<Cmd>lua require"incline".toggle()<Cr>', desc = "Incline: Toggle" },
  },
  config = function()
    -- local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local navic = require("nvim-navic")

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "Navic Attacher",
      group = vim.api.nvim_create_augroup("idr4n/navic-attacher", {}),
      callback = function(a)
        local client = vim.lsp.get_client_by_id(a.data.client_id)
        if client and client.server_capabilities["documentSymbolProvider"] then
          navic.attach(client, a.buf)
        end
      end,
    })

    require("incline").setup({
      hide = {
        cursorline = "focused_win",
        -- cursorline = false,
        -- focused_win = true,
        -- only_win = true,
      },
      -- debounce_threshold = { rising = 20, falling = 150 },
      window = {
        margin = { horizontal = 0, vertical = 0 },
        padding = 0,
        overlap = {
          winbar = true,
        },
        winhighlight = {
          Normal = "SLBgLighten",
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {}
        if props.focused then
          for _, item in ipairs(navic.get_data(props.buf) or {}) do
            table.insert(res, {
              -- { " > ", group = "NavicSeparator" },
              { item.icon, group = "NavicIcons" .. item.type },
              { item.name, group = "NavicText" },
            })
          end
        end
        table.insert(res, " ")
        return res
      end,
      -- render = function(props)
      --   local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      --   if filename == "" then
      --     filename = "[No Name]"
      --   end
      --   -- local ut = require("utils")
      --   local ft_icon, ft_color = devicons.get_icon_color(filename)
      --   local modified = vim.bo[props.buf].modified
      --
      --   -- local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      --   -- local hl_bg1 = ut.lighten(string.format("#%06x", normal.bg), 0.96)
      --   -- local hl_bg2 = ut.lighten(string.format("#%06x", normal.bg), 0.95)
      --   -- ft_color = ft_color and ut.lighten(ft_color, 0.8, normal.bg)
      --
      --   return {
      --     -- ft_icon and { " ", ft_icon, " ", guifg = ft_color, guibg = hl_bg1 } or "",
      --     -- ft_icon and { " ", ft_icon, " ", guibg = "#9580FF", guifg = "#393F4A" } or "",
      --     ft_icon and { " ", ft_icon, guifg = ft_color } or "",
      --     -- ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
      --     " ",
      --     -- { filename, gui = modified and "bold,italic" or "bold" },
      --     filename,
      --     modified and { " ", guifg = "#c3e88d" } or "",
      --     " ",
      --     -- guibg = "#44406e",
      --     -- guibg = hl_bg2,
      --     -- blend = 10,
      --   }
      -- end,
    })
  end,
}
