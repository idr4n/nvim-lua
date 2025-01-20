return {
  "windwp/nvim-autopairs",
  -- enabled = false,
  -- event = "VeryLazy",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    disable_filetype = { "TelescopePrompt", "snacks_picker_input" },
  },
  config = function(_, opts)
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

    require("nvim-autopairs").setup(opts)
  end,
}
