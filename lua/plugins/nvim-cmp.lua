return {
  "hrsh7th/nvim-cmp",
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
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local nvchad_icons = require("utils").nvchad_icons
    local cursorMoveAround = require("utils").CursorMoveAround

    -- require("luasnip/loaders/from_vscode").lazy_load()

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
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

            if vim_item.kind ~= "Color" then
              vim_item.menu = "Color"
              vim_item.kind = string.format(" %s", vim_item.kind)
              return vim_item
            end
          end
          -- END extra config for cmp-tailwind-colors

          vim_item.menu = vim_item.kind
          vim_item.kind = string.format(" %s ", nvchad_icons[vim_item.kind])
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
        -- { name = "copilot" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = {
          -- border = border("CmpBorder"),
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          side_padding = 0,
          -- For oxocarbon style (comment out border and use winhighlight below)
          -- winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          -- border = border("CmpDocBorder"),
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

    -- workaround if using ultimate-autopair.nvim instead of nvim-autopairs
    -- local Kind = cmp.lsp.CompletionItemKind
    -- cmp.event:on("confirm_done", function(evt)
    --   if vim.tbl_contains({ Kind.Function, Kind.Method }, evt.entry:get_completion_item().kind) then
    --     vim.api.nvim_feedkeys("()" .. vim.api.nvim_replace_termcodes("<Left>", true, true, true), "n", false)
    --   end
    -- end)
  end,
}
