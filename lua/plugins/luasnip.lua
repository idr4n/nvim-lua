local cursorMoveAround = require("utils").CursorMoveAround

return {
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
  keys = {
    {
      "<c-j>",
      function()
        if require("luasnip").jumpable(1) then
          require("luasnip").jump(1)
        end
      end,
      mode = { "i", "s" },
      silent = true,
    },
    {
      "<c-k>",
      function()
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        end
      end,
      mode = { "i", "s" },
      silent = true,
    },
    {
      "<c-l>",
      function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(1)
        else
          cursorMoveAround()
        end
      end,
      mode = "i",
    },
    {
      "<c-h>",
      function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(-1)
        end
      end,
      mode = "i",
    },
  },
  config = function()
    local ls = require("luasnip")
    local p = ls.parser.parse_snippet
    local s = ls.snippet
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt
    local i = ls.insert_node

    -- local sn = ls.snippet_node
    -- local t = ls.text_node
    -- local fmt = require("luasnip.extras.fmt").fmt
    -- -- Mapped snippets --
    local function map_snippet(keys, snippet)
      vim.keymap.set("i", keys, function()
        require("luasnip").snip_expand(snippet)
      end)
    end

    -- mappable snippets
    local snippets = {
      spr = p({
        trig = "spr",
        name = "print(|)",
        dscr = "surrounds with print function",
      }, "print($TM_SELECTED_TEXT$1)"),
      sc = p({
        trig = "sc",
        name = "surronds with {|}",
        dscr = "surrounds selection with curly brackets",
      }, "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}"),
      sp = p({
        trig = "sp",
        name = "surronds with (|)",
        dscr = "surrounds selection with parenthesis",
      }, "$1($TM_SELECTED_TEXT$2)"),
      ss = p({
        trig = "ss",
        name = "surronds with [|]",
        dscr = "surrounds selection with square brackets",
      }, "$1[$TM_SELECTED_TEXT$2]"),
      sf = p({
        trig = "sf",
        name = "surrounds with callback function",
        dscr = "surrounds selection with a callback function",
      }, "${1:name}(($3) => {\n\t$TM_SELECTED_TEXT$4\n})"),
      scm = s(
        {
          trig = "scm",
          name = "Comment folde marker",
          dscr = { "Surrounds with fold marker comment" },
        },
        fmt(
          [[
            {1}: {2} {{{{{{
            {3}{4}
            {1}: }}}}}}
        ]],
          {
            f(function()
              local cm = vim.opt_local.commentstring["_value"]
              local cmString = string.gmatch(cm, "[^ %%s]+")()

              if cmString then
                return cmString
              else
                return "#"
              end
            end, {}),
            i(1, "comment..."),
            f(function(_, snip)
              return snip.env.SELECT_DEDENT
            end, {}),
            i(2),
          }
        )
      ),
    }

    local mappable = snippets

    -- loads snippets from path/of/nvim/config/
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
    -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

    -- Settings --
    ls.filetype_extend("typescript", { "javascript", "javascriptreact" })
    ls.filetype_extend("javascript", { "javascript", "javascriptreact" })
    ls.filetype_extend("javascriptreact", { "javascript", "javascriptreact" })
    ls.filetype_extend("typescriptreact", { "javascript", "javascriptreact" })
    ls.filetype_extend("quarto", { "markdown" })
    ls.filetype_extend("codecompanion", { "markdown" })

    ls.config.set_config({
      store_selection_keys = "<c-s>",
      history = true,
      enable_autosnippets = true,
    })

    -- surrounds with {|}
    map_snippet(";cc", mappable.sc)
    vim.api.nvim_set_keymap("v", ";cc", "<c-s>;cc", { noremap = false, silent = false })

    -- surrounds with callback function
    map_snippet(";cf", mappable.sf)
    vim.api.nvim_set_keymap("v", ";cf", "<c-s>;cf", { noremap = false, silent = false })

    -- surrounds with foldable comment
    map_snippet(";cm", mappable.scm)
    vim.api.nvim_set_keymap("v", ";cm", "<c-s>;cm", { noremap = false, silent = false })

    -- python surround with print()
    map_snippet(";cp", mappable.spr)
    vim.api.nvim_set_keymap("v", ";cp", "<c-s>;pr", { noremap = false, silent = false })
  end,
}
