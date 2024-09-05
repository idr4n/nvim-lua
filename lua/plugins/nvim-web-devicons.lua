return {
  "nvim-tree/nvim-web-devicons",
  enabled = false,
  opts = function()
    return { override = require("utils").devicons_override }
  end,
}
