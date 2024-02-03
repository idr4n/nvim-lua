local M = {}

local utils = require("heirline.utils")
local conditions = require("heirline.conditions")
local provider = require("utils.status.provider")
local mode_setup = require("utils.status").mode_setup
local diagnostic_icons = require("utils").diagnostic_icons
local git_icons = require("utils").git_icons

--- Heirline Component
---@class Component
---@field init? fun(self:table): any
---@field status? table
---@field provider? string|number|fun(self:table):string|number|nil
---@field condition? fun(self:table): boolean
---@field hl? table|string|fun(self: table):table|string|nil
---@field update? fun(self:table):boolean|string|table

--- Basic styling opts
---@class Opts
---@field sep? Sep
---@field margin? Margin

--- Section component opts
---@class SectionOpts: Opts
---@field children? Component[]
---@field update? fun(self:table):boolean|string|table
---@field condition? fun(self:table): boolean
---@field padding? Padding
---@field hl? table|string|fun(self: table):table|string|nil

--- Delimeter component opts
---@class DelimeterOpts: Opts
---@field color? SimpleColor
---@field char string

---@alias Sep {left:string, right:string}|nil left and right separators
---@alias Margin {left:integer, right:integer}|nil
---@alias Padding {left:integer, right:integer}|nil
---@alias SimpleColor {fg:string, bg:string, bold:boolean}

--- Adds margin and separators to a component
---@param c Component
---@param opts? Opts
---@return Component
local function styler(c, opts)
  opts = vim.tbl_deep_extend("force", {
    sep = { left = "", right = "" },
    margin = { left = 1, right = 1 },
  }, opts or {}) --[[@as Opts]]

  local left_margin = string.rep(" ", opts.margin.left)
  local right_margin = string.rep(" ", opts.margin.right)

  c = utils.surround({ opts.sep.left, opts.sep.right }, nil, c)
  return utils.surround({ left_margin, right_margin }, nil, c)
end

---@param opts? Opts styling options
---@return Component # Component with original conditions
local function build(c, opts)
  ---@type Component
  local built = styler(c, opts)
  built.condition = c.condition
  return built
end

--- Align component
---@type Component
M.Align = { provider = "%=" }

--- Section Block with Mode background
---@param opts? SectionOpts
---@return Component # heirline component
function M.SectionModeBg(opts)
  opts = opts or {}
  local Setup = mode_setup(opts)

  ---@type Component
  local c = utils.insert(Setup, opts.children)
  c.update = opts.update
  return build(c, opts)
end

--- Section Block with Mode background
---@param opts? SectionOpts
---@return table # heirline component
function M.SectionModeFg(opts)
  opts = opts or {}
  local Setup = mode_setup(opts, true)

  ---@type Component
  local c = utils.insert(Setup, opts.children)
  c.update = opts.update
  return build(c, opts)
end

--- Section Block with Mode background
---@param opts? SectionOpts
---@return table # heirline component
function M.Section(opts)
  opts = vim.tbl_deep_extend("force", {
    padding = { left = 0, right = 0 },
    margin = { left = 0, right = 0 },
    children = {},
  }, opts or {}) --[[@as SectionOpts]]

  ---@type Component
  local c = {
    { provider = string.rep(" ", opts.padding.left) },
    opts.children,
    { provider = string.rep(" ", opts.padding.right) },
    update = opts.update,
    condition = opts.condition,
    hl = opts.hl,
  }
  return build(c, opts)
end

---@param opts? DelimeterOpts
function M.Delimeter(opts)
  opts = vim.tbl_deep_extend("force", {
    margin = { left = 0, right = 0 },
    color = { bg = "status_bg", fg = "" },
  }, opts or {}) --[[@as DelimeterOpts]]
  local bg_color = opts.color.bg
  local fg_color = opts.color.fg
  local is_mode = bg_color == "mode" or fg_color == "mode"

  -- remove default margins
  -- opts.margin = opts.margin or {}
  -- opts.margin.left = opts.margin.left or 0
  -- opts.margin.right = opts.margin.right or 0

  local ModeModifier = mode_setup(opts, fg_color == "mode")
  local Modifier = {
    hl = { bg = bg_color, fg = fg_color },
  }
  local Delimeter = { provider = opts.char }

  if is_mode then
    return build(utils.insert(ModeModifier, Delimeter), opts)
  end
  return build(utils.insert(Modifier, Delimeter), opts)
end

--- Charcode
---@param opts? Opts
function M.CharCode(opts)
  local CharCode = {
    provider = "Ux%04B",
  }
  return build(CharCode, opts)
end

