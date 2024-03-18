return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  enabled = false,
  opts = function()
    local function pre_save()
      -- remove buffers whose files are located outside of cwd
      local cwd = vim.fn.getcwd() .. "/"
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local bufpath = vim.api.nvim_buf_get_name(buf) .. "/"
        if not bufpath:match("^" .. vim.pesc(cwd)) then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end
    return {
      options = vim.opt.sessionoptions:get(),
      pre_save = pre_save,
    }
  end,
    -- stylua: ignore
    keys = {
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
}
