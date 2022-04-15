-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/iduran/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/iduran/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/iduran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/iduran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/iduran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { 'require("setup.luasnip")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { 'require("setup.alpha")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["emmet-vim"] = {
    config = { 'require("setup.emmet-vim")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-lua"] = {
    config = { 'require("setup.fzf-lua")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["fzf.vim"] = {
    config = { 'require("setup.fzf")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("setup.gitsigns")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { 'require("setup.hop")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { 'require("setup.indent-blankline")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("setup.lualine")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["nightfox.nvim"] = {
    config = { 'require("setup.nightfox")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nnn.nvim"] = {
    config = { 'require("setup.nnn")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nnn.nvim",
    url = "https://github.com/luukvbaal/nnn.nvim"
  },
  ["null-ls.nvim"] = {
    config = { 'require("setup.null-ls")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { 'require("setup.nvim-autopairs")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "tabout.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-jdtls"] = {
    config = { 'require("setup.jdtls")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { 'require("setup.tree")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { 'require("setup.treesitter")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { 'require("setup.textobjects")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["symbols-outline.nvim"] = {
    config = { 'require("setup.outline")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["tabout.nvim"] = {
    config = { 'require("setup.tabout")' },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    url = "https://github.com/abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("setup.telescope")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { 'require("setup.toggleterm")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { 'require("setup.tokyonight")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dirvish"] = {
    config = { 'require("setup.dirvish")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-dirvish-git"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-dirvish-git",
    url = "https://github.com/kristijanhusak/vim-dirvish-git"
  },
  ["vim-easyclip"] = {
    config = { 'require("setup.easyclip")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-easyclip",
    url = "https://github.com/svermeulen/vim-easyclip"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-hexokinase"] = {
    config = { 'require("setup.hexokinase")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-hexokinase",
    url = "https://github.com/rrethy/vim-hexokinase"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-markdown"] = {
    config = { 'require("setup.vim-markdown")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/preservim/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-symlink"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-symlink",
    url = "https://github.com/aymericbeaumet/vim-symlink"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    config = { 'require("setup.vim-visual-multi")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["zen-mode.nvim"] = {
    config = { 'require("setup.zen-mode")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  },
  ["zenbones.nvim"] = {
    config = { 'require("setup.zenbones")' },
    loaded = true,
    path = "/Users/iduran/.local/share/nvim/site/pack/packer/start/zenbones.nvim",
    url = "https://github.com/mcchrish/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
require("setup.null-ls")
time([[Config for null-ls.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require("setup.luasnip")
time([[Config for LuaSnip]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
require("setup.fzf-lua")
time([[Config for fzf-lua]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
require("setup.vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
require("setup.alpha")
time([[Config for alpha-nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
require("setup.fzf")
time([[Config for fzf.vim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
require("setup.zen-mode")
time([[Config for zen-mode.nvim]], false)
-- Config for: symbols-outline.nvim
time([[Config for symbols-outline.nvim]], true)
require("setup.outline")
time([[Config for symbols-outline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require("setup.gitsigns")
time([[Config for gitsigns.nvim]], false)
-- Config for: zenbones.nvim
time([[Config for zenbones.nvim]], true)
require("setup.zenbones")
time([[Config for zenbones.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
require("setup.hop")
time([[Config for hop.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require("setup.treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-dirvish
time([[Config for vim-dirvish]], true)
require("setup.dirvish")
time([[Config for vim-dirvish]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require("setup.indent-blankline")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-treesitter-textobjects
time([[Config for nvim-treesitter-textobjects]], true)
require("setup.textobjects")
time([[Config for nvim-treesitter-textobjects]], false)
-- Config for: vim-hexokinase
time([[Config for vim-hexokinase]], true)
require("setup.hexokinase")
time([[Config for vim-hexokinase]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("setup.cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require("setup.tree")
time([[Config for nvim-tree.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("setup.telescope")
time([[Config for telescope.nvim]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
require("setup.vim-markdown")
time([[Config for vim-markdown]], false)
-- Config for: vim-easyclip
time([[Config for vim-easyclip]], true)
require("setup.easyclip")
time([[Config for vim-easyclip]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
require("setup.toggleterm")
time([[Config for toggleterm.nvim]], false)
-- Config for: nvim-jdtls
time([[Config for nvim-jdtls]], true)
require("setup.jdtls")
time([[Config for nvim-jdtls]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require("setup.nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: emmet-vim
time([[Config for emmet-vim]], true)
require("setup.emmet-vim")
time([[Config for emmet-vim]], false)
-- Config for: nightfox.nvim
time([[Config for nightfox.nvim]], true)
require("setup.nightfox")
time([[Config for nightfox.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
require("setup.tokyonight")
time([[Config for tokyonight.nvim]], false)
-- Config for: nnn.nvim
time([[Config for nnn.nvim]], true)
require("setup.nnn")
time([[Config for nnn.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd tabout.nvim ]]

-- Config for: tabout.nvim
require("setup.tabout")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'lualine.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
