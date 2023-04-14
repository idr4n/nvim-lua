# Neovim Configuration

This is my Neovim configuation written in Lua.

![neovim-29-01-23](https://user-images.githubusercontent.com/20104703/215353617-bdfe080a-c970-441d-b43f-c92a19bf1a41.png)
![Nvim 2023-04-14 at 23 06 40@2x](https://user-images.githubusercontent.com/20104703/232145344-94c51832-1561-444d-9c52-f593816eb987.png)
![Nvim 2023-04-14 at 23 14 22@2x](https://user-images.githubusercontent.com/20104703/232146316-04a7f321-6bd8-4d56-92da-7df87b16f7e0.png)

## Basic setup

- **Preferred themes**: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim), [catppuccin/nvim](https://github.com/catppuccin/nvim), [projekt0n/github-nvim-theme](https://github.com/projekt0n/github-nvim-theme), and [loctvl842/monokai-pro.nvim](https://github.com/loctvl842/monokai-pro.nvim).
- **I am using my own statusline**, as an alternative to Lualine, as I found it easier to customize it for my own needs. Lualine, however, is as excellent alternative. The theme I try to follow for my statusline is closed to **[Doom Emacs modeline](https://github.com/seagle0128/doom-modeline)**.
- **Terminals**: WezTerm (alternatively Alacritty and Kitty). To check my terminals configuration, take a look at my [dotfiles](https://github.com/idr4n/.dotfiles) and my [WezTerm configuration](https://github.com/idr4n/wezterm).
- **Font**: I switch back and forth between [FiraCode](https://github.com/tonsky/FiraCode) and [MonoLisa](https://www.monolisa.dev/).
- I'm using **[lazy.nvim](https://github.com/folke/lazy.nvim) as my package manager**, which allows me to start Neovim in around 30ms⚡️.
 
## List of current plugins (not necessarily updated!)

<details>
<summary>
This is the list of plugins I currently have installed, based on the Lazy.nvim's report.
</summary>

**Loaded (5)**

- alpha-nvim
- lazy.nvim
- tokyonight.nvim
- vim-symlink
- which-key.nvim

**Not Loaded (79)**

- Comment.nvim
- LuaSnip
- catppuccin 
- clipboard-image.nvim
- close-buffers.nvim
- cmp-buffer
- cmp-cmdline
- cmp-nvim-lsp
- cmp-nvim-lua
- cmp-path
- cmp_luasnip
- code_runner.nvim
- diffview.nvim
- emmet-vim
- friendly-snippets
- fzf
- fzf-lua
- fzf.vim
- github-nvim-theme
- gitsigns.nvim
- glance.nvim
- gruvbox-material
- harpoon
- incline.nvim
- indent-blankline.nvim
- lf.vim
- mason-lspconfig.nvim
- mason.nvim
- monokai-pro.nvim
- neo-tree.nvim
- neogit
- nui.nvim
- null-ls.nvim
- nvim-autopairs
- nvim-cmp
- nvim-colorizer.lua
- nvim-dap
- nvim-dap-go
- nvim-dap-python
- nvim-dap-ui
- nvim-jdtls
- nvim-lspconfig
- nvim-markdown
- nvim-treesitter
- nvim-treesitter-context
- nvim-treesitter-textobjects
- nvim-ts-autotag
- nvim-ts-context-commentstring
- nvim-ufo
- nvim-web-devicons
- one-small-step-for-vimkind
- playground
- plenary.nvim
- popup.nvim
- promise-async
- rust-tools.nvim
- sqls.nvim
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

**Disabled (8)**

- barbecue
- lualine.nvim
- modes.nvim
- noice.nvim
- nvim-navic
- nvim-notify
- statuscol.nvim
- vim-dirvish

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
