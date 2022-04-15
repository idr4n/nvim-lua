-- vim.cmd('colorscheme base16-default-dark')

local colorscheme = require('colorscheme')

-- Default Dark
local dark = {
  base00 = '#1D1F21', base01 = '#282828', base02 = '#383838', base03 = '#585858',
  base04 = '#b8b8b8', base05 = '#d8d8d8', base06 = '#e8e8e8', base07 = '#f8f8f8',
  base08 = '#ab4642', base09 = '#dc9656', base0A = '#f7ca88', base0B = '#a1b56c',
  base0C = '#86c1b9', base0D = '#7cafc2', base0E = '#ba8baf', base0F = '#a16946'
}

local light = {
  base00 = '#f8f8f8', base01 = '#e8e8e8', base02 = '#d8d8d8', base03 = '#b8b8b8',
  base04 = '#585858', base05 = '#383838', base06 = '#282828', base07 = '#181818',
  base08 = '#ab4642', base09 = '#dc9656', base0A = '#f7ca88', base0B = '#a1b56c',
  base0C = '#86c1b9', base0D = '#7cafc2', base0E = '#ba8baf', base0F = '#a16946'
}

local t = os.date("*t").hour

if (t >= 7 and t < 18) then
  colorscheme.setup(light)
else
  colorscheme.setup(dark)
end