--- Diagnostics
---@param opts? {seg:Sep, margin:Margin, hl:table|string|fun(self: table):table|string|nil}
---@return table
function M.Diagnostics(opts)
  opts = opts or {}
  local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
      error_icon = diagnostic_icons.Error,
      warn_icon = diagnostic_icons.Warn,
      info_icon = diagnostic_icons.Info,
      hint_icon = diagnostic_icons.Hint,
    },
    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    -- update = { "DiagnosticChanged", "BufEnter" }, -- handled as autcmd instead,
    hl = opts.hl or {},
    {
      provider = function(self)
        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
      end,
      hl = { fg = "diag_error" },
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
      end,
      hl = { fg = "diag_warn" },
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info .. " ")
      end,
      hl = { fg = "diag_info" },
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
      end,
      hl = { fg = "diag_hint" },
    },
  }

  return build(Diagnostics, opts)
end

--- Diagnostics
---@param opts? Opts
---@return table
function M.DiagnosticsTabline(opts)
  opts = opts or {}
  local Diagnostics = {
    static = {
      error_icon = diagnostic_icons.Error,
      warn_icon = diagnostic_icons.Warn,
      info_icon = diagnostic_icons.Info,
      hint_icon = diagnostic_icons.Hint,
    },

    -- fallthrough = false,

    {
      condition = function(self)
        return self.errors > 0
      end,
      provider = function(self)
        return self.error_icon .. self.errors .. ((self.warnings or self.info or self.hints) and " " or "")
      end,
      hl = function(self)
        return self.is_active and { fg = "diag_error" }
      end,
    },
    {
      condition = function(self)
        return self.warnings > 0
      end,
      provider = function(self)
        return self.warn_icon .. self.warnings .. ((self.info or self.hints) and " " or "")
      end,
      hl = function(self)
        return self.is_active and { fg = "diag_warn" }
      end,
    },
    {
      condition = function(self)
        return self.info > 0
      end,
      provider = function(self)
        return self.info_icon .. self.info .. (self.hints and " " or "")
      end,
      hl = function(self)
        return self.is_active and { fg = "diag_info" }
      end,
    },
    {
      condition = function(self)
        return self.hints > 0
      end,
      provider = function(self)
        return self.hint_icon .. self.hints
      end,
      hl = function(self)
        return self.is_active and { fg = "diag_hint" }
      end,
    },
    -- { provider = " " },
  }

  return build(Diagnostics, opts)
end

--- File Icon component
M.FileIcon = {
  static = { devicons = require("nvim-web-devicons") },
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = self.devicons.get_icon_color(filename, extension, { default = true })
    if self.buftype == "terminal" then
      self.icon = ""
      self.icon_color = "orange"
    elseif self.filetype == "sh" then
      self.icon = ""
      self.icon_color = "blue"
    end
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

--- File name with icon component
---@param opts? Opts
function M.FileNameBlock(opts)
  local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
      self.buftype = vim.bo.buftype
      self.filetype = vim.bo.filetype
      self.filedir = vim.fn.expand("%:p:h")
      self.filename = vim.fn.expand("%:t")
      self.path = vim.api.nvim_buf_get_name(0)
    end,
  }
  local FileDir = {
    provider = provider.pretty_dirpath(),
  }
  local FileName = {
    provider = function(self)
      return self.filename
    end,
  }
  local FileFlags = {
    {
      condition = function(self)
        return vim.bo.modified and self.buftype ~= "prompt"
      end,
      provider = "  ",
      hl = { fg = "constant" },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = " ",
      hl = { fg = "orange" },
    },
  }
  local FileNameModifer = {
    hl = function()
      if vim.bo.modified then
        -- use `force` because we need to override the child's hl foreground
        return { fg = "constant", bold = true, force = true }
      end
    end,
  }
  FileNameBlock = utils.insert(
    FileNameBlock,
    M.FileIcon,
    FileDir,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
  )
  return build(FileNameBlock, opts)
end

--- Git Branch
---@param opts? Opts
---@return table
function M.GitBranch(opts)
  local GitBranch = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      -- self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    provider = provider.git_branch,
  }
  return build(GitBranch, opts)
end

-- Git Diff
---@param opts? Opts
---@return table
function M.GitDiff(opts)
  local Git = {
    condition = function()
      local status_dict = vim.b.gitsigns_status_dict
      return status_dict and (status_dict.added ~= 0 or status_dict.removed ~= 0 or status_dict.changed ~= 0)
    end,
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
    end,
    static = {
      added_icon = git_icons.added,
      modified_icon = git_icons.modified,
      removed_icon = git_icons.removed,
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and (self.added_icon .. count .. " ")
      end,
      hl = { fg = "git_add" },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and (self.modified_icon .. count .. " ")
      end,
      hl = { fg = "git_change" },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and (self.removed_icon .. count .. " ")
      end,
      hl = { fg = "git_del" },
    },
  }

  return build(Git, opts)
end

