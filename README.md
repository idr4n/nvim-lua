# README

My Neovim configuation in Lua.

![Nvim](https://user-images.githubusercontent.com/20104703/191853625-ad5ed48b-657e-4a06-b779-4258239f6bd3.gif)

## Basic setup

- Theme: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- Terminals: Kitty, WezTerm and Alacritty. To check my terminal configuration, take a look at my [dotfiles](https://github.com/idr4n/.dotfiles) 
- Font: [MonoLisa](https://www.monolisa.dev/)

![Nvim](https://user-images.githubusercontent.com/20104703/191853774-cc07c0ff-38e2-4fa9-8b86-1aeaeaeed8be.png)

## Switching between dark and light modes

Whenever I start Neovim, the color theme is set based on the time of the day (which is the same time interval I set for my MacOS night shift). It is just a simple if/else statement:

```lua
local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 8 and t < 18 then
	vim.cmd("colorscheme tokyonight-storm")
else
	vim.cmd("colorscheme tokyonight-night")
end
```

## List of current plugins (not necessarily updated!)

<details>
<summary>
This is the list of plugins I currently have installed, auto-generated with `PackerStatus`. This list is not necessarily the most updated one.
</summary>

<br>

- alpha-nvim
- catppuccin
- clipboard-image.nvim
- close-buffers.nvim
- cmp-buffer
- cmp-cmdline
- cmp-nvim-lsp
- cmp-nvim-lua
- cmp-path
- cmp_luasnip
- diffview.nvim
- emmet-vim
- eyeliner.nvim
- friendly-snippets
- fzf
- fzf-lua
- fzf.vim
- gitsigns.nvim
- harpoon
- indent-blankline.nvim
- kanagawa.nvim
- lf.vim
- lsp_signature.nvim
- lualine.nvim
- LuaSnip
- lush.nvim
- mason-lspconfig.nvim
- mason.nvim
- neo-tree.nvim
- nightfox.nvim
- nui.nvim
- null-ls.nvim
- nvim-autopairs
- nvim-cmp
- nvim-colorizer.lua
- nvim-jdtls
- nvim-lspconfig
- nvim-markdown
- nvim-treesitter
- nvim-treesitter-context
- nvim-treesitter-textobjects
- nvim-ts-autotag
- nvim-ts-context-commentstring
- nvim-web-devicons
- packer.nvim
- playground
- plenary.nvim
- popup.nvim
- rasmus.nvim
- rust-tools.nvim
- sqls.nvim
- tabout.nvim
- telescope-fzf-native.nvim
- telescope-luasnip.nvim
- telescope-ui-select.nvim
- telescope.nvim
- todo-comments.nvim
- toggleterm.nvim
- tokyonight.nvim
- trouble.nvim
- vim-bbye
- vim-commentary
- vim-eunuch
- vim-fish
- vim-floaterm
- vim-fugitive
- vim-indent-object
- vim-repeat
- vim-surround
- vim-symlink
- vim-unimpaired
- vim-vinegar
- vim-visual-multi
- zen-mode.nvim
- zenbones.nvim
- zk-nvim
</details>

## Credits

These are some repos I have often borrowed ideas from for my Neovim config:

- [ChristianChiarulli/nvim](https://github.com/ChristianChiarulli/nvim)
- [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [tjdevries/config_manager](https://github.com/tjdevries/config_manager)
- [joshmedeski/dotfiles](https://github.com/joshmedeski/dotfiles)
- [jonhoo/configs](https://github.com/jonhoo/configs)
- [Ben Frain's config](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)
