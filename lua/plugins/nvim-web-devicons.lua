return {
  "nvim-tree/nvim-web-devicons",
  opts = function()
    return { override = require("utils").devicons_override }
  end,
}
