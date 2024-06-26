# Neovim Configuration

This is my Neovim configuation written in Lua.

![CleanShot 2024-04-05 at 15 29 43@2x](https://github.com/idr4n/nvim-lua/assets/20104703/d2c62063-96ba-4bdd-8843-d4d18ab6b8ae)
![CleanShot 2024-04-05 at 16 00 57@2x](https://github.com/idr4n/nvim-lua/assets/20104703/3732ccdd-bf76-4b04-a371-f3db25b2c526)

## Basic setup

- **Preferred themes**: [catppuccin/nvim (mocha)](https://github.com/catppuccin/nvim), [projekt0n/github-nvim-theme (light)](https://github.com/projekt0n/github-nvim-theme)  and [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim).
- I am using my own statusline as I find it easier to customize it to my own needs.
- **Terminals**: WezTerm (alternatively Alacritty and Kitty). To check my terminals configuration, take a look at my [dotfiles](https://github.com/idr4n/.dotfiles) and my [WezTerm configuration](https://github.com/idr4n/wezterm).
- **Font**: I switch back and forth between [FiraCode](https://github.com/tonsky/FiraCode) and [MonoLisa](https://www.monolisa.dev/).
- I'm using **[lazy.nvim](https://github.com/folke/lazy.nvim) as my package manager**, which allows me to start Neovim in around 30ms⚡️.
 
## List of current plugins (not necessarily updated!)

<details>
<summary>
This is the list of plugins I currently have installed (although many of them are disabled):
</summary>

<br>

**Total: 117 plugins**

**Loaded (11)**

- alpha-nvim
- Comment.nvim
- github-nvim-theme
- lazy.nvim
- mini.ai
- mini.move
- nvim-autopairs
- nvim-treesitter
- nvim-ts-context-commentstring
- nvim-web-devicons
- which-key.nvim

**Not Loaded (86)**

- bigfile.nvim
- bufferline.nvim
- catppuccin
- ccc.nvim
- close-buffers.nvim
- cmp-buffer
- cmp-cmdline
- cmp-nvim-lsp
- cmp-nvim-lua
- cmp-path
- cmp-tailwind-colors
- cmp_luasnip
- code_runner.nvim
- command-t
- darkplus.nvim
- diffview.nvim
- dressing.nvim
- emmet-vim
- friendly-snippets
- fzf-lua
- gitsigns.nvim
- glance.nvim
- harpoon
- indent-blankline.nvim
- kanagawa.nvim
- LuaSnip
- markdown-preview.nvim
- mason-lspconfig.nvim
- mason.nvim
- mini.files
- mini.surround
- molten-nvim
- monokai-pro.nvim
- neo-tree.nvim
- neogit
- neovim-session-manager
- no-neck-pain.nvim
- none-ls.nvim
- nui.nvim
- nvim-cmp
- nvim-dap
- nvim-dap-go
- nvim-dap-python
- nvim-dap-ui
- nvim-dap-virtual-text
- nvim-dap-vscode-js
- nvim-lspconfig
- nvim-nio
- nvim-spectre
- nvim-treesitter-context
- nvim-treesitter-textobjects
- nvim-ts-autotag
- nvim-ufo
- obsidian.nvim
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
- tabout.nvim
- tdo.nvim
- telescope-fzf-native.nvim
- telescope-luasnip.nvim
- telescope-ui-select.nvim
- telescope-undo.nvim
- telescope.nvim
- todo-comments.nvim
- toggleterm.nvim
- tokyonight.nvim
- treesj
- trouble.nvim
- vgit.nvim
- vim-bbye
- vim-floaterm
- vim-fugitive
- vimtex
- vscode-js-debug
- wind-colors
- yanky.nvim
- zen-mode.nvim

**Disabled (20)**

- barbecue 
- clipboard-image.nvim 
- dashboard-nvim 
- flash.nvim 
- fzf.vim 
- heirline.nvim 
- image.nvim 
- lir.nvim 
- mini.indentscope 
- modes.nvim 
- noice.nvim 
- nvim-colorizer.lua 
- nvim-jdtls 
- nvim-notify 
- oil.nvim 
- persistence.nvim 
- statuscol.nvim 
- tabby.nvim 
- ultimate-autopair.nvim 
- vim-dirvish 


</details>

## Credits

These are some of the repos I have borrowed ideas from for my Neovim config (although, there are many others that I can't keep tracked of, unfortunately):

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [ChristianChiarulli/lvim](https://github.com/ChristianChiarulli/lvim)
- [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- [tjdevries/config_manager](https://github.com/tjdevries/config_manager)
- [joshmedeski/dotfiles](https://github.com/joshmedeski/dotfiles)
- [jonhoo/configs](https://github.com/jonhoo/configs)
- [Ben Frain's config](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)
- [nyoom-engineering/nyoom.nvim](https://github.com/nyoom-engineering/nyoom.nvim)
- [MariaSolOs/dotfiles](https://github.com/MariaSolOs/dotfiles)
