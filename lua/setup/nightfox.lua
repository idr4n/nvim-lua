-- "EdenEast/nightfox.nvim"

local options = {
  styles = {
    comments = "italic",
    functions = "italic,bold",
  }
}

require('nightfox').setup({
  options = options,
})

-- Load the colorscheme
-- local t = os.date("*t").hour

-- if (t >= 7 and t < 18) then
--   vim.cmd("colorscheme dawnfox")
-- else
--   -- vim.cmd("colorscheme nightfox")
--   vim.cmd("colorscheme duskfox")
-- end

