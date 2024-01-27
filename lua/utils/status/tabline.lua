local M = {}

local ut = require("utils")
local utils = require("heirline.utils")
local component = require("utils.status.component")

local filename_modified = function(self)
  -- self.filename is defined later in the TablineFileNameBlock init function
  local filename = self.filename
  -- check if there are othe buffers with the same file name
  if ut.buf_in_buflist(ut.get_bufs(), self.bufnr) then
    filename = vim.fn.fnamemodify(filename, ":p:h:t") .. "/" .. vim.fn.fnamemodify(filename, ":t")
  else
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
  end

  return filename
end

---@param opts? {no_number:boolean}
local TablineBufnr = function(opts)
  opts = opts or {}
  return {
    provider = function(self)
      return opts.no_number and " " or tostring(self.bufnr) .. ". "
    end,
    hl = "Comment",
  }
end

local TablineFileName = {
  provider = function(self)
    -- both filename_modified is defined in the TablineFileNameBlock init function
    return self.filename_modified
  end,
  -- hl = function(self)
  --   return { bold = self.is_active or self.is_visible, italic = false }
  -- end,
}

local TablineFileFlags = {
  component.DiagnosticsTabline({ margin = { right = 0 } }),
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
        or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,
    provider = function(self)
      if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
        return "  "
      else
        return " "
      end
    end,
    hl = { fg = "orange" },
  },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    self.buftype = vim.api.nvim_get_option_value("buftype", { buf = self.bufnr })
    self.filetype = vim.api.nvim_get_option_value("filetype", { buf = self.bufnr })
    self.filename_modified = filename_modified(self)
    self.diag_chars = 0
    self.padding = ut.calculate_padding(self.filename_modified, 14 - self.diag_chars)

    self.errors = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.INFO })

    if self.errors and self.errors > 0 then
      self.diag_chars = self.diag_chars + 2
      self.filename_color = "diag_error"
    elseif self.warnings and self.warnings > 0 then
      self.diag_chars = self.diag_chars + 2
      self.filename_color = "diag_warn"
    elseif self.info and self.info > 0 then
      self.diag_chars = self.diag_chars + 2
      self.filename_color = "diag_info"
    elseif self.hints and self.hints > 0 then
      self.diag_chars = self.diag_chars + 2
      self.filename_color = "diag_hint"
    else
      self.filename_color = "normal_fg"
    end
  end,

  hl = function(self)
    if self.is_active then
      return { bg = "normal_bg", fg = self.filename_color }
      -- return { bg = "active_tab_bg", fg = self.filename_color }
    else
      return { fg = "comment", bg = "dark_black" }
    end
  end,

  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then -- close on mouse middle click
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },

  -- components
  {
    provider = function(self)
      return self.padding
    end,
  },
  TablineBufnr({ no_number = true }),
  {
    hl = function(self)
      return not self.is_active and { fg = "comment", force = true }
    end,
    component.FileIcon,
  },
  TablineFileName,
  TablineFileFlags,
  {
    provider = function(self)
      return self.padding
    end,
  },
}

local TablineCloseButton = {
  fallthrough = false,
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = " ● ",
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = " 󰅖 ",
    hl = function(self)
      return not self.is_active and { fg = "comment" } or { fg = "#B55A67" }
    end,
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
          vim.cmd.redrawtabline()
        end)
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_close_buffer_callback",
    },
  },
}

local TablineBufferBlock = utils.surround({ "", "" }, function(self)
  if self.is_active then
    return "normal_bg"
    -- return "active_tab_bg"
  else
    return "dark_black"
  end
end, { TablineFileNameBlock, TablineCloseButton })

M.BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
  { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
)

M.TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == "neo-tree" then
      self.title = "Neo-tree"
      return true
      -- elseif vim.bo[bufnr].filetype == "TagBar" then
      --     ...
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,

  -- hl = { fg = "blue", bg = "normal_bg" },
  -- hl = { fg = "blue", bg = "status_bg" },
  hl = "NeoTreeNormal",
  -- hl = function(self)
  --   if vim.api.nvim_get_current_win() == self.winid then
  --     -- return "TablineSel"
  --     return { fg = "blue", bg = "normal_bg" }
  --   else
  --     -- return "Tabline"
  --     return { fg = "comment", bg = "normal_bg" }
  --   end
  -- end,
}

return M
