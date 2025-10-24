local util = require("lspconfig.util")

return {
  cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
  root_dir = util.root_pattern("Gemfile", ".git", "."),
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
}
