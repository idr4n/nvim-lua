return {
  "hrsh7th/nvim-cmp",
  -- enabled = false,
  event = { "InsertEnter", "BufReadPost" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    { "Gelio/cmp-natdat", config = true },
    {
      "js-everts/cmp-tailwind-colors",
      opts = {
        format = function(itemColor)
          return {
            fg = itemColor,
            bg = nil, -- or nil if you dont want a background color
            text = "󱓻 ", -- or use an icon
          }
        end,
      },
    },
    { "saecki/crates.nvim", event = { "BufRead Cargo.toml" } },
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local nvchad_icons = require("utils").lazyvim_icons
    local cursorMoveAround = require("utils").CursorMoveAround

    -- require("luasnip/loaders/from_vscode").lazy_load()

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    return {
      enabled = function()
        -- Disable cmp in big files
        local size_limit = 2 * 1024 * 1024 -- 2 MiB
        local bufnr = vim.api.nvim_get_current_buf()
        local ok, stats = pcall(function()
          return vim.loop.fs_stat(vim.api.nvim_buf_get_name(bufnr))
        end)
        if not (ok and stats) then
          return
        end
        if stats.size > size_limit then
          return false
        end
        return true
      end,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.config.disable,
        ["<C-x>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        -- ["<C-l>"] = cmp.mapping.confirm({ select = true }),
        ["<C-l>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            cursorMoveAround()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- START extra config for cmp-tailwind-colors (remove if not used)
          if vim_item.kind == "Color" then
            vim_item = require("cmp-tailwind-colors").format(entry, vim_item)

            -- source nvchad/ui
            local entryItem = entry:get_completion_item()
            local color = entryItem.documentation
            if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
              local hl = "hex-" .. color:sub(2)

              if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
                vim.api.nvim_set_hl(0, hl, { fg = color })
              end

              vim_item.kind_hl_group = hl
              vim_item.menu_hl_group = hl
            end

            if vim_item.kind ~= "Color" then
              vim_item.menu = "Color"
              vim_item.kind = string.format(" %s", vim_item.kind)
              return vim_item
            end
          end
          -- END extra config for cmp-tailwind-colors

          vim_item.menu = vim_item.kind
          if nvchad_icons[vim_item.kind] then
            vim_item.kind = string.format(" %s ", nvchad_icons[vim_item.kind])
          end
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "otter" },
        { name = "crates" },
        { name = "natdat" },
        { name = "cmp_r" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          side_padding = 0,
          -- For oxocarbon style (comment out border and use winhighlight below)
          -- winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu",
        },
      },
      experimental = {
        ghost_text = false,
        native_menu = false,
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local handlers = require("nvim-autopairs.completion.handlers")

    -- if using nvim-autopairs
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done({
        filetypes = {
          -- "*" is a alias to all filetypes
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers["*"],
            },
          },
        },
      })
    )
  end,
}
