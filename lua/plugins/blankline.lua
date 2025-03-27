return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- enabled = false,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      include = {
        node_type = {
          ["*"] = {
            "argument_list",
            "arguments",
            "assignment_statement",
            "Block",
            "chunk",
            "class",
            "ContainerDecl",
            "dictionary",
            "do_block",
            "do_statement",
            "element",
            "except",
            "FnCallArguments",
            "for",
            "for_statement",
            "function",
            "function_declaration",
            "function_definition",
            "if_statement",
            "IfExpr",
            "IfStatement",
            "import",
            "InitList",
            "jsx_self_closing_element",
            "list_literal",
            "method",
            "object",
            "ParamDeclList",
            "repeat_statement",
            "return_statement",
            "selector",
            "SwitchExpr",
            "table",
            "table_constructor",
            "try",
            "tuple",
            "type",
            "var",
            "while",
            "while_statement",
            "with",
          },
        },
      },
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = {
        "",
        "alpha",
        "dashboard",
        "NvimTree",
        "help",
        "markdown",
        "dirvish",
        "nnn",
        "packer",
        "toggleterm",
        "lsp-installer",
        "Outline",
      },
    },
  },
  -- config = function(_, opts)
  --   local ut = require("utils")
  --   local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  --       and string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)
  --     or "#282A36"
  --   local hl_bg = ut.lighten(bg, 0.94)
  --
  --   local hooks = require("ibl.hooks")
  --   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --
  --   require("ibl").setup(opts)
  --   for i = 1, 41 do
  --     local hl_group = string.format("@ibl.scope.underline.%s", i)
  --     -- vim.api.nvim_set_hl(0, hl_group, { link = "LspReferenceText" })
  --     -- vim.api.nvim_set_hl(0, hl_group, { bg = "#363C58" })
  --     vim.api.nvim_set_hl(0, hl_group, { bg = hl_bg })
  --   end
  -- end,
}
