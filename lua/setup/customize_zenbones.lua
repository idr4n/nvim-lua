local lush = require "lush"
-- local base = require "tokyobones"
local base = require "zenbones"

-- Create some specs
local specs = lush.parse(function()
  return {
    LineNr { base.LineNr, bg = "#000000" },
    CursorLineNr { base.CursorLineNr, bg = "#000000", fg = "#B4BDC3" },
  }
end)

-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))

