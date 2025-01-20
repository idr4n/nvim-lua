return {
  "saghen/blink.cmp",
  -- enabled = false,
  event = { "InsertEnter", "BufReadPost" },
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  build = "cargo build --release",

  opts = {
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          score_offset = 100,
          enabled = true,
        },
      },
    },

    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      list = {
        selection = { auto_insert = true },
      },
      menu = {
        border = "rounded",
        draw = {
          gap = 2,
          components = {
            kind_icon = {
              text = function(ctx)
                if require("blink.cmp.completion.windows.render.tailwind").get_hex_color(ctx.item) then
                  return "󱓻"
                end
                return ctx.kind_icon .. ctx.icon_gap
              end,
            },
          },
        },
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
    },

    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "select_and_accept" },

      ["<C-j>"] = { "snippet_forward", "fallback" },
      ["<C-k>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
  },
  opts_extend = { "sources.default" },
}
