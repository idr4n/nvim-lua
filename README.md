# README

My Neovim configuation in Lua.

![neovim](https://user-images.githubusercontent.com/20104703/170843418-ed863f0b-5199-4b82-a3ef-6dc410f39ee8.gif)

## Basic setup

- Theme: [mcchrish/zenbones.nvim: 🪨 A collection of contrast-based Vim/Neovim colorschemes](https://github.com/mcchrish/zenbones.nvim). I use both the light and dark themes.
- Terminal: Alacritty. To check my terminal configuration, take a look at my [dotfiles](https://github.com/idr4n/.dotfiles) 
- Font: [tonsky/FiraCode: Free monospaced font with programming ligatures](https://github.com/tonsky/FiraCode)

![neovim-3](https://user-images.githubusercontent.com/20104703/170856117-70a11bb8-5ebb-434d-a781-bcb2475b4fa4.png)

## Switching between dark and light modes

Whenever I start Neovim, the color theme is set based on the time of the day (which is the same time interval I set for my MacOS night shift). It is just a simple if/else statement:

```lua
local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 5.5 and t < 19.5 then
  vim.cmd("set background=light")
  vim.env.BAT_THEME = "gruvbox-light"
else
  vim.cmd("set background=dark")
  vim.env.BAT_THEME = "Nord"
end

vim.cmd("colorscheme zenbones")
```

And something similar for `lualine`. Although there are ways to make the switch between modes automatic, for me this is quite simple and good enough.

![neovim-4](https://user-images.githubusercontent.com/20104703/170856123-8884f9a1-32e9-4088-91fc-c3d5ee51c744.png)
![neovim-2](https://user-images.githubusercontent.com/20104703/170856125-eb76460c-6246-4317-8a71-1e59a6a7ced9.png)
