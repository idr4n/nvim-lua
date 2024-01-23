# Neovim Configuration

This is my Neovim configuation written in Lua.

![CleanShot 2024-01-23 at 08 25 03@2x](https://github.com/idr4n/nvim-lua/assets/20104703/1338bf63-4a91-40a7-bf1d-2e9b7eb91660)
![CleanShot 2024-01-23 at 08 13 14@2x](https://github.com/idr4n/nvim-lua/assets/20104703/29fe2eec-1129-48c1-9ef8-61345ba2079a)

## Basic setup

- My setup is based, to great extend, on [LazyVim](https://github.com/LazyVim/LazyVim). I have borrowed many things from this config and if I was to start from scratch, I would probably just use LazyVim with some customization.
- **Preferred theme**: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim), "moon" variant.
- ~~I am using my own statusline~~ **I am using heirline** for both status and tabline. I found it easier to customize it for my own needs.
- **Terminals**: WezTerm (alternatively Alacritty and Kitty). To check my terminals configuration, take a look at my [dotfiles](https://github.com/idr4n/.dotfiles) and my [WezTerm configuration](https://github.com/idr4n/wezterm).
- **Font**: I switch back and forth between [FiraCode](https://github.com/tonsky/FiraCode) and [MonoLisa](https://www.monolisa.dev/).
- I'm using **[lazy.nvim](https://github.com/folke/lazy.nvim) as my package manager**, which allows me to start Neovim in around 30ms⚡️.
 
## List of current plugins (not necessarily updated!)

<details>
<summary>
This is the list of plugins I currently have installed, based on the Lazy.nvim's report.
</summary>

<br>

**Total: 104 plugins**

**Loaded (14)**

- alpha-nvim
- bufferline.nvim
- lazy.nvim
- noice.nvim
- nui.nvim
- nvim-notify
- nvim-treesitter
- nvim-ts-context-commentstring
- tokyonight.nvim
- vim-dirvish
- vim-symlink
- vim-vinegar
- vim-visual-multi
- which-key.nvim

**Not Loaded (84)**

- clipboard-image.nvim
- close-buffers.nvim
- cmp-buffer
- cmp-cmdline
- cmp-nvim-lsp
- cmp-nvim-lua
- cmp-path
- cmp-tailwind-colors
- cmp_luasnip
- code_runner.nvim
- Comment.nvim
- diffview.nvim
- emmet-vim
- friendly-snippets
- fzf
- fzf-lua
- fzf.vim
- github-nvim-theme
- gitsigns.nvim
- glance.nvim
- gruber-darker.nvim
- harpoon
- indent-blankline.nvim
- lf.vim
- LuaSnip
- lush.nvim
- mason-lspconfig.nvim
- mason.nvim
- mini.indentscope
- monokai-pro.nvim
- neo-tree.nvim
- neogit
- nightfly
- no-neck-pain.nvim
- none-ls.nvim
- nvim-autopairs
- nvim-cmp
- nvim-colorizer.lua
- nvim-dap
- nvim-dap-go
- nvim-dap-python
- nvim-dap-ui
- nvim-jdtls
- nvim-lspconfig
- nvim-treesitter-context
- nvim-treesitter-textobjects
- nvim-ts-autotag
- nvim-ufo
- nvim-web-devicons
- one-small-step-for-vimkind
- onedark.nvim
- otter.nvim
- playground
- plenary.nvim
- popup.nvim
- promise-async
- quarto-nvim
- rose-pine
- rust-tools.nvim
- sqls.nvim
- statuscol.nvim
- tabout.nvim
- telescope-file-browser.nvim
- telescope-fzf-native.nvim
- telescope-luasnip.nvim
- telescope-ui-select.nvim
- telescope-undo.nvim
- telescope.nvim
- todo-comments.nvim
- toggleterm.nvim
- trouble.nvim
- vgit.nvim
- vim-bbye
- vim-fish
- vim-floaterm
- vim-fugitive
- vim-indent-object
- vim-repeat
- vim-surround
- vim-unimpaired
- windex.nvim
- yanky.nvim
- zen-mode.nvim
- zenbones.nvim

**Disabled (6)**

- barbecue 
- incline.nvim 
- lualine.nvim 
- modes.nvim 
- oil.nvim 
- tabby.nvim 


</details>

## Credits

These are some repos I have borrowed ideas from for my Neovim config (although, there are many others that I can't keep tracked of, unfortunately):

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [ChristianChiarulli/lvim](https://github.com/ChristianChiarulli/lvim)
- [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [tjdevries/config_manager](https://github.com/tjdevries/config_manager)
- [joshmedeski/dotfiles](https://github.com/joshmedeski/dotfiles)
- [jonhoo/configs](https://github.com/jonhoo/configs)
- [Ben Frain's config](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)
- [nyoom-engineering/nyoom.nvim](https://github.com/nyoom-engineering/nyoom.nvim)