-- Git Diff Simple
---@param opts? {seg:Sep, margin:Margin, hl:table|string|fun(self: table):table|string|nil}
---@return table
function M.GitDiffSimple(opts)
  opts = opts or {}
  local Git = {
    init = function(self)
      self.hunks = require("gitsigns").get_hunks()
      self.nhunks = self.hunks and #self.hunks
      self.status_dict = vim.b.gitsigns_status_dict
      local added = self.status_dict.added or 0
      local removed = self.status_dict.removed or 0
      local changed = self.status_dict.changed or 0
      self.changes = self.status_dict and (added + removed + changed)
    end,
    condition = function()
      local status_dict = vim.b.gitsigns_status_dict
      return status_dict and (status_dict.added ~= 0 or status_dict.removed ~= 0 or status_dict.changed ~= 0)
    end,
    static = {
      -- added_icon = "",
      -- modified_icon = "",
      -- removed_icon = "",
      added_icon = "+",
      modified_icon = "~",
      removed_icon = "-",
    },

    hl = opts.hl or {},

    -- components
    { provider = " " },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        -- return count > 0 and self.added_icon
        return count > 0 and (self.added_icon .. count .. " ")
      end,
      -- hl = { fg = "#A7C080" },
      hl = { fg = "git_add" },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        -- return count > 0 and self.modified_icon
        return count > 0 and (self.modified_icon .. count .. " ")
      end,
      -- hl = { fg = "#DBBC7F" },
      hl = { fg = "git_change" },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        -- return count > 0 and self.removed_icon
        return count > 0 and (self.removed_icon .. count .. " ")
      end,
      -- hl = { fg = "#E67E80" },
      hl = { fg = "git_del" },
    },
    {
      provider = function(self)
        -- return self.changes and " " .. self.changes .. string.format("(%s)", self.nhunks)
        return self.changes and string.format("(%s)", self.nhunks)
      end,
    },
    { provider = " " },
  }

  return build(Git, opts)
end

--- Hidden statusline
M.Hidden = {
  hl = "Normal",
  provider = " %=",
}

--- LSP component
---@alias LspOpts {icon:string, clients_total:boolean, seg:Sep, margin:Margin, hl:table|string|fun(self: table):table|string|nil}
---@param opts? LspOpts
function M.LSPActive(opts)
  opts = vim.tbl_deep_extend("force", { icon = " ", clients_total = true }, opts or {}) --[[@as LspOpts]]
  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },

    -- You can keep it simple,
    -- provider = " [L]",

    provider = function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      return opts.icon .. (opts.clients_total and #clients or "")
    end,

    -- Or complicate things a bit and get the servers names
    -- provider = function()
    --   local names = {}
    --   for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    --     table.insert(names, server.name)
    --   end
    --   return " [" .. table.concat(names, " ") .. "]"
    -- end,
    hl = opts.hl or { fg = "#538797" },
  }

  return build(LSPActive, opts)
end

--- Mode component
---@param opts? Opts
function M.Mode(opts)
  local Setup = mode_setup()
  local ViMode = {
    provider = provider.mode,
    hl = function(self)
      local cur_mode = self.mode:sub(1, 1) -- get only the first mode character
      return { bg = self.mode_colors[cur_mode], bold = true }
    end,
  }

  return build(utils.insert(Setup, ViMode), opts)
end

-- Ruler component
---@param opts? Opts
function M.Location(opts)
  local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%3l:%-2c",
  }
  return build(Ruler, opts)
end

-- Scrollbar component
---@param opts? Opts
function M.Scrollbar(opts)
  local ScrollBar = {
    static = {
      sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    },
    provider = provider.scrollbar,
  }
  return build(ScrollBar, opts)
end

--- Search count component
---@param opts? Opts
---@return Component
function M.SearchCount(opts)
  local SearchCount = {
    condition = function()
      return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
    end,
    provider = provider.search_count,
  }
  return build(SearchCount, opts)
end

--- Space component
---@param num? integer
---@return Component
function M.Space(num)
  local Space = { provider = " " }
  num = num or 1
  local opts = { margin = { left = num, right = 0 } }
  return build(Space, opts)
end

--- Special status line component
---@param opts? Opts
---@return Component
function M.Special(opts)
  local Special = {
    init = function(self)
      self.filetype = vim.bo.filetype
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
    provider = provider.special,
    hl = { bg = "blue", fg = "black", bold = true },
  }

  return build(Special, opts)
end

--- Noice status command
---@param opts? Opts
---@return Component
function M.StatusCmd(opts)
  local Updates = {
    provider = function()
      return require("noice").api.status.command.get()
    end,
    condition = function()
      return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    hl = { fg = "purple" },
  }
  return build(Updates, opts)
end

--- Noice status mode
---@param opts? Opts
---@return Component
function M.StatusMode(opts)
  local Updates = {
    provider = function()
      return require("noice").api.status.mode.get()
    end,
    condition = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
  }
  return build(Updates, opts)
end

-- Time
---@param opts? Opts
---@return Component
function M.Time(opts)
  local Time = {
    provider = function()
      return "  " .. os.date("%R") .. " "
    end,
  }
  return build(Time, opts)
end

--- Package updates
---@param opts? Opts
---@return Component
function M.Updates(opts)
  local Updates = {
    provider = require("lazy.status").updates,
    condition = require("lazy.status").has_updates,
    hl = { fg = "cyan" },
  }
  return build(Updates, opts)
end

return M
