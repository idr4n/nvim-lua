local hl_str = require("utils").hl_str

---source: https://github.com/mcauley-penney/nvim
local function get_num_wraps()
  local winid = vim.api.nvim_get_current_win()

  local winfo = vim.fn.getwininfo(winid)[1]
  local bufwidth = winfo["width"] - winfo["textoff"]

  local line_length = vim.fn.strdisplaywidth(vim.fn.getline(vim.v.lnum)) - 1

  return math.floor(line_length / bufwidth)
end

return {
  "luukvbaal/statuscol.nvim",
  -- enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      -- relculright = true,
      ft_ignore = { "toggleterm", "neogitstatus", "NvimTree", "neo-tree", "oil", "snacks_picker_preview" },
      bt_ignore = { "terminal" },
      segments = {
        { text = { " " } },
        { sign = { namespace = { "diagnostic" }, name = { "Dap*" } }, click = "v:lua.ScSa" },
        {
          -- text = { "", builtin.lnumfunc, "" },
          condition = { true, builtin.not_empty },

          ---source: https://github.com/mcauley-penney/nvim
          text = {
            " ",
            "%=",
            function(args)
              local mode = vim.fn.mode()
              local normalized_mode = vim.fn.strtrans(mode):lower():gsub("%W", "")

              -- case 1
              if normalized_mode ~= "v" and vim.v.virtnum == 0 then
                return require("statuscol.builtin").lnumfunc(args)
              end

              if vim.v.virtnum < 0 then
                return "-"
              end

              local line = require("statuscol.builtin").lnumfunc(args)

              if vim.v.virtnum > 0 then
                local num_wraps = get_num_wraps()

                if vim.v.virtnum == num_wraps then
                  line = "└"
                else
                  line = "├"
                end
              end

              -- Highlight cases
              if normalized_mode == "v" then
                local pos_list =
                  vim.fn.getregionpos(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode, eol = true })
                local s_row, e_row = pos_list[1][1][2], pos_list[#pos_list][2][2]

                if vim.v.lnum >= s_row and vim.v.lnum <= e_row then
                  return hl_str("CursorLineNr", line)
                end
              end

              return vim.fn.line(".") == vim.v.lnum and hl_str("CursorLineNr", line) or hl_str("LineNr", line)
            end,
            " ",
          },
        },
        { text = { " ", builtin.foldfunc } },
        { sign = { namespace = { "gitsign*" } }, click = "v:lua.ScSa" },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)
  end,
}
